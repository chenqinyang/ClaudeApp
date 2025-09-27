//
//  DeviceRowView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct DeviceRowView: View {
    let device: MobileDevice
    
    var body: some View {
        HStack {
            Image(systemName: device.imageName)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(device.name)
                    .font(.headline)
                HStack {
                    Label(device.manufacturer, systemImage: "building.2")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Label(device.city, systemImage: "location")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

