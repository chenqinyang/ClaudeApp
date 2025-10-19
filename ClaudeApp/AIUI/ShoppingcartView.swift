//
//  ShoppingcartView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/19.
//

import SwiftUI

struct InsuranceProduct: Identifiable {
    let id = UUID()
    let documentTitle: String
    let documentNumber: String
    let createDate: String
    let expiryDays: Int
    let productName: String
    let productSubtitle: String
    let riskLevel: Int
    let productType: String
    let policyNumber: String
    let premium: Double
    let status: String
    let cities: String
    let warningMessage: String
    let totalProducts: Int
}

struct ShoppingCartView: View {
    @State private var selectedProducts: Set<UUID> = []
    @State private var showTooltip = true
    @State private var selectAll = false
    
    let mockProducts = [
        InsuranceProduct(
            documentTitle: "个人规划报告/财富管理需求概要",
            documentNumber: "241224 - 1535798",
            createDate: "2024年12月24日创建",
            expiryDays: 29,
            productName: "人寿保险-终身寿险",
            productSubtitle: "都会鑫福终身寿险",
            riskLevel: 0,
            productType: "普通型",
            policyNumber: "SH7700001021",
            premium: 30000.00,
            status: "待确认",
            cities: "南京市,宁波市,上海市,天津市,无锡市,重庆市",
            warningMessage: "您的保险产品的投保申请尚未完成，即将失效，请于今日24：00点前完成确认。",
            totalProducts: 1
        ),
        InsuranceProduct(
            documentTitle: "个人规划报告/财富管理需求概要",
            documentNumber: "241224 - 1535782",
            createDate: "2024年12月24日创建",
            expiryDays: 29,
            productName: "人寿保险-终身寿险",
            productSubtitle: "汇丰尊盈世代终身寿险（分红型）",
            riskLevel: 4,
            productType: "普通型",
            policyNumber: "SH7700001022",
            premium: 50000.00,
            status: "待确认",
            cities: "北京市,上海市,广州市,深圳市",
            warningMessage: "您的保险产品的投保申请尚未完成，即将失效，请于今日24：00点前完成确认。",
            totalProducts: 1
        )
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 12) {
                    // Risk level info (partially visible)
                    Text("您当前的风险承受能力等级为")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, showTooltip ? 50 : 8)
                    
                    // Product Cards
                    ForEach(mockProducts) { product in
                        ProductCard(
                            product: product,
                            isSelected: selectedProducts.contains(product.id)
                        ) {
                            toggleSelection(product.id)
                        }
                    }
                }
                .padding(.bottom, 80)
            }
            .background(Color(UIColor.systemGray6))
            
            // Tooltip
            if showTooltip {
                VStack {
                    HStack {
                        Spacer()
                        TooltipView(text: "您可在此查看交易必读的产品文件") {
                            withAnimation {
                                showTooltip = false
                            }
                        }
                        .padding(.trailing, 60)
                    }
                    Spacer()
                }
                .padding(.top, 8)
            }
            
            // Bottom Action Bar
            VStack {
                Spacer()
                BottomActionBar(
                    selectAll: $selectAll,
                    selectedCount: selectedProducts.count,
                    onSelectAll: {
                        if selectAll {
                            selectedProducts = Set(mockProducts.map { $0.id })
                        } else {
                            selectedProducts.removeAll()
                        }
                    },
                    onCheckout: {
                        // Handle checkout
                    }
                )
            }
        }
        .navigationTitle("财富购物车")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.primary)
                    }
                    Button(action: {}) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
    
    private func toggleSelection(_ id: UUID) {
        if selectedProducts.contains(id) {
            selectedProducts.remove(id)
        } else {
            selectedProducts.insert(id)
        }
        selectAll = selectedProducts.count == mockProducts.count
    }
}

struct TooltipView: View {
    let text: String
    let onDismiss: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.white)
            
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.85))
        .cornerRadius(6)
        .overlay(
            Triangle()
                .fill(Color.black.opacity(0.85))
                .frame(width: 12, height: 6)
                .rotationEffect(.degrees(180))
                .offset(y: -14),
            alignment: .top
        )
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct ProductCard: View {
    let product: InsuranceProduct
    let isSelected: Bool
    let onToggle: () -> Void
    @State private var isExpanded = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Image(systemName: "doc.text")
                    .foregroundColor(.red)
                    .font(.system(size: 18))
                
                Text(product.documentTitle)
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(product.documentNumber)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .padding(16)
            
            // Date and Expiry
            HStack {
                Text(product.createDate)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(product.expiryDays)天后过期")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            Divider()
            
            // Insurance Products Section
            Text("保险产品")
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            
            Divider()
            
            // Product Details
            HStack(alignment: .top, spacing: 12) {
                Button(action: onToggle) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? Color(red: 0.2, green: 0.5, blue: 0.8) : .gray)
                }
                .padding(.top, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    // Product Name
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.productName)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Text(product.productSubtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    // Risk and Type
                    HStack(spacing: 8) {
                        Text(product.productType)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        Text("风险水平 \(product.riskLevel)")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    
                    // Policy Number
                    Text("投保单号: \(product.policyNumber)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Divider()
                        .padding(.vertical, 4)
                    
                    // Premium and Status
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("首期保费")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            Text(String(format: "CNY %.2f", product.premium))
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Text(product.status)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    // Cities
                    VStack(alignment: .leading, spacing: 4) {
                        Text("销售城市")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(product.cities)
                            .font(.system(size: 13))
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    .padding(.top, 8)
                }
            }
            .padding(16)
            
            // Warning Banner
            HStack(alignment: .top, spacing: 8) {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.8))
                    .font(.system(size: 18))
                
                Text(product.warningMessage)
                    .font(.system(size: 13))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(12)
            .background(Color(red: 0.9, green: 0.95, blue: 1.0))
            
            // Expand/Collapse
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Spacer()
                    Text("共\(product.totalProducts)个产品")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.vertical, 12)
            }
        }
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 12)
    }
}

struct BottomActionBar: View {
    @Binding var selectAll: Bool
    let selectedCount: Int
    let onSelectAll: () -> Void
    let onCheckout: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            // Select All
            Button(action: {
                selectAll.toggle()
                onSelectAll()
            }) {
                HStack(spacing: 8) {
                    Image(systemName: selectAll ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 20))
                        .foregroundColor(selectAll ? Color(red: 0.2, green: 0.5, blue: 0.8) : .gray)
                    
                    Text("全选")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                }
                .padding(.leading, 16)
            }
            
            Spacer()
            
            // Selected Count
            Text("已选\(selectedCount)个产品")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.trailing, 16)
            
            // Checkout Button
            Button(action: onCheckout) {
                Text("下单")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 56)
                    .background(
                        LinearGradient(
                            colors: [Color(red: 1.0, green: 0.5, blue: 0.5), Color(red: 1.0, green: 0.4, blue: 0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
        }
        .frame(height: 56)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 8, y: -2)
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShoppingCartView()
        }
    }
}
