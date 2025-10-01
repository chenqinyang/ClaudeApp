//
//  EditDeviceView.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct EditDeviceView: View {
    @Binding var device: MobileDevice
    @ObservedObject var viewModel: DeviceViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var editedName: String = ""
    @State private var editedOS: String = ""
    @State private var editedImage: String = ""
    @State private var editedCity: String = ""
    @State private var editedManufacturer: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Device Information") {
                    TextField("Device Name", text: $editedName)
                    
                    Picker("Operating System", selection: $editedOS) {
                        ForEach(MobileDevice.operatingSystems, id: \.self) { os in
                            Text(os).tag(os)
                        }
                    }
                    
                    Picker("Manufacturer", selection: $editedManufacturer) {
                        ForEach(MobileDevice.manufacturers, id: \.self) { manufacturer in
                            Text(manufacturer).tag(manufacturer)
                        }
                    }
                    
                    TextField("City", text: $editedCity)
                }
                
                Section("Device Icon") {
                    Picker("Select Icon", selection: $editedImage) {
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
                        Image(systemName: editedImage)
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                }
                
                Section {
                    Button(role: .destructive) {
                        viewModel.deleteDevice(device)
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Device")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Edit Device")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        device.name = editedName
                        device.os = editedOS
                        device.imageName = editedImage
                        device.city = editedCity
                        device.manufacturer = editedManufacturer
                        viewModel.updateDevice(device)
                        dismiss()
                    }
                    .disabled(editedName.isEmpty || editedCity.isEmpty)
                }
            }
        }
        .onAppear {
            editedName = device.name
            editedOS = device.os
            editedImage = device.imageName
            editedCity = device.city
            editedManufacturer = device.manufacturer
        }
    }
}
