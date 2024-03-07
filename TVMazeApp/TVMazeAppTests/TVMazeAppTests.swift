//
//  TVMazeAppTests.swift
//  TVMazeAppTests
//
//  Created by Jeann Luiz on 28/02/24.
//

import XCTest
@testable import TVMazeApp

final class TVMazeAppTests: XCTestCase {

    //Naming structure test_UnitOfWork_StateUnderTest_ExpectedBehavior
    //Naming structure test_[struct or class]_[variable or function]_[expected result]
    //Test structure: Given, when, then
            
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AccountViewModel_userModel_ShouldBeEquals() throws {
        // Given
        let vm = AccountViewModel()
        
        // When
        vm.userModel = MockData.user1
        
        // Then
        XCTAssertEqual(vm.userModel, MockData.user1)
    }

    func test_AccountViewModel_userModel_ShouldNotBeEquals() throws {
        // Given
        let vm = AccountViewModel()
        
        // When
        vm.userModel = MockData.user1
        vm.userModel = MockData.user2
        
        // Then
        XCTAssertNotEqual(vm.userModel, MockData.user1)
    }
    
    func test_AccountViewModel_alertItem_ShouldBeEquals() throws {
        // Given
        let vm = AccountViewModel()
        
        // When
        vm.alertItem = AlertItem(error: .invalidUrl)
        
        // Then
        XCTAssertEqual(vm.alertItem, AlertItem(error: .invalidUrl))
    }

    func test_AccountViewModel_alertItem_ShouldNotBeEquals() throws {
        // Given
        let vm = AccountViewModel()
        
        // When
        vm.alertItem = AlertItem(error: .invalidUrl)
        vm.alertItem = AlertItem(error: .endpointNotFound)
        
        // Then
        XCTAssertNotEqual(vm.alertItem, AlertItem(error: .invalidUrl))
    }

}
