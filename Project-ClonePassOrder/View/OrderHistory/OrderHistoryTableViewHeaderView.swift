//
//  OrderHistoryTableViewHeaderView.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/24.
//

import UIKit
import SnapKit

final class OrderHistoryTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주문내역"
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderDateSelectButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setLayout
    
    private func setLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(orderDateSelectButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        orderDateSelectButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
