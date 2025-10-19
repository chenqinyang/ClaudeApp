//
//  FundListView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/19.
//

import SwiftUI

struct FundProduct: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let riskLevel: Int
    let isNew: Bool
    let yearReturn: Double
    let minPurchase: String
    let rating: Int?
}

struct FundProductsView: View {
    @State private var searchText = ""
    @State private var selectedTab = 2
    
    let mockFunds = [
        FundProduct(code: "006533", name: "[仅电子渠道]易方达科融混合型证券投资基金|单日累计限额 10 万人民币] | 代销", riskLevel: 5, isNew: true, yearReturn: 99.30, minPurchase: "10,000 人民币", rating: 5),
        FundProduct(code: "001513", name: "[仅电子渠道]易方达信息产业混合型证券投资基金 A 类 | 代销", riskLevel: 5, isNew: true, yearReturn: 95.90, minPurchase: "10,000 人民币", rating: 5),
        FundProduct(code: "019018", name: "[仅电子渠道]易方达信息产业混合型证券投资基金 C 类 | 代销", riskLevel: 5, isNew: true, yearReturn: 94.90, minPurchase: "10,000 人民币", rating: nil)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Info Banner
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    
                    Text("基金相关产品含本行自有的代客境外理财-海外基金及本行代销的内地证券投资基金和香港互认基金。")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .lineSpacing(4)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    }
                }
                .padding(16)
                .background(Color(red: 0.3, green: 0.5, blue: 0.7))
                
                // Tab Bar
                HStack(spacing: 0) {
                    TabButton(icon: "bag", title: "我的持有", isSelected: selectedTab == 0)
                        .onTapGesture { selectedTab = 0 }
                    TabButton(icon: "clock.arrow.circlepath", title: "我的定投", isSelected: selectedTab == 1)
                        .onTapGesture { selectedTab = 1 }
                    TabButton(icon: "chart.line.uptrend.xyaxis", title: "投资者基本信息表", isSelected: selectedTab == 2)
                        .onTapGesture { selectedTab = 2 }
                    TabButton(icon: "plus.circle", title: "我的自选", isSelected: selectedTab == 3)
                        .onTapGesture { selectedTab = 3 }
                }
                .padding(.vertical, 16)
                .background(Color.white)
                
                // Risk Info Bar
                HStack(spacing: 12) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(Color(red: 0.3, green: 0.5, blue: 0.7))
                        .font(.system(size: 20))
                    
                    Text("您当前有效风险承受程度为 4")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .padding(16)
                .background(Color(UIColor.systemGray6))
                
                // Filter Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        FilterPill(title: "代客境外理财-海外基金", isSelected: true)
                        FilterPill(title: "风险水平匹配", isSelected: true)
                        
                        HStack(spacing: 6) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 14))
                            Text("筛选")
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .background(Color.white)
                
                // Sort Dropdown
                HStack {
                    Text("默认排序")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                
                Divider()
                
                // Fund List
                VStack(spacing: 0) {
                    ForEach(mockFunds) { fund in
                        FundCard(fund: fund)
                        Divider()
                            .padding(.leading, 16)
                    }
                }
                .background(Color.white)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("基金相关产品")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                    }
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct TabButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? Color(red: 0.3, green: 0.5, blue: 0.7) : .gray)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? .primary : .gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct FilterPill: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 14))
            .foregroundColor(isSelected ? .primary : .gray)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.white : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.primary : Color.gray.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(20)
    }
}

struct FundCard: View {
    let fund: FundProduct
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: {}) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                // Fund Name
                Text("\(fund.code)\(fund.name)")
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .lineSpacing(4)
                
                // Badges
                HStack(spacing: 8) {
                    Text("风险水平 \(fund.riskLevel)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(4)
                    
                    if fund.isNew {
                        Text("新产品")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(4)
                    }
                }
                
                // Fund Details
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("近1年收益")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(String(format: "+%.2f%%", fund.yearReturn))
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("起购金额")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(fund.minPurchase)
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("晨星评级")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        if let rating = fund.rating {
                            HStack(spacing: 2) {
                                ForEach(0..<rating, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                }
                            }
                        } else {
                            Text("未评级")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(16)
        .background(Color.white)
    }
}

struct FundProductsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FundProductsView()
        }
    }
}
