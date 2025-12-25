import Foundation
import StoreKit

class CoinManager: NSObject, ObservableObject {
    static let shared = CoinManager()

    @Published var coinBalance: Int = 0
    @Published var isPurchasing: Bool = false
    @Published var purchaseError: String?

    private let userDefaults = UserDefaults.standard
    private let coinBalanceKey = "CoinBalance"
    private let coinProductID = "com.alarmlouder.coins10000"

    let coinsPerPurchase = 10000
    let coinsPerSnooze = 2000
    let purchasePrice = "$1"

    private var product: Product?

    override init() {
        super.init()
        loadCoinBalance()
        Task {
            await loadProducts()
        }
    }

    func loadCoinBalance() {
        coinBalance = userDefaults.integer(forKey: coinBalanceKey)
    }

    func saveCoinBalance() {
        userDefaults.set(coinBalance, forKey: coinBalanceKey)
    }

    func addCoins(_ amount: Int) {
        coinBalance += amount
        saveCoinBalance()
    }

    func deductCoins(_ amount: Int) -> Bool {
        guard coinBalance >= amount else {
            return false
        }
        coinBalance -= amount
        saveCoinBalance()
        return true
    }

    func hasEnoughCoinsForSnooze() -> Bool {
        return coinBalance >= coinsPerSnooze
    }

    func loadProducts() async {
        do {
            let products = try await Product.products(for: [coinProductID])
            if let product = products.first {
                await MainActor.run {
                    self.product = product
                }
            }
        } catch {
            print("Failed to load products: \(error)")
        }
    }

    func purchaseCoins() async {
        guard let product = product else {
            await MainActor.run {
                self.purchaseError = "Product not available"
            }
            return
        }

        await MainActor.run {
            self.isPurchasing = true
            self.purchaseError = nil
        }

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                switch verification {
                case .verified(let transaction):
                    await MainActor.run {
                        self.addCoins(coinsPerPurchase)
                        self.isPurchasing = false
                    }
                    await transaction.finish()

                case .unverified:
                    await MainActor.run {
                        self.purchaseError = "Purchase could not be verified"
                        self.isPurchasing = false
                    }
                }

            case .userCancelled:
                await MainActor.run {
                    self.isPurchasing = false
                }

            case .pending:
                await MainActor.run {
                    self.purchaseError = "Purchase is pending"
                    self.isPurchasing = false
                }

            @unknown default:
                await MainActor.run {
                    self.purchaseError = "Unknown error occurred"
                    self.isPurchasing = false
                }
            }
        } catch {
            await MainActor.run {
                self.purchaseError = error.localizedDescription
                self.isPurchasing = false
            }
        }
    }

    func purchaseCoinsForTesting() {
        addCoins(coinsPerPurchase)
    }

    var displayableProduct: Product? {
        return product
    }
}
