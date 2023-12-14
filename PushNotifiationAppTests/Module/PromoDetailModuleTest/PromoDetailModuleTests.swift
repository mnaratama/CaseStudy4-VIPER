//
//  PromoDetailModuleTests.swift
//  PromoListTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PromoDetailPresenterSpy: PromoDetailPresenterProtocol {
    
    var preesentPromoDetailCalled = 0
    func presentPromoDetail() {
        preesentPromoDetailCalled += 1
    }
    
}

final class PromoDetailPresenterTest: XCTestCase {
    func makeSut() -> PromoDetailViewController {
        let sut = PromoDetailRouter.createModule(entity: .init(promoTitle: "Title", promoDesc: "Desc", promoImageURL: URL(fileURLWithPath: "")))
        return sut as! PromoDetailViewController
    }
    
    func test_when_viewDidLoad_shouldCall_presentPromoDetail() {
        // Given
        let sut = makeSut()
        let spy = PromoDetailPresenterSpy()
        sut.presenter = spy
        
        // When
        loadView(withSut: sut)
        
        // Then
        XCTAssert(spy.preesentPromoDetailCalled == 1)
    }
    
    func loadView(withSut: UIViewController) {
        let window = UIWindow()
        window.addSubview(withSut.view)
        RunLoop.current.run(until: Date())
    }
}
