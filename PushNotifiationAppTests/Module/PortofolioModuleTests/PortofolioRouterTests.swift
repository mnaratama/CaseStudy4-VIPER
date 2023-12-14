//
//  PortofolioRouterTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

final class PortofolioRouterTests: XCTestCase {
    
    func test_routerToTransactionData_called_shouldCall_navigateToTransactionData() {
        
        // Given
        let sut = PortofolioRouter()
        let data = PortofolioPieData(label: "label", value: 0, transaction: [])
        var navigateToTransactionDataCalled = 0
        sut.navigateToTransactionData = { data in
            navigateToTransactionDataCalled += 1
        }
        
        // When
        sut.routeToTransactionData(transactionData: data)
        
        // Then
        XCTAssert(navigateToTransactionDataCalled == 1)
        
    }
    
}
