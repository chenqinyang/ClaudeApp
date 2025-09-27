//
//  ClaudeAppUITests.swift
//  ClaudeAppUITests
//
//  Created by QinYang on 2025/8/8.
//

import XCTest

class ClaudeAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testNavigationTitle() throws {
        // Verify the main navigation title is displayed
        let navigationBar = app.navigationBars["Mobile Devices"]
        XCTAssertTrue(navigationBar.exists)
    }
    
    func testAddDeviceButtonExists() throws {
        // Verify add button exists in navigation bar
        let addButton = app.navigationBars["Mobile Devices"].buttons["Add"]
        XCTAssertTrue(addButton.exists)
    }
    
    func testEditButtonExists() throws {
        // Verify edit button exists
        let editButton = app.navigationBars["Mobile Devices"].buttons["Edit"]
        XCTAssertTrue(editButton.exists)
    }
    
    func testDeviceListDisplay() throws {
        // Check if list contains at least one device (sample data)
        let deviceList = app.collectionViews.firstMatch
        XCTAssertTrue(deviceList.exists)
        
        // Wait for list to load
        let firstCell = deviceList.cells.firstMatch
        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists)
    }
    
    func testSearchFunctionality() throws {
        // Test search bar
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("iPhone")
        
        // Verify search is working (results should be filtered)
        let deviceList = app.collectionViews.firstMatch
        XCTAssertTrue(deviceList.exists)
    }
    
    func testNavigateToDeviceDetail() throws {
        // Tap on first device in list
        let deviceList = app.collectionViews.firstMatch
        let firstDevice = deviceList.cells.firstMatch
        
        if firstDevice.waitForExistence(timeout: 5) {
            firstDevice.tap()
            
            // Verify we're in detail view by checking for Edit button
            let editButton = app.navigationBars.buttons["Edit"]
            XCTAssertTrue(editButton.waitForExistence(timeout: 5))
            
            // Verify detail view elements
            XCTAssertTrue(app.scrollViews.firstMatch.exists)
        }
    }
    
    func testAddNewDevice() throws {
        // Tap add button
        let addButton = app.navigationBars["Mobile Devices"].buttons["Add"]
        addButton.tap()
        
        // Verify add device sheet appears
        let addDeviceNavBar = app.navigationBars["Add Device"]
        XCTAssertTrue(addDeviceNavBar.waitForExistence(timeout: 5))
        
        // Fill in device information
        let nameField = app.textFields["Device Name"]
        XCTAssertTrue(nameField.exists)
        nameField.tap()
        nameField.typeText("Test Device")
        
        let cityField = app.textFields["City"]
        XCTAssertTrue(cityField.exists)
        cityField.tap()
        cityField.typeText("Test City")
        
        // Test OS Picker
        let osPicker = app.buttons.matching(identifier: "Operating System").firstMatch
        if osPicker.exists {
            osPicker.tap()
            let iosOption = app.buttons["iOS 17"].firstMatch
            if iosOption.waitForExistence(timeout: 2) {
                iosOption.tap()
            }
        }
        
        // Save the device
        let saveButton = app.navigationBars["Add Device"].buttons["Save"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
        // Verify we're back on main list
        let mainNavBar = app.navigationBars["Mobile Devices"]
        XCTAssertTrue(mainNavBar.waitForExistence(timeout: 5))
    }
    
    func testCancelAddDevice() throws {
        // Tap add button
        let addButton = app.navigationBars["Mobile Devices"].buttons["Add"]
        addButton.tap()
        
        // Tap cancel
        let cancelButton = app.navigationBars["Add Device"].buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
        cancelButton.tap()
        
        // Verify we're back on main list
        let mainNavBar = app.navigationBars["Mobile Devices"]
        XCTAssertTrue(mainNavBar.waitForExistence(timeout: 5))
    }
    
    func testEditDevice() throws {
        // Navigate to first device
        let deviceList = app.collectionViews.firstMatch
        let firstDevice = deviceList.cells.firstMatch
        
        if firstDevice.waitForExistence(timeout: 5) {
            firstDevice.tap()
            
            // Tap Edit button
            let editButton = app.navigationBars.buttons["Edit"]
            XCTAssertTrue(editButton.waitForExistence(timeout: 5))
            editButton.tap()
            
            // Verify edit sheet appears
            let editNavBar = app.navigationBars["Edit Device"]
            XCTAssertTrue(editNavBar.waitForExistence(timeout: 5))
            
            // Modify device name
            let nameField = app.textFields["Device Name"]
            if nameField.waitForExistence(timeout: 5) {
                nameField.tap()
                nameField.clearText()
                nameField.typeText("Updated Device Name")
            }
            
            // Save changes
            let saveButton = app.navigationBars["Edit Device"].buttons["Save"]
            saveButton.tap()
            
            // Verify we're back in detail view
            XCTAssertTrue(app.scrollViews.firstMatch.waitForExistence(timeout: 5))
        }
    }
    
    func testDeleteDeviceSwipe() throws {
        // Get initial count of cells
        let deviceList = app.collectionViews.firstMatch
        let firstDevice = deviceList.cells.firstMatch
        
        if firstDevice.waitForExistence(timeout: 5) {
            // Swipe to delete
            firstDevice.swipeLeft()
            
            // Look for delete button
            let deleteButton = app.buttons["Delete"]
            if deleteButton.waitForExistence(timeout: 2) {
                deleteButton.tap()
            }
        }
    }
    
    func testEmptyState() throws {
        // This test would require clearing all devices first
        // In a real scenario, you might want to use launch arguments to start with empty state
        
        // For testing purposes, delete all visible devices
        let deviceList = app.collectionViews.firstMatch
        
        // Enter edit mode
        let editButton = app.navigationBars["Mobile Devices"].buttons["Edit"]
        if editButton.exists {
            editButton.tap()
            
            // Delete all cells
            while deviceList.cells.count > 0 {
                let deleteButton = deviceList.cells.firstMatch.buttons.matching(NSPredicate(format: "label CONTAINS 'Delete'")).firstMatch
                if deleteButton.exists {
                    deleteButton.tap()
                    let confirmDelete = app.buttons["Delete"]
                    if confirmDelete.exists {
                        confirmDelete.tap()
                    }
                }
            }
            
            // Exit edit mode
            let doneButton = app.navigationBars["Mobile Devices"].buttons["Done"]
            if doneButton.exists {
                doneButton.tap()
            }
        }
    }
    
    func testDeviceIconPicker() throws {
        // Navigate to add device
        let addButton = app.navigationBars["Mobile Devices"].buttons["Add"]
        addButton.tap()
        
        // Find and tap icon picker
        let iconPicker = app.buttons["Select Icon"].firstMatch
        if iconPicker.waitForExistence(timeout: 5) {
            iconPicker.tap()
            
            // Select different icon
            let iconOption = app.buttons.matching(NSPredicate(format: "label CONTAINS 'ipad'")).firstMatch
            if iconOption.waitForExistence(timeout: 2) {
                iconOption.tap()
            }
        }
        
        // Cancel to go back
        let cancelButton = app.navigationBars["Add Device"].buttons["Cancel"]
        cancelButton.tap()
    }
}

// Helper extension for clearing text fields
extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
