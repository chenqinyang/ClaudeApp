//
//  DetailRow.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct DetailRow: View {
    let title: String
    let value: String
    let systemImage: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
                .foregroundColor(.secondary)
                .frame(width: 150, alignment: .leading)
            Text(value)
                .font(.body)
                .fontWeight(.medium)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
