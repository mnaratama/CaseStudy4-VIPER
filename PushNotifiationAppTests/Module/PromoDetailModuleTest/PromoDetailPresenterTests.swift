//
//  PromoDetailPresenterTests.swift
//  PromoListTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PromoDetailViewSpy: PromoDetailProtocolView {
    
    var displayPromoDetailCalled = 0
    func displayPromoDetail(promoDetail: PushNotifiationApp.PromoDetailEntity) {
        displayPromoDetailCalled += 1
    }
    
}

final class PromoDetailPresenterTests: XCTestCase {
    let viewSpy = PromoDetailViewSpy()
    
    func makeSut() -> PromoDetailPresenter {
        
        let presenter = PromoDetailPresenter(view: viewSpy, promoDetailEntity: .init(promoTitle: "Title", promoDesc: "Desc", promoImageURL: URL(fileURLWithPath: "")))
        return presenter
    }
    
    func test_when_presentPromoDetail_called_shouldCall_displayPromoDetail() {
        // Given
        let sut = makeSut()
        
        // When
        sut.presentPromoDetail()
        
        // Then
        
        XCTAssert(viewSpy.displayPromoDetailCalled == 1)
        
    }
    
}
