//
//  MobileDevice.swift
//  ClaudeApp
//
//  Created by QinYang on 2025/9/27.
//

import SwiftUI

struct MobileDevice: Identifiable, Codable {
    let id = UUID()
    var name: String
    var os: String
    var imageName: String
    var city: String
    var manufacturer: String
    
    // Default device images - you can use SF Symbols
    static let deviceImages = [
        "iphone",
        "iphone.gen1",
        "iphone.gen2",
        "iphone.gen3",
        "ipad",
        "ipad.gen1",
        "ipad.gen2"
    ]
    
    static let manufacturers = [
        "Apple",
        "Samsung",
        "Google",
        "OnePlus",
        "Xiaomi",
        "Huawei",
        "Sony",
        "LG",
        "Motorola"
    ]
    
    static let operatingSystems = [
        "iOS 17",
        "iOS 16",
        "Android 14",
        "Android 13",
        "Android 12",
        "HarmonyOS",
        "One UI",
        "OxygenOS"
    ]
}
