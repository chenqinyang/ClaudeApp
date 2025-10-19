//
//  Exchange.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/19.
//

import SwiftUI

struct ForexExchangeView: View {
    @State private var sellAmount = "468,646.95"
    @State private var buyAmount = "60,000.00"
    @State private var sellCurrency = "HKD"
    @State private var buyCurrency = "USD"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Sell Amount Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 16) {
                        // Sell Amount
                        VStack(alignment: .leading, spacing: 8) {
                            Text("賣出金額")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            TextField("", text: $sellAmount)
                                .font(.system(size: 32, weight: .light))
                                .keyboardType(.decimalPad)
                        }
                        
                        Spacer()
                        
                        // Currency Picker
                        VStack(alignment: .leading, spacing: 8) {
                            Text("貨幣")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text(sellCurrency)
                                    .font(.system(size: 20))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                
                // Buy Amount Section
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 16) {
                        // Buy Amount
                        VStack(alignment: .leading, spacing: 8) {
                            Text("買入金額")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            TextField("", text: $buyAmount)
                                .font(.system(size: 32, weight: .light))
                                .keyboardType(.decimalPad)
                        }
                        
                        Spacer()
                        
                        // Currency Picker
                        VStack(alignment: .leading, spacing: 8) {
                            Text("貨幣")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            HStack {
                                Text(buyCurrency)
                                    .font(.system(size: 20))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                
                // Exchange Rate
                HStack {
                    Text("1 USD")
                        .fontWeight(.medium)
                    Text("≈")
                        .foregroundColor(.gray)
                    Text("7.8108 HKD")
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "questionmark.circle")
                        .foregroundColor(.gray)
                }
                .font(.system(size: 14))
                
                Text("截至2025年10月06日 11:52 香港時間")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Coupon Section
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        ZStack(alignment: .bottomTrailing) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red)
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Text("%")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Circle()
                                        .stroke(Color.red, lineWidth: 2)
                                )
                                .overlay(
                                    Text("折")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                )
                                .offset(x: 4, y: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("使用折扣券")
                                .font(.system(size: 16, weight: .medium))
                            Text("以折扣優惠節省更多")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 16))
                        Text("折扣券不能與其他優惠同時使用。")
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(6)
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                
                // Exchange Button
                Button(action: {}) {
                    Text("立即兌換")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
                // Time Deposit Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("外匯及定期存款")
                        .font(.system(size: 18, weight: .medium))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top, spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.orange, Color.red],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 48, height: 48)
                                
                                Image(systemName: "wallet.pass.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            
                            Text("立即兌換USD並開立定期存款，可享高達8.8%的優惠年利率。")
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                                .lineSpacing(2)
                        }
                        
                        Button(action: {}) {
                            Text("兌換並開立定存")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.red)
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
            }
            .padding(16)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("外匯")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ForexExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForexExchangeView()
        }
    }
}
