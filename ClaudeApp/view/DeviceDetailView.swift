//
//  DeviceDetailView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/8/8.
//

import SwiftUI

struct DeviceDetailView: View {
    @State var device: MobileDevice
    let viewModel: DeviceViewModel
    @State private var isEditing = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Device Image
                Image(systemName: device.imageName)
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                
                // Device Information
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(title: "Device Name", value: device.name, systemImage: "iphone")
                    DetailRow(title: "Operating System", value: device.os, systemImage: "gear")
                    DetailRow(title: "Manufacturer", value: device.manufacturer, systemImage: "building.2")
                    DetailRow(title: "Location", value: device.city, systemImage: "location")
                }
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(15)
            }
            .padding()
        }
        .navigationTitle(device.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditDeviceView(device: $device, viewModel: viewModel)
        }
    }
}
