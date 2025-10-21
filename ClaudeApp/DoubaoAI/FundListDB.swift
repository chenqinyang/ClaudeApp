import SwiftUI

struct FundProductView: View {
    // 基金产品数据模型
    struct FundProduct: Identifiable {
        let id = UUID()
        let code: String
        let name: String
        let channel: String
        let type: String
        let riskLevel: Int
        let isNew: Bool
        let annualReturn: String
        let minInvestment: String
        let starRating: Int?
    }
    
    // 假数据
    let fundProducts: [FundProduct] = [
        FundProduct(
            code: "006533",
            name: "易方达科融混合型证券投资基金",
            channel: "仅电子渠道",
            type: "代销",
            riskLevel: 5,
            isNew: true,
            annualReturn: "+99.30%",
            minInvestment: "10,000人民币",
            starRating: 5
        ),
        FundProduct(
            code: "001513",
            name: "易方达信息产业混合型证券投资基金A类",
            channel: "仅电子渠道",
            type: "代销",
            riskLevel: 5,
            isNew: true,
            annualReturn: "+95.90%",
            minInvestment: "10,000人民币",
            starRating: 5
        ),
        FundProduct(
            code: "019018",
            name: "易方达信息产业混合型证券投资基金C类",
            channel: "仅电子渠道",
            type: "代销",
            riskLevel: 5,
            isNew: true,
            annualReturn: "+94.90%",
            minInvestment: "10,000人民币",
            starRating: nil
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // 蓝色提示条
                    ZStack(alignment: .trailing) {
                        Text("基金相关产品含本行自有的代客境外理财-海外基金及本行代销的内地证券投资基金和香港互认基金。")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            // 关闭提示动作
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    
                    // 功能选项卡
                    HStack(spacing: 0) {
                        TabButton(title: "我的持有", icon: "folder.fill")
                        TabButton(title: "我的定投", icon: "clock.fill")
                        TabButton(title: "投资者基本信息表", icon: "chart.bar.fill")
                        TabButton(title: "我的自选", icon: "star.fill")
                    }
                    .frame(height: 80)
                    .background(Color.white)
                    
                    // 风险承受提示
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                        Text("您当前有效风险承受程度为 4")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    
                    // 筛选标签
                    HStack(spacing: 12) {
                        Button {
                            // 代客境外理财筛选
                        } label: {
                            Text("代客境外理财-海外基金")
                                .font(.caption)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                        }
                        
                        Button {
                            // 风险水平匹配筛选
                        } label: {
                            Text("风险水平匹配")
                                .font(.caption)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                        }
                        
                        Button {
                            // 筛选按钮
                        } label: {
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                    .font(.system(size: 12))
                                Text("筛选")
                                    .font(.caption)
                            }
                            .foregroundColor(.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    
                    // 排序选项
                    HStack {
                        Text("默认排序")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    
                    // 基金列表
                    VStack(spacing: 0) {
                        ForEach(fundProducts) { product in
                            VStack {
                                HStack {
                                    // 添加按钮
                                    Button {
                                        // 添加动作
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.trailing, 8)
                                    
                                    // 基金信息
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("\(product.code)[\(product.channel)]\(product.name) | \(product.type)")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                            .lineLimit(1)
                                        
                                        HStack(spacing: 8) {
                                            Text("风险水平\(product.riskLevel)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                                .padding(4)
                                                .background(Color(.systemGray5))
                                                .cornerRadius(2)
                                            
                                            if product.isNew {
                                                Text("新产品")
                                                    .font(.caption)
                                                    .foregroundColor(.orange)
                                                    .padding(4)
                                                    .background(Color.orange.opacity(0.1))
                                                    .cornerRadius(2)
                                            }
                                        }
                                    }
                                }
                                .padding(.bottom, 8)
                                
                                // 收益信息
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("近1年收益")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(product.annualReturn)
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .center) {
                                        Text("起购金额")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(product.minInvestment)
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        Text("晨星评级")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        if let rating = product.starRating {
                                            HStack {
                                                ForEach(1...5, id: \.self) { star in
                                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                                        .foregroundColor(.yellow)
                                                        .font(.system(size: 12))
                                                }
                                            }
                                        } else {
                                            Text("未评级")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .overlay(
                                Divider()
                                    .padding(.horizontal),
                                alignment: .bottom
                            )
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("基金相关产品")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // 返回动作
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 20) {
                        Button {
                            // 搜索动作
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.primary)
                        }
                        
                        Button {
                            // 帮助动作
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
    
    // 选项卡按钮组件
    struct TabButton: View {
        let title: String
        let icon: String
        
        var body: some View {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// 预览
struct FundProductView_Previews: PreviewProvider {
    static var previews: some View {
        FundProductView()
    }
}
