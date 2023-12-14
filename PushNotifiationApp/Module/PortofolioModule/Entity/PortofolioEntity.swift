//
//  PortofolioEntity.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import Foundation

struct PortofolioPieEntity: Codable {
    let type: String
    let data: [PortofolioDataEntity]
}

struct PortofolioDataEntity: Codable {
    let label: String
    let percentage: String
    let data: [TransactionDataEntity]
}

struct TransactionDataEntity: Codable {
    let trx_date: String
    let nominal: Int
}

struct PortofolioPieData {
    let label: String
    let value: Double
    let transaction: [TransactionDataEntity]
    
}
