//
//  PortofolioInteractorTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

final class PortofolioInteractorTests: XCTestCase {
    
    
    func test_when_preparePieDataCalled_whenFinished_shouldCall_presentPieChart() {
        
        // Given
        let sut = PortofolioInteractor()
        let spy = PortofolioPresenterSpy()
        sut.presenter = spy
        
        // When
        sut.preparePieData()
        
        // Then
        XCTAssert(spy.presentPieChartCalled == 1)
        
        
    }
}
