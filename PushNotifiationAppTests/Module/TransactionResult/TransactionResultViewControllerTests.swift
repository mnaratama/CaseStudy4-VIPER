//
//  TransactionResultViewControllerTests.swift
//  PushNotifiationAppTests
//
//  Created by Naratama on 12/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class TransactionPresenterSpy: TransactionResultPresenterProtocol {
    
    var presentStatusCalled = 0
    func presentStatus() {
        presentStatusCalled += 1
    }
    
    
}

final class TransactionControllerTests: XCTestCase {
    
    func makeSut() -> TransactionResultViewController {
        let sut = TransactionResultRouter.createModule(result: .init(transactionCode: "ID123", transactionStatus: "sukses"))
        return sut as! TransactionResultViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentStatus() {
        
        // Given
        let sut = makeSut()
        let spy = TransactionPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentStatusCalled == 1)
        
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
    
}
