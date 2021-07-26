//
//  ValidationServiceTests.swift
//  AnimationAppTests
//
//  Created by Akiya Ozawa on R 3/07/15.
//

@testable import AnimationApp
import XCTest

class ValidationServiceTests: XCTestCase {
    
    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }
    
    func testSqureInt() {
        let value = 3
        let squaredValue = value.square()
        
        XCTAssertEqual(squaredValue, 9)
      
    }
    
    func testIsValidUsername() throws {
        XCTAssertNoThrow(try validation.validateUserName(username: "akiya ozawa"))
        
    }
    
    func testUsernameIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUserName(username: nil)) { throwError in
            error = throwError as? ValidationError
        }
       
        XCTAssertEqual(expectedError, error)
    }
    
    func testUsernameTooShort() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUserName(username: "aka")) { thrownError in
            error = thrownError as? ValidationError
            
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func testUsernameTooLong() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let username = "supercalifragiliceto"
        
        XCTAssertTrue(username.count == 20)
        
        XCTAssertThrowsError(try validation.validateUserName(username: username)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }

}
