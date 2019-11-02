//
//  ServiceManagerTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest

@testable import GJContactsDemo

class ServiceManagerTests: XCTestCase {
    
    var serviceManagerToTest:ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    var mockContact:Contact?
    var testError:NSError?
    
    override func setUp() {
        mockContact = Contact.init(id: 1101, firstName: "Test_FirstName", lastName: "Test_FirstName", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        serviceManagerToTest = ServiceManager.sharedInstance
        mockNetworkManager = NetworkManagerMock()
        mockNetworkManager?.error = testError
    }
    
    override func tearDown() {
        mockContact = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest?.networkManager = NetworkManager.sharedInstance
    }

    func testGetContactsList_Failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getContactsList(onSuccess: { (contacts) in
            
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: { (error) in
            
            XCTAssertEqual(error, self.testError!, "getContactsList function is not returning the exact error as retured by NetworkManager")
        })
        
    }
    
    func testGetContactsList_ValidData() {        
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode([mockContact])
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.getContactsList(onSuccess: { (contacts) in
                
                XCTAssertEqual(contacts, [self.mockContact!], "failed to parse the given data into required model")
            }, onFailure: { (error) in
                
                XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
    }
    
    func testGetContacts_Details_Failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getContactDetails(1131,
                                                onSuccess: { (contact) in
            
                                                    XCTFail("Success block should not be called if there is an internal network error.")
        },
                                                onFailure: { (error) in
            
                                                    XCTAssertEqual(error, self.testError!, "getContactsList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testGetContacts_Details_Success() {
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode(mockContact)
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.getContactDetails(1101,
                                                    onSuccess: { (contacts) in

                                                        XCTAssertEqual(contacts, self.mockContact!, "failed to parse the given data into required model")
            },
                                                    onFailure: { (error) in
                
                                                        XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
        
    }
    
    func testEdit_Contact_Failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.editContact(mockContact!,
                                          onSuccess: { (contact) in
                                                    
                                            XCTFail("Success block should not be called if there is an internal network error.")
        },
                                          onFailure: { (error) in
                                                    
                                            XCTAssertEqual(error, self.testError!, "getContactsList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testEditContact_Success() {
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode(mockContact)
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.editContact(mockContact!,
                                              onSuccess: { (contacts) in
                                                        
                                                XCTAssertEqual(contacts, self.mockContact!, "failed to parse the given data into required model")
            },
                                              onFailure: { (error) in
                                                        
                                                XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
        
    }
    
    func testCreate_Contact_Failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.createNewContact(mockContact!,
                                          onSuccess: { (contact) in
                                            
                                            XCTFail("Success block should not be called if there is an internal network error.")
        },
                                          onFailure: { (error) in
                                            
                                            XCTAssertEqual(error, self.testError!, "getContactsList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testCreate_Contact_Success() {
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode(mockContact!)
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.createNewContact(mockContact!,
                                              onSuccess: { (contact) in
                                                
                                                XCTAssertEqual(contact, self.mockContact!, "failed to parse the given data into required model")
            },
                                              onFailure: { (error) in
                                                
                                                XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
    }
    
    func testDelete_Contact_Failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.deleteContact(mockContact!,
                                               onSuccess: { (success) in
                                                
                                                XCTFail("Success block should not be called if there is an internal network error.")
        },
                                               onFailure: { (error) in
                                                
                                                XCTAssertEqual(error, self.testError!, "getContactsList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testDelete_Contact_Success() {
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode([mockContact!])
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.deleteContact(mockContact!,
                                                   onSuccess: { (success) in
                                                    
                                                    XCTAssertTrue(true)
            },
                                                   onFailure: { (error) in
                                                    
                                                    XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
    }
}
