//
//  PromoDetailViewController.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit
import Kingfisher

protocol PromoDetailProtocolView {
    func displayPromoDetail(promoDetail: PromoDetailEntity)
}

class PromoDetailViewController: UIViewController, PromoDetailProtocolView {
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    let promoImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let titleAndDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        stackView.spacing = 4
        return stackView
    }()
    
    let promoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let promoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let spacer: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    var presenter: PromoDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter?.presentPromoDetail()
    }
    
    func displayPromoDetail(promoDetail: PromoDetailEntity) {
        promoTitleLabel.text = promoDetail.promoTitle
        promoDescriptionLabel.text = promoDetail.promoDesc
        
        self.promoImage.kf.setImage(with: promoDetail.promoImageURL, completionHandler: { result in
            result.map({ result in
                DispatchQueue.main.async {
                    self.promoImage.image = result.image
                }
            })
        })
    }
    
    private func setupLayout() {
        view.addSubview(baseStackView)
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        baseStackView.addArrangedSubview(promoImage)
        baseStackView.addArrangedSubview(titleAndDescriptionStackView)
        baseStackView.addArrangedSubview(spacer)
        
        promoImage.translatesAutoresizingMaskIntoConstraints = false
        promoImage.heightAnchor.constraint(equalToConstant: 165).isActive = true
        
        titleAndDescriptionStackView.addArrangedSubview(promoTitleLabel)
        titleAndDescriptionStackView.addArrangedSubview(promoDescriptionLabel)
    }
    
}
