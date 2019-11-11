//
//  MockContactDetailsViewModel.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class MockContactDetailsViewModel: ContactDetailViewModel {
    
    var mockDataSource:Contact?
    var isContractObserverInvoked = false
    var isInvokeEditViewInvoked = false
    var isTextMessage_invoked = false
    var ismakePhoneCall_invoked = false
    var isInvokeEmail_invoked = false
    var isMarkFavourite_invoked = false
    var isDelete_invoked = false
    var isDismissDetailView_invoked = false
    
    override func fetch() {
        
        self.dataSource = mockDataSource
        detailProtocol?.loadUI(dataSource)
    }
    
    override func contactObserver(_ contact: Contact?, _ error: NSError?, _ serviceEvent: ContactServiceEvent) {
        
        isContractObserverInvoked = true
    }
    
    override func invokeEditView() {
        
        isInvokeEditViewInvoked = true
    }
    
    // MARK:- viewcontroller handler functions
    override func textMessage() {
        
        isTextMessage_invoked = true
    }
    
    override func makePhoneCall() {
        
        ismakePhoneCall_invoked = true
    }
    
    override func invokeEmail() {
        
        isInvokeEmail_invoked = true
    }
    
    override func markFavourite(_ isFavourite:Bool) {
        
        isMarkFavourite_invoked = true
    }
    
    override func delete() {
        
        isDelete_invoked = true
    }
    
    override func dismissDetailView() {
        
        isDismissDetailView_invoked = true
    }
}
