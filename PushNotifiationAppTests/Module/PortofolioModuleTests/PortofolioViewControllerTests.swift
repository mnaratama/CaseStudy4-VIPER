//
//  PortofolioViewControllerTests.swift
//  ProtofolioAppTests
//
//  Created by Naratama on 10/08/23.
//

import XCTest
@testable import PushNotifiationApp

class PortofolioPresenterSpy: PortofolioPresenterProtocol {
    
    var presentDataCalled = 0
    func presentData() {
        presentDataCalled += 1
    }
    
    var presentPieChartCalled = 0
    func presentPieChart(data: [PushNotifiationApp.PortofolioPieData]) {
        presentPieChartCalled += 1
    }
    
    var presentToTransactionData = 0
    func presentToTransactionData(transactionData: PushNotifiationApp.PortofolioPieData) {
        presentToTransactionData += 1
    }
}

final class PortofolioViewControllerTests: XCTestCase {
    
    func makeSut() -> PortofolioViewController {
        let sut = PortofolioRouter.createModule(navigateToTransactionData: {_ in})
        return sut as! PortofolioViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentData() {
        // Given
        let sut = makeSut()
        let spy = PortofolioPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.presentDataCalled == 1)
    }

    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
}
