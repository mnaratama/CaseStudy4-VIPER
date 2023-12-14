//
//  PromoListViewController.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit

protocol PromoListViewProtocol {
    func displayPromoList(entity: PromoListViewEntity)
    func displayPromoEmpty()
    func displayPromoError(error: String?)
}

class PromoListViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.hidesWhenStopped = true
        return activity
    }()
    
    let promoInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    var dataSource: UITableViewDiffableDataSource<PromoListSection, PromoListEntity>?
    var presenter: PromoListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Promo List"
        promoInfoLabel.isHidden = true
        view.backgroundColor = .white
        setupLayout()
        setupTableview()
        setupDataSource()
        getPromoList()
    }
    
    private func getPromoList() {
        activityIndicator.startAnimating()
        presenter?.getPromoList()
    }
    
    private func setupTableview() {
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(PromoListTableViewCell.self, forCellReuseIdentifier: "promoCell")
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<PromoListSection, PromoListEntity>(tableView: self.tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "promoCell") as? PromoListTableViewCell else { return UITableViewCell() }
            cell.configureCell(promo: item)
            return cell
        }
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
        
        promoInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(promoInfoLabel)
        NSLayoutConstraint.activate([
            promoInfoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            promoInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            promoInfoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
}

extension PromoListViewController: PromoListViewProtocol {
    func displayPromoList(entity: PromoListViewEntity) {
        var snapshot = NSDiffableDataSourceSnapshot<PromoListSection, PromoListEntity>()
        snapshot.appendSections(PromoListSection.allCases)
        snapshot.appendItems(entity.promoList)
        dataSource?.apply(snapshot, animatingDifferences: true)
        activityIndicator.stopAnimating()
    }
    
    func displayPromoEmpty() {
        promoInfoLabel.isHidden = false
        promoInfoLabel.text = "Belum ada promo saat ini"
        activityIndicator.stopAnimating()
    }
    
    func displayPromoError(error: String?) {
        promoInfoLabel.isHidden = false
        promoInfoLabel.text = error
        activityIndicator.stopAnimating()
    }
}

extension PromoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PromoListTableViewCell else { return }
        guard let promoDetail = cell.promoCellEntity else { return }
        presenter?.presentPromoDetail(entity: promoDetail)
    }
}
