//
//  DeviceViewModel.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

class DeviceViewModel: ObservableObject {
    @Published var devices: [MobileDevice] = []
    
    init() {
        loadDevices()
    }
    
    func addDevice(_ device: MobileDevice) {
        devices.append(device)
        saveDevices()
    }
    
    func updateDevice(_ device: MobileDevice) {
        if let index = devices.firstIndex(where: { $0.id == device.id }) {
            devices[index] = device
            saveDevices()
        }
    }
    
    func deleteDevice(_ device: MobileDevice) {
        devices.removeAll { $0.id == device.id }
        saveDevices()
    }
    
    func deleteDevices(at offsets: IndexSet) {
        devices.remove(atOffsets: offsets)
        saveDevices()
    }
    
    private func saveDevices() {
        if let encoded = try? JSONEncoder().encode(devices) {
            UserDefaults.standard.set(encoded, forKey: "SavedDevices")
        }
    }
    
    private func loadDevices() {
        if let data = UserDefaults.standard.data(forKey: "SavedDevices"),
           let decoded = try? JSONDecoder().decode([MobileDevice].self, from: data) {
            devices = decoded
        } else {
            // Load sample data
            devices = [
                MobileDevice(
                    name: "iPhone 15 Pro",
                    os: "iOS 17",
                    imageName: "iphone.gen3",
                    city: "San Francisco",
                    manufacturer: "Apple"
                ),
                MobileDevice(
                    name: "Samsung Galaxy S24",
                    os: "Android 14",
                    imageName: "iphone.gen2",
                    city: "Seoul",
                    manufacturer: "Samsung"
                ),
                MobileDevice(
                    name: "iPad Pro",
                    os: "iOS 17",
                    imageName: "ipad.gen2",
                    city: "New York",
                    manufacturer: "Apple"
                )
            ]
        }
    }
}
