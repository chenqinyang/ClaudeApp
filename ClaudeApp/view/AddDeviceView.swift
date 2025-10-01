//
//  AddDeviceView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct AddDeviceView: View {
    @ObservedObject var viewModel: DeviceViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var selectedOS = "iOS 17"
    @State private var selectedImage = "iphone.gen3"
    @State private var city = ""
    @State private var selectedManufacturer = "Apple"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Device Information") {
                    TextField("Device Name", text: $name)
                    
                    Picker("Operating System", selection: $selectedOS) {
                        ForEach(MobileDevice.operatingSystems, id: \.self) { os in
                            Text(os).tag(os)
                        }
                    }
                    
                    Picker("Manufacturer", selection: $selectedManufacturer) {
                        ForEach(MobileDevice.manufacturers, id: \.self) { manufacturer in
                            Text(manufacturer).tag(manufacturer)
                        }
                    }
                    
                    TextField("City", text: $city)
                }
                
                Section("Device Icon") {
                    Picker("Select Icon", selection: $selectedImage) {
                        ForEach(MobileDevice.deviceImages, id: \.self) { imageName in
                            Label {
                                Text(imageName)
                            } icon: {
                                Image(systemName: imageName)
                            }
                            .tag(imageName)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    // Preview
                    HStack {
                        Text("Preview:")
                        Spacer()
                        Image(systemName: selectedImage)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Add Device")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newDevice = MobileDevice(
                            name: name,
                            os: selectedOS,
                            imageName: selectedImage,
                            city: city,
                            manufacturer: selectedManufacturer
                        )
                        viewModel.addDevice(newDevice)
                        dismiss()
                    }
                    .disabled(name.isEmpty || city.isEmpty)
                }
            }
        }
    }
}
