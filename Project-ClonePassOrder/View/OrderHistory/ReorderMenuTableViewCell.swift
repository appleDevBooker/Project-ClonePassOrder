//
//  ㄲeorderMenuTableViewCell.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

final class ReorderMenuTableViewCell: UITableViewCell {

    // MARK: - UI Properties

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "제주 한라봉 스무디"
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "5,500원"
        label.textAlignment = .right
        return label
    }()
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tall"
        return label
    }()
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "x 1"
        label.textAlignment = .right
        return label
    }()
    private lazy var namePriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var optionQuantityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [optionLabel, quantityLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setLayout

    private func setLayout() {
        contentView.addSubview(namePriceStackView)
        contentView.addSubview(optionQuantityStackView)
        
        namePriceStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        optionQuantityStackView.snp.makeConstraints { make in
            make.top.equalTo(namePriceStackView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
}
