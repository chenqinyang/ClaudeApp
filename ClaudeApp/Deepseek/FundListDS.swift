//
//  FundListDS.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/21.
//

import SwiftUI

struct Fund: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let channel: String
    let riskLevel: Int
    let isNew: Bool
    let annualReturn: String
    let minPurchase: String
    let starRating: Int // 1-5
}

struct FundListView: View {
    let mockFunds = [
        Fund(code: "006533", name: "易方达科融混合型证券投资基金[单日累计限额10万人民币]", channel: "仅电子渠道", riskLevel: 5, isNew: true, annualReturn: "+99.30%", minPurchase: "10,000人民币", starRating: 5),
        Fund(code: "001513", name: "易方达信息产业混合型证券投资基金A类", channel: "仅电子渠道", riskLevel: 5, isNew: true, annualReturn: "+95.90%", minPurchase: "10,000人民币", starRating: 5),
        Fund(code: "019018", name: "易方达信息产业混合型证券投资基金C类", channel: "仅电子渠道", riskLevel: 5, isNew: true, annualReturn: "+94.90%", minPurchase: "10,000人民币", starRating: 0)
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // 顶部说明
                VStack(alignment: .leading, spacing: 8) {
                    Text("基金相关产品")
                        .font(.headline)
                    
                    Text("基金相关产品含本行自有的代客境外理财-海外基金及本行代销的内地证券投资基金和香港互认基金。")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("我的持有")
                        Text("我的定投")
                        Text("投资者基本信息表")
                        Text("我的自选")
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                    
                    Text("您当前有效风险承受程度为 4")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                .padding(.horizontal)
                
                // 筛选栏
                HStack {
                    Text("代客境外理财-海外基金")
                    Spacer()
                    Text("风险水平匹配")
                    Spacer()
                    Text("筛选")
                }
                .font(.caption)
                .padding(.horizontal)
                
                // 排序栏
                HStack {
                    Text("默认排序")
                        .font(.caption)
                    Spacer()
                }
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                
                // 基金列表
                List(mockFunds) { fund in
                    VStack(alignment: .leading, spacing: 8) {
                        // 基金代码和名称
                        HStack {
                            Text(fund.code)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            
                            Text("[\(fund.channel)]")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            if fund.isNew {
                                Text("新产品")
                                    .font(.caption)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(4)
                            }
                        }
                        
                        Text(fund.name)
                            .font(.subheadline)
                        
                        // 风险水平
                        HStack {
                            Text("风险水平\(fund.riskLevel)")
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                            
                            Spacer()
                            
                            Text("代销")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        // 收益信息
                        HStack {
                            VStack(alignment: .leading) {
                                Text("近1年收益")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(fund.annualReturn)
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("起购金额")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(fund.minPurchase)
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("晨星评级")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if fund.starRating > 0 {
                                    HStack {
                                        ForEach(0..<fund.starRating, id: \.self) { _ in
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 12))
                                        }
                                    }
                                } else {
                                    Text("未评级")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("基金产品")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FundListView_Previews: PreviewProvider {
    static var previews: some View {
        FundListView()
    }
}
