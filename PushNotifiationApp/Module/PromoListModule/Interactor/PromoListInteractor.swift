//
//  PromoListInteractor.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PromoListInteractorProtocol {
    func fetchPromoList()
}

class PromoListInteractor: PromoListInteractorProtocol{
    
    var presenter: PromoListPresenterProtocol?
    
    func fetchPromoList() {
        NetworkHelper.shared.requestPromoList(completion: { [weak self] isSuccess, promoLists, errorString  in
            if isSuccess {
                guard promoLists.count != 0 else {
                    self?.presenter?.presentEmptyPromoList()
                    return
                }
                let promoList = promoLists.map {
                    PromoListEntity(promoName: $0.nama, promoDescription: $0.desc, promoImageSmallURL: $0.img?.formats?.small?.url, promoImageMediumURL: $0.img?.formats?.medium?.url, publishedAt: $0.publised_at)
                }
                let promoListViewEntity = PromoListViewEntity(promoList: promoList, errors: errorString)
                self?.presenter?.presentPromoList(entity: promoListViewEntity)
            } else {
                self?.presenter?.presentGetErrorPromo(entity: PromoListViewEntity(promoList: [], errors: errorString))
            }
        })
    }
    
    
}
