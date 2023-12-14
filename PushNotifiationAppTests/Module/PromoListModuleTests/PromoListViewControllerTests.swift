//
//  PromoListViewControllerTests.swift
//  PromoListTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PromoListPresenterSpy: PromoListPresenterProtocol {
    
    var getPromoListCalled = 0
    func getPromoList() {
        getPromoListCalled += 1
    }
    
    var presentEmptyPromoListCalled = 0
    func presentEmptyPromoList() {
        presentEmptyPromoListCalled += 1
    }
    
    var presentPromoListCalled = 0
    func presentPromoList(entity: PushNotifiationApp.PromoListViewEntity) {
        presentPromoListCalled += 1
    }
    
    var presentGetErrorPromoCalled = 0
    func presentGetErrorPromo(entity: PushNotifiationApp.PromoListViewEntity) {
        presentGetErrorPromoCalled += 1
    }
    
    var presentPromoDetailCalled = 0
    func presentPromoDetail(entity: PushNotifiationApp.PromoListEntity) {
        presentPromoDetailCalled += 1
    }
    
    
}

final class PromoListViewControllerTests: XCTestCase {
    func makeSut() -> PromoListViewController {
        let sut = PromoListRouter.createModule(navigateToPromoDetail: {_ in})
        return sut as! PromoListViewController
    }
    
    func test_when_viewDidLoad_shouldCall_getPromoList() {
        // Given
        let sut = makeSut()
        let spy = PromoListPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.getPromoListCalled == 1)
    }
    
    func test_when_viewDidLoad_presenter_shouldNot_nil() {
        // Given
        let sut = makeSut()
        let spy = PromoListPresenterSpy()
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssertNotNil(sut.presenter)
    }
    
    func test_when_viewDidLoad_dataSource_shouldNot_nil() {
        // Given
        let sut = makeSut()
        let spy = PromoListPresenterSpy()
        
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
