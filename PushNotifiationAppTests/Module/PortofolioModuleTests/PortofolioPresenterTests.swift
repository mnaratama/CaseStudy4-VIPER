//
//  PortofolioPresenterTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PortofolioViewSpy: PortofolioViewProtocol {
    
    var displayDataChartCalled = 0
    var dataCount = 0
    func displayDataChart(data: [PushNotifiationApp.PortofolioPieData]) {
        dataCount = data.count
        displayDataChartCalled += 1
    }
    
    
}

class PortofolioInteractorSpy:  PortofolioInteractorProtocol {
    var preparePieDataCalled = 0
    func preparePieData() {
        preparePieDataCalled += 1
    }
}

class PortofolioRouterSpy: PortofolioRouterProtocol {
    static func createModule(navigateToTransactionData: @escaping (PushNotifiationApp.PortofolioPieData) -> Void) -> UIViewController {
        return UIViewController()
    }
    
    var routeToTransactionDataCalled = 0
    func routeToTransactionData(transactionData: PushNotifiationApp.PortofolioPieData) {
        routeToTransactionDataCalled += 1
    }
    
}

final class PortofolioPresenterTests: XCTestCase {
    
    let viewSpy = PortofolioViewSpy()
    let interactorSpy = PortofolioInteractorSpy()
    let routerSpy = PortofolioRouterSpy()
    
    func makeSut() -> PortofolioPresenter {
        let sut = PortofolioPresenter(view: viewSpy, interactor: interactorSpy, router: routerSpy)
        return sut
    }
    
    func test_whenPresentDataCalled_shouldCall_preparePieData() {
        // Given
        let sut = makeSut()
        
        // When
        sut.presentData()
        
        // Then
        XCTAssert(interactorSpy.preparePieDataCalled == 1)
    }
    
    func test_when_presentPieChart_called_shouldCall_displayDataChart() {
        // Given
        let sut = makeSut()
        let transactionData = PortofolioPieData(label: "label", value: 20, transaction: [])
        let transaction = [transactionData]
        
        // When
        sut.presentPieChart(data: [transactionData])
        
        // Then
        XCTAssert(viewSpy.displayDataChartCalled == 1)
        XCTAssert(transaction.count == viewSpy.dataCount)
    }
}
