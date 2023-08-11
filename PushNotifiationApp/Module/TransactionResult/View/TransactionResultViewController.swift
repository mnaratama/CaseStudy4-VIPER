//
//  TransactionResultViewController.swift
//  PushNotifiationApp
//
//  Created by Naratama on 11/08/23.
//

import UIKit

protocol TransactionResultViewProtocol {
    func displayPage(with transacationResult: TransactionResultEntity)
}

class TransactionResultViewController: UIViewController, TransactionResultViewProtocol {
    
    let transactionStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Sukses"
        return label
    }()
    
    let transactionCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "ID1230"
        return label
    }()
    
    let transactionStackView: UIStackView = {
        let stackView =  UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    var presenter: TransactionResultPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        presenter?.presentStatus()
    }
    
    func displayPage(with transacationResult: TransactionResultEntity) {
        DispatchQueue.main.async { [self] in
            transactionStatusLabel.text = transacationResult.transactionStatus
            transactionCodeLabel.text = transacationResult.transactionCode
        }
        
    }
    
    private func setupLayout() {
        view.addSubview(transactionStackView)
        transactionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transactionStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            transactionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            transactionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            transactionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
        
        transactionStackView.addArrangedSubview(transactionCodeLabel)
        transactionStackView.addArrangedSubview(transactionStatusLabel)
    }
    
    
    
}
