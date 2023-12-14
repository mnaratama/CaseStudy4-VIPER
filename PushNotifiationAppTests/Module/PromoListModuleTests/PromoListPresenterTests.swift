//
//  PromoListPresenterTests.swift
//  PromoListTests
//
//  Created by Naratama on 10/08/23.
//

import Foundation
@testable import PushNotifiationApp
import XCTest

class PromoListViewSpy: PromoListViewProtocol {
    
    var displayPromoListCalled = 0
    var entityCount = 0
    func displayPromoList(entity: PushNotifiationApp.PromoListViewEntity) {
        displayPromoListCalled += 1
        entityCount = entity.promoList.count
    }
    
    var displayPromoEmptyCalled = 0
    func displayPromoEmpty() {
        displayPromoEmptyCalled += 1
    }
    
    var displayPromoErrorCalled = 0
    var errorMessage: String?
    func displayPromoError(error: String?) {
        displayPromoErrorCalled += 1
        errorMessage = error
    }
}

class PromoListInteractorSpy: PromoListInteractorProtocol {
    
    var fetchPromoListCalled = 0
    func fetchPromoList() {
        fetchPromoListCalled += 1
    }
    
    
}

class PromoListRouterSpy: PromoListRouterProtocol {
    static func createModule(navigateToPromoDetail: @escaping (PushNotifiationApp.PromoListEntity) -> Void) -> UIViewController {
        return UIViewController()
    }
    
    var routeToPromoDetailTapped = 0
    func routeToPromoDetail(entity: PushNotifiationApp.PromoListEntity) {
        routeToPromoDetailTapped += 1
    }
    
    
}

class PromoListPresenterTest: XCTestCase {
    
    let viewSpy = PromoListViewSpy()
    let interactorSpy = PromoListInteractorSpy()
    let routerSpy = PromoListRouterSpy()
    
    func makeSut() -> PromoListPresenter {
        let sut = PromoListPresenter(view: viewSpy, interactor: interactorSpy, router: routerSpy)
        
        return sut
    }
    
    func test_when_presentPromoList_called_shouldcall_displayEntity() {
        // Given
        let sut = makeSut()
        let promoEntity = PromoListViewEntity(promoList: [
            PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        ])
        
        // When
        sut.presentPromoList(entity: promoEntity)
        
        // Then
        XCTAssert(viewSpy.displayPromoListCalled == 1)
    }
    
    func test_when_presentPromoList_called_entityCount_shouldSame_as_given() {
        // Given
        let sut = makeSut()
        let promoEntity = PromoListViewEntity(promoList: [
            PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        ])
        
        // When
        sut.presentPromoList(entity: promoEntity)
        
        // Then
        XCTAssert(viewSpy.entityCount == promoEntity.promoList.count)
    }
    
    func test_when_getPromoListCalled_shouldCall_fetchPromoList() {
        // Given
        let sut = makeSut()
        
        // When
        sut.getPromoList()
        
        // Then
        XCTAssert(interactorSpy.fetchPromoListCalled == 1)
    }
    
    func test_when_presentEmptyPromoListCalled_shouldCall_displayPromoList() {
        // Given
        let sut = makeSut()
        
        // When
        sut.presentEmptyPromoList()
        
        // Then
        XCTAssert(viewSpy.displayPromoEmptyCalled == 1)
    }
    
    func test_when_presentGetErrorPromo_called_shouldCall_displayPromoError() {
        // Given
        let sut = makeSut()
        let promoEntity = PromoListViewEntity(promoList: [
            PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        ], errors: "Error")
        
        // When
        sut.presentGetErrorPromo(entity: promoEntity)
        
        // Then
        XCTAssert(viewSpy.displayPromoErrorCalled == 1)
    }
    
    func test_when_presentGetErrorPromo_called_errorStringShouldSame_as_given() {
        // Given
        let sut = makeSut()
        let promoEntity = PromoListViewEntity(promoList: [
            PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        ], errors: "Error")
        
        // When
        sut.presentGetErrorPromo(entity: promoEntity)
        
        // Then
        XCTAssert(viewSpy.errorMessage == promoEntity.errors)
    }
    
    func test_when_presentPromoDetailCalled_shouldCall_routeToPromoDetail() {
        // Given
        let sut = makeSut()
        let promoEntity = PromoListViewEntity(promoList: [
            PromoListEntity.init(promoName: "", promoDescription: "", promoImageSmallURL: nil, promoImageMediumURL: nil, publishedAt: Date())
        ], errors: "Error")
        
        // When
        sut.presentPromoDetail(entity: promoEntity.promoList[0])
        
        // Then
        XCTAssert(routerSpy.routeToPromoDetailTapped == 1)
    }

    
}
