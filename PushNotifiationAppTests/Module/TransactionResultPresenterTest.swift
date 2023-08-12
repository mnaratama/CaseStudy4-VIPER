//
//  TransactionResultPresenterTest.swift
//  PushNotifiationAppTests
//
//  Created by Naratama on 12/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class TransactionResultViewSpy: TransactionResultViewProtocol {
    
    var result: TransactionResultEntity?
    var displayPageCalled = 0
    func displayPage(with transacationResult: PushNotifiationApp.TransactionResultEntity) {
        displayPageCalled += 1
        result = transacationResult
    }
    
    
}

final class TransactionPresenterTests: XCTestCase {
    
    let viewSpy = TransactionResultViewSpy()
    
    func makeSut() -> TransactionResultPresenter {
        let presenter = TransactionResultPresenter(view: viewSpy, transactionResult: .init(transactionCode: "test", transactionStatus: "test"))
        return presenter
    }
    
    func test_when_presentStatusCalled_shouldCall_displayPage() {
        // Given
        let sut = makeSut()
        let result = TransactionResultEntity(transactionCode: "test", transactionStatus: "test")
        
        // When
        sut.presentStatus()
        
        // Then
        XCTAssert(viewSpy.displayPageCalled == 1)
        XCTAssertEqual(result, viewSpy.result)
    }
}
