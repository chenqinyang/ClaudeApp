//
//  ClaudeAppTests.swift
//  ClaudeAppTests
//
//  Created by QinYang on 2025/8/8.
//

import XCTest
@testable import ClaudeApp

class ClaudeAppModelTests: XCTestCase {
    
    func testMobileDeviceInitialization() {
        // Given
        let name = "Test iPhone"
        let os = "iOS 17"
        let imageName = "iphone.gen3"
        let city = "Test City"
        let manufacturer = "Apple"
        
        // When
        let device = MobileDevice(
            name: name,
            os: os,
            imageName: imageName,
            city: city,
            manufacturer: manufacturer
        )
        
        // Then
        XCTAssertEqual(device.name, name)
        XCTAssertEqual(device.os, os)
        XCTAssertEqual(device.imageName, imageName)
        XCTAssertEqual(device.city, city)
        XCTAssertEqual(device.manufacturer, manufacturer)
        XCTAssertNotNil(device.id)
    }
    
    func testMobileDeviceUniqueID() {
        // Given
        let device1 = MobileDevice(
            name: "Device 1",
            os: "iOS 17",
            imageName: "iphone",
            city: "City 1",
            manufacturer: "Apple"
        )
        let device2 = MobileDevice(
            name: "Device 2",
            os: "Android 14",
            imageName: "iphone",
            city: "City 2",
            manufacturer: "Samsung"
        )
        
        // Then
        XCTAssertNotEqual(device1.id, device2.id)
    }
    
    func testDeviceStaticArrays() {
        // Test that static arrays contain expected values
        XCTAssertTrue(MobileDevice.deviceImages.contains("iphone"))
        XCTAssertTrue(MobileDevice.manufacturers.contains("Apple"))
        XCTAssertTrue(MobileDevice.operatingSystems.contains("iOS 17"))
        
        XCTAssertFalse(MobileDevice.deviceImages.isEmpty)
        XCTAssertFalse(MobileDevice.manufacturers.isEmpty)
        XCTAssertFalse(MobileDevice.operatingSystems.isEmpty)
    }
    
    func testMobileDeviceCodable() throws {
        // Given
        let device = MobileDevice(
            name: "Test Device",
            os: "iOS 17",
            imageName: "iphone",
            city: "Test City",
            manufacturer: "Apple"
        )
        
        // When - Encode
        let encoder = JSONEncoder()
        let data = try encoder.encode(device)
        
        // When - Decode
        let decoder = JSONDecoder()
        let decodedDevice = try decoder.decode(MobileDevice.self, from: data)
        
        // Then
//        XCTAssertEqual(device.id, decodedDevice.id)
        XCTAssertEqual(device.name, decodedDevice.name)
        XCTAssertEqual(device.os, decodedDevice.os)
        XCTAssertEqual(device.imageName, decodedDevice.imageName)
        XCTAssertEqual(device.city, decodedDevice.city)
        XCTAssertEqual(device.manufacturer, decodedDevice.manufacturer)
    }
}

class DeviceViewModelTests: XCTestCase {
    var viewModel: DeviceViewModel!
    let testUserDefaultsKey = "SavedDevices"
    
    override func setUp() {
        super.setUp()
        // Clear UserDefaults before each test
        UserDefaults.standard.removeObject(forKey: testUserDefaultsKey)
        viewModel = DeviceViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        UserDefaults.standard.removeObject(forKey: testUserDefaultsKey)
        super.tearDown()
    }
    
    func testInitialLoadWithNoSavedData() {
        // When viewModel is initialized with no saved data
        // Then it should load sample data
        XCTAssertFalse(viewModel.devices.isEmpty)
        XCTAssertEqual(viewModel.devices.count, 3) // Sample data has 3 devices
    }
    
    func testAddDevice() {
        // Given
        let initialCount = viewModel.devices.count
        let newDevice = MobileDevice(
            name: "New Test Device",
            os: "iOS 17",
            imageName: "iphone",
            city: "New York",
            manufacturer: "Apple"
        )
        
        // When
        viewModel.addDevice(newDevice)
        
        // Then
        XCTAssertEqual(viewModel.devices.count, initialCount + 1)
        XCTAssertTrue(viewModel.devices.contains(where: { $0.id == newDevice.id }))
    }
    
    func testUpdateDevice() {
        // Given
        var device = MobileDevice(
            name: "Original Name",
            os: "iOS 16",
            imageName: "iphone",
            city: "Original City",
            manufacturer: "Apple"
        )
        viewModel.addDevice(device)
        
        // When
        device.name = "Updated Name"
        device.city = "Updated City"
        viewModel.updateDevice(device)
        
        // Then
        let updatedDevice = viewModel.devices.first(where: { $0.id == device.id })
        XCTAssertNotNil(updatedDevice)
        XCTAssertEqual(updatedDevice?.name, "Updated Name")
        XCTAssertEqual(updatedDevice?.city, "Updated City")
    }
    
    func testDeleteDevice() {
        // Given
        let device = MobileDevice(
            name: "Device to Delete",
            os: "iOS 17",
            imageName: "iphone",
            city: "Delete City",
            manufacturer: "Apple"
        )
        viewModel.addDevice(device)
        let countAfterAdd = viewModel.devices.count
        
        // When
        viewModel.deleteDevice(device)
        
        // Then
        XCTAssertEqual(viewModel.devices.count, countAfterAdd - 1)
        XCTAssertFalse(viewModel.devices.contains(where: { $0.id == device.id }))
    }
    
    func testDeleteDevicesAtOffsets() {
        // Given
        let initialDevices = viewModel.devices
        let initialCount = initialDevices.count
        let indexToDelete = 0
        
        // When
        viewModel.deleteDevices(at: IndexSet(integer: indexToDelete))
        
        // Then
        XCTAssertEqual(viewModel.devices.count, initialCount - 1)
        if initialCount > 0 {
            XCTAssertFalse(viewModel.devices.contains(where: { $0.id == initialDevices[indexToDelete].id }))
        }
    }
    
    func testDataPersistence() {
        // Given
        let device = MobileDevice(
            name: "Persistent Device",
            os: "iOS 17",
            imageName: "iphone",
            city: "Persistent City",
            manufacturer: "Apple"
        )
        
        // Clear existing devices and add new one
        viewModel.devices = []
        viewModel.addDevice(device)
        
        // When - Create new view model instance (simulating app restart)
        let newViewModel = DeviceViewModel()
        
        // Then
        XCTAssertEqual(newViewModel.devices.count, 1)
        XCTAssertEqual(newViewModel.devices.first?.name, "Persistent Device")
        XCTAssertEqual(newViewModel.devices.first?.city, "Persistent City")
    }
}
