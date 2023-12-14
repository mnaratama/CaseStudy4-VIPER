//
//  PromoDetailPresenter.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PromoDetailPresenterProtocol {
    func presentPromoDetail()
}

class PromoDetailPresenter: PromoDetailPresenterProtocol {
    var view: PromoDetailProtocolView
    let promoDetailEntity: PromoDetailEntity
    
    init(view: PromoDetailProtocolView, promoDetailEntity: PromoDetailEntity) {
        self.view = view
        self.promoDetailEntity = promoDetailEntity
    }
    
    func presentPromoDetail() {
        view.displayPromoDetail(promoDetail: promoDetailEntity)
    }
    
}
