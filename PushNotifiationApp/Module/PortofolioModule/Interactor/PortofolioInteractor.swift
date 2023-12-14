//
//  PortofolioInteractor.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import Foundation

protocol PortofolioInteractorProtocol {
    func preparePieData()
}

class PortofolioInteractor: PortofolioInteractorProtocol {
    
    var presenter: PortofolioPresenterProtocol?
    
    func preparePieData() {
        if let url = Bundle.main.url(forResource: "PortofolioMockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                decodeJSON(data: data)
            } catch {
                print("Error loading JSON data: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }
    
    private func decodeJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let datas = try decoder.decode([PortofolioPieEntity].self, from: data)
          
            var charData: [PortofolioPieData] = []
            let pieData = datas.map({ portofolio in
                let chartData = portofolio.data.map { datax in
                    PortofolioPieData(label: datax.label, value: Double(datax.percentage) ?? 0, transaction: datax.data)
                }
                charData = chartData
                return chartData
            })
            presenter?.presentPieChart(data: charData)

        } catch {
            print("Error decoding JSON data: \(error)")
        }
    }
}
