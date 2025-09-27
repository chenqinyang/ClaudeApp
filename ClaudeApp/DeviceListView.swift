//
//  DeviceListView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct DeviceListView: View {
    @StateObject private var viewModel = DeviceViewModel()
    @State private var showingAddDevice = false
    @State private var searchText = ""
    
    var filteredDevices: [MobileDevice] {
        if searchText.isEmpty {
            return viewModel.devices
        } else {
            return viewModel.devices.filter { device in
                device.name.localizedCaseInsensitiveContains(searchText) ||
                device.manufacturer.localizedCaseInsensitiveContains(searchText) ||
                device.city.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredDevices) { device in
                    NavigationLink(destination: DeviceDetailView(device: device, viewModel: viewModel)) {
                        DeviceRowView(device: device)
                    }
                }
                .onDelete(perform: viewModel.deleteDevices)
            }
            .searchable(text: $searchText, prompt: "Search devices")
            .navigationTitle("Mobile Devices")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddDevice = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddDevice) {
                AddDeviceView(viewModel: viewModel)
            }
            .overlay {
                if viewModel.devices.isEmpty {
                    ContentUnavailableView(
                        "No Devices",
                        systemImage: "iphone.slash",
                        description: Text("Add your first device by tapping the + button")
                    )
                }
            }
        }
    }
}
