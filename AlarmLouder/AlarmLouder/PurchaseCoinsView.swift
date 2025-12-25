import SwiftUI
import StoreKit

struct PurchaseCoinsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var coinManager = CoinManager.shared

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()

                VStack(spacing: 16) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.orange)

                    Text("Current Balance")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text("\(coinManager.coinBalance)")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.primary)

                    Text("coins")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("How it works")
                                .font(.headline)
                        }

                        Text("Each time you hit snooze on an alarm, it costs \(coinManager.coinsPerSnooze) coins.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("This helps you fight the temptation to snooze and get up on time!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 16) {
                    if let product = coinManager.displayableProduct {
                        Button {
                            Task {
                                await coinManager.purchaseCoins()
                            }
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(coinManager.coinsPerPurchase) Coins")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("\(coinManager.coinsPerPurchase / coinManager.coinsPerSnooze) snoozes")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }

                                Spacer()

                                Text(product.displayPrice)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.orange, .red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                        }
                        .disabled(coinManager.isPurchasing)
                    } else {
                        Button {
                            coinManager.purchaseCoinsForTesting()
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(coinManager.coinsPerPurchase) Coins")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("\(coinManager.coinsPerPurchase / coinManager.coinsPerSnooze) snoozes")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }

                                Spacer()

                                Text("FREE (Testing)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.green, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                        }
                    }

                    if coinManager.isPurchasing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }

                    if let error = coinManager.purchaseError {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
            .navigationTitle("Buy Coins")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    PurchaseCoinsView()
}
