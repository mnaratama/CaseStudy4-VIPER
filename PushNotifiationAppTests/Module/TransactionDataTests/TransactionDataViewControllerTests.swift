//
//  TransactionDataViewControllerTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class TransactionDataPresenterSpy: TransactionDataPresenterProtocol {
    
    var presentTableViewCalled = 0
    func presentTableView() {
        presentTableViewCalled += 1
    }
    
    
}

final class TransactionDataViewControllerTests: XCTestCase {
    func makeSut() -> TransactionDataViewController {
        let sut = TransactionDataRouter.createModule(transactionData: [])
        return sut as! TransactionDataViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentTableView() {
        // Given
        let sut = makeSut()
        let spy = TransactionDataPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentTableViewCalled == 1)
    }
    
    func test_when_viewDidLoad_dataSource_notNil() {
        // Given
        let sut = makeSut()
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssertNotNil(sut.dataSource)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
}
