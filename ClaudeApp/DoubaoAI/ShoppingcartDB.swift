//
//  ShoppingcartDB.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/19.
//

import SwiftUI

struct WealthShoppingCartView: View {
    // 模拟数据模型
    struct InsuranceProduct: Identifiable {
        let id = UUID()
        let reportNumber: String
        let createDate: String
        let expireDays: Int
        let productName: String
        let subtype: String
        let riskLevel: Int
        let policyNumber: String
        let firstPremium: String
        let status: String
        let salesCities: [String]
        let warning: String?
    }
    
    // 假数据
    let products: [InsuranceProduct] = [
        InsuranceProduct(
            reportNumber: "241224 - 1535798",
            createDate: "2024年12月24日创建",
            expireDays: 29,
            productName: "都会鑫福终身寿险",
            subtype: "普通型",
            riskLevel: 0,
            policyNumber: "SH7700001021",
            firstPremium: "CNY 30,000.00",
            status: "待确认",
            salesCities: ["南京市", "宁波市", "上海市", "天津市", "无锡市", "重庆市"],
            warning: "您的保险产品的投保申请尚未完成，即将失效，请于今日24:00点前完成确认。"
        ),
        InsuranceProduct(
            reportNumber: "241224 - 1535782",
            createDate: "2024年12月24日创建",
            expireDays: 29,
            productName: "汇丰尊盈世代终身寿险",
            subtype: "分红型",
            riskLevel: 1,
            policyNumber: "SH8800002032",
            firstPremium: "CNY 50,000.00",
            status: "待确认",
            salesCities: ["北京市", "广州市", "深圳市", "杭州市"],
            warning: nil
        )
    ]
    
    // 选中状态
    @State private var selectedProducts = Set<UUID>()
    @State private var selectAll = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // 提示条
                    Text("您当前的风险评估结果与以下产品匹配")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // 产品列表
                    ForEach(products) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            // 报告信息
                            HStack {
                                Text("个人规划报告/财富管理需求概要")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(product.reportNumber)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            // 创建日期和过期信息
                            HStack {
                                Text(product.createDate)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(product.expireDays)天后过期")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                            
                            // 产品类型
                            Text("保险产品")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding(.vertical, 4)
                            
                            // 产品信息行
                            HStack(alignment: .top, spacing: 12) {
                                // 选择框
                                Button {
                                    if selectedProducts.contains(product.id) {
                                        selectedProducts.remove(product.id)
                                    } else {
                                        selectedProducts.insert(product.id)
                                    }
                                } label: {
                                    Image(systemName: selectedProducts.contains(product.id) ? "circle.inset.filled" : "circle")
                                        .foregroundColor(.blue)
                                }
                                
                                // 产品详情
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("人寿保险-终身寿险")
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    HStack {
                                        Text(product.productName)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("风险水平 \(product.riskLevel)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        Text(product.subtype)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text("投保单号: \(product.policyNumber)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        Text("首期保费 \(product.firstPremium)")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text(product.status)
                                            .font(.subheadline)
                                            .foregroundColor(.orange)
                                    }
                                    
                                    Text("销售城市 \(product.salesCities.joined(separator: ","))")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            // 警告提示
                            if let warning = product.warning {
                                HStack(spacing: 6) {
                                    Image(systemName: "info.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.subheadline)
                                    Text(warning)
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                                .padding(8)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                    
                    // 产品数量提示
                    HStack {
                        Text("共\(products.count)个产品")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "chevron.up")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical, 16)
            }
            .background(Color(.systemGray6))
            .navigationTitle("财富购物车")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 顶部工具栏
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // 返回按钮动作
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Button {
                            // 帮助按钮动作
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.primary)
                        }
                        
                        Button {
                            // 列表按钮动作
                        } label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                // 底部工具栏
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        // 全选按钮
                        Button {
                            selectAll.toggle()
                            if selectAll {
                                selectedProducts = Set(products.map { $0.id })
                            } else {
                                selectedProducts.removeAll()
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: selectAll ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.blue)
                                Text("全选")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                        }
                        
                        Spacer()
                        
                        Text("已选\(selectedProducts.count)个产品")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        // 下单按钮
                        Button {
                            // 下单按钮动作
                        } label: {
                            Text("下单")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.red)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                }
            }
            // 顶部提示框
            .overlay(
                Text("您可在此查看交易必读的产品文件")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(4)
                    .padding(.top, 60)
                    .padding(.horizontal, 20),
                alignment: .top
            )
        }
    }
}

// 预览
struct WealthShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        WealthShoppingCartView()
    }
}
