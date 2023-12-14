//
//  PortofolioViewController.swift
//  ProtofolioApp
//
//  Created by Naratama on 10/08/23.
//

import UIKit
import Charts

protocol PortofolioViewProtocol {
    func displayDataChart(data: [PortofolioPieData])
}

class PortofolioViewController: UIViewController {
    
    let pieChart: PieChartView = {
        let pieChart = PieChartView()
        return pieChart
    }()
    
    let baseView: UIView = {
        let view = UIView()
        return view
    }()
    
    var pieDataEntry: [PortofolioPieData]?
    var presenter: PortofolioPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter?.presentData()
        pieChart.delegate = self
    }
    
    private func setupLayout() {
        view.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            baseView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        baseView.addSubview(pieChart)
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: baseView.topAnchor),
            pieChart.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            pieChart.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
        ])
    }
    
    
}

extension PortofolioViewController: PortofolioViewProtocol, ChartViewDelegate {
    func displayDataChart(data: [PortofolioPieData]) {
        pieDataEntry = data
        var dataEntries: [ChartDataEntry] = []
        data.enumerated().forEach { index, value in
            let entry = PieChartDataEntry(value: value.value, label: value.label)
            dataEntries.append(entry)
        }

        let dataSet = PieChartDataSet(entries: dataEntries, label: "Pie Chart Data")
        
        dataSet.colors = ChartColorTemplates.colorful()
        
//        DispatchQueue.main.async {  in
//            guard let self else { return }
//            let data = PieChartData(dataSet: dataSet)
//
//            pieChart.data = data
//
//            pieChart.chartDescription.text = "Data Transaksi"
//            pieChart.legend.enabled = true
//        }
        
        DispatchQueue.main.async { [self] in
            let data = PieChartData(dataSet: dataSet)
            
            pieChart.data = data
            
            pieChart.chartDescription.text = "Data Transaksi"
            pieChart.legend.enabled = true
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        presenter?.presentToTransactionData(transactionData: (pieDataEntry?[Int(highlight.x)])!)
    }
    
}
