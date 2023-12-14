//
//  PromoListTableViewCell.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import UIKit
import Kingfisher

class PromoListTableViewCell: UITableViewCell {
    let baseView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let promoImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let promoNameAndDescStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()
    
    let promoNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let promoDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    var promoCellEntity: PromoListEntity?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(promo: PromoListEntity) {
        promoCellEntity = promo
        promoNameLabel.text = promoCellEntity?.promoName
        promoDescLabel.text = promoCellEntity?.promoDescription
        
        self.promoImage.kf.setImage(with: self.promoCellEntity?.promoImageSmallURL, completionHandler: { result in
            result.map({ result in
                DispatchQueue.main.async {
                    self.promoImage.image = result.image
                }
            })
        })
        
    }
    
    private func setupLayout() {
        contentView.addSubview(baseView)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        baseView.addSubview(baseStackView)
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: baseView.topAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
        ])
        
        baseStackView.addArrangedSubview(promoImage)
        promoImage.translatesAutoresizingMaskIntoConstraints = false
        promoImage.heightAnchor.constraint(equalToConstant: 130).isActive = true
        baseStackView.addArrangedSubview(promoNameAndDescStackView)
        
        promoNameAndDescStackView.addArrangedSubview(promoNameLabel)
        promoNameAndDescStackView.addArrangedSubview(promoDescLabel)
    }
}
