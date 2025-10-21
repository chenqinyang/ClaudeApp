//
//  ShoppincartDS.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/10/21.
//

import SwiftUI

struct WealthCartView: View {
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 顶部标题和说明
                    VStack(alignment: .leading, spacing: 8) {
                        Text("财富购物车")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("您当前的风险承受程度为 4")
                            .font(.headline)
                        
                        Text("您可在此查看交易前必读的产品文件")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // 第一个产品区块
                    VStack(alignment: .leading, spacing: 12) {
                        // 复选框和文档信息
                        HStack(alignment: .top) {
                            Image(systemName: selectedItems.contains("doc1") ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedItems.contains("doc1") ? .blue : .gray)
                                .onTapGesture {
                                    if selectedItems.contains("doc1") {
                                        selectedItems.remove("doc1")
                                    } else {
                                        selectedItems.insert("doc1")
                                    }
                                }
                            
                            VStack(alignment: .leading) {
                                Text("个人规划报告/财富管理需求概要")
                                    .font(.headline)
                                Text("241224 - 1535798")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("2024年12月24日创建")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("29天后过期")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // 保险产品详情
                    VStack(alignment: .leading, spacing: 12) {
                        // 保险标题
                        HStack {
                            Text("人寿保险-终身寿险")
                                .font(.headline)
                            Spacer()
                            Text("都会鑫福终身寿险")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        // 风险水平
                        HStack {
                            Text("风险水平 0")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                            
                            Spacer()
                            
                            Text("普通型")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Text("投保单号: SH7700000121")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Divider()
                        
                        // 保费信息
                        VStack(alignment: .leading, spacing: 8) {
                            Text("首期保费")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("CNY 30,000.00")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("待确认")
                                    .font(.subheadline)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.orange.opacity(0.2))
                                    .foregroundColor(.orange)
                                    .cornerRadius(4)
                                
                                Spacer()
                            }
                        }
                        
                        Divider()
                        
                        // 销售城市
                        VStack(alignment: .leading, spacing: 8) {
                            Text("销售城市")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("南京市,宁波市,上海市,天津市,无锡市,重庆市")
                                .font(.subheadline)
                        }
                        
                        // 警告信息
                        Text("您的保险产品的投保申请尚未完成，即将失效，请于今日24：00点前完成确认。")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(4)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                    .padding(.horizontal)
                    
                    // 产品数量统计
                    HStack {
                        Text("共1个产品 ▼")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // 第二个文档区块
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            Image(systemName: selectedItems.contains("doc2") ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedItems.contains("doc2") ? .blue : .gray)
                                .onTapGesture {
                                    if selectedItems.contains("doc2") {
                                        selectedItems.remove("doc2")
                                    } else {
                                        selectedItems.insert("doc2")
                                    }
                                }
                            
                            VStack(alignment: .leading) {
                                Text("个人规划报告/财富管理需求概要")
                                    .font(.headline)
                                Text("241224 - 1535782")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("2024年12月24日创建")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("29天后过期")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // 第二个保险产品（简化版）
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("人寿保险-终身寿险")
                                .font(.headline)
                            Spacer()
                            Text("汇丰尊盈世代终身寿险（分红型）")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 1)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            
            // 底部下单栏
            .safeAreaInset(edge: .bottom) {
                VStack {
                    Divider()
                    HStack {
                        Text("已选\(selectedItems.count)个产品")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            // 下单操作
                        }) {
                            Text("下单")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 32)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct WealthCartView_Previews: PreviewProvider {
    static var previews: some View {
        WealthCartView()
    }
}
