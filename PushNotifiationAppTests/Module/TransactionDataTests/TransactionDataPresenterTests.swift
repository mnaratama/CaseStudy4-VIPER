//
//  TransactionDataPresenterTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class TransactionViewSpy: TransactionDataViewProtocol {
    
    var setupTableDataCalled = 0
    func setupTableData(data: [PushNotifiationApp.TransactionData]) {
        setupTableDataCalled += 1
    }
}

final class TransactionDataPresenterTest: XCTestCase {
    let viewSpy = TransactionViewSpy()
    func makeSut() -> TransactionDataPresenter {
        let presenter = TransactionDataPresenter(view: viewSpy, transactionData: [])
        return presenter
    }
    
    func test_when_presentTableView_called_shouldCall_setupTableData() {
        // Given
        let sut = makeSut()
        sut.view = viewSpy
        
        // When
        sut.presentTableView()
        
        // Then
        XCTAssert(viewSpy.setupTableDataCalled == 1)
    }
}
