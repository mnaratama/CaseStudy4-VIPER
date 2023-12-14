//
//  PromoListRouterTests.swift
//  PromoListTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PromoListRouterTest: XCTestCase {
    
    func test_when_routeToPromoDetailCalled_shouldCall_navigatePromoDetail() {
        
        // Given
        let sut = PromoListRouter()
        let givenPromo = PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        var routeSpyCalled = 0
        var outputPromo: PromoListEntity?
        sut.navigateToRouteToPromoDetail = { promo in
            routeSpyCalled += 1
            outputPromo = promo
        }
        
        // When
        sut.routeToPromoDetail(entity: givenPromo)
        
        // Then
        XCTAssert(routeSpyCalled == 1)
        XCTAssert(outputPromo == givenPromo)
    }
    
    
}
