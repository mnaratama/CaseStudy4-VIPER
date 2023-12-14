//
//  PromoListEntity.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import Foundation

struct PromoListResponseEntity: Decodable {
    let nama: String?
    let desc: String?
    let publised_at: Date?
    let img: PromoListImg?
}

struct PromoListViewEntity {
    let promoList: [PromoListEntity]
    let errors: String?
    
    init(promoList: [PromoListEntity], errors: String? = nil) {
        self.promoList = promoList
        self.errors = errors
    }
}

enum PromoListSection: CaseIterable {
    case promoList
}

struct PromoListEntity: Decodable, Hashable {
    let promoName: String?
    let promoDescription: String?
    let promoImageSmallURL: URL?
    let promoImageMediumURL: URL?
    let publishedAt: Date?
}

struct PromoListImg: Decodable {
    let formats: ImgFormats?
}

struct ImgFormats: Decodable {
    let small: Formats?
    let medium: Formats?
}

struct Formats: Decodable {
    let url: URL?
    let width: Int?
    let height: Int?
}
