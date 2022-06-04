//
//  StoreDetailTableViewHeaderView.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/25.
//

import UIKit
import SnapKit

final class StoreDetailTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - UI Properties

    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "빽따방!"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()
    private let storeDescription: UILabel = {
        let label = UILabel()
        label.text = """
                    백종원이 하는 백다방!
                    커피가 맛있어요👍🏻
                    """
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    let informationButton: UIButton = {
        let button = UIButton()
        button.setTitle("정보", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(informationButtonTapped), for: .touchUpInside)
        return button
    }()
    let storyButton: UIButton = {
        let button = UIButton()
        button.setTitle("스토리", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(moveStoryButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var informationStoryButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [informationButton, storyButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let presentingSelectedButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    // MARK: - Initializer

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
        informationButtonTapped()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setLayout

    private func setLayout() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(storeImageView)
        contentView.addSubview(storeNameLabel)
        contentView.addSubview(storeDescription)
        contentView.addSubview(informationStoryButtonStackView)
        contentView.addSubview(presentingSelectedButtonView)
        contentView.bringSubviewToFront(presentingSelectedButtonView)
        
        storeImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(600)
            make.width.equalToSuperview()
        }
        storeNameLabel.snp.makeConstraints { make in
            make.top.equalTo(storeImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        storeDescription.snp.makeConstraints { make in
            make.top.equalTo(storeNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        informationStoryButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(storeDescription.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - Methods

    @objc private func moveStoryButtonTapped() {
        self.presentingSelectedButtonView.snp.remakeConstraints { make in
            make.top.equalTo(informationStoryButtonStackView.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(1)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).priority(200)
            make.centerX.equalTo(storyButton)
        }
        storyButton.isEnabled = false
        storyButton.setTitleColor(.black, for: .normal)
        informationButton.setTitleColor(.gray, for: .normal)
        informationButton.isEnabled = true
    }
    @objc private func informationButtonTapped() {
        self.presentingSelectedButtonView.snp.remakeConstraints { make in
            make.top.equalTo(informationStoryButtonStackView.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(1)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).priority(200)
            make.centerX.equalTo(informationButton)
        }
        informationButton.isEnabled = false
        informationButton.setTitleColor(.black, for: .normal)
        storyButton.setTitleColor(.gray, for: .normal)
        storyButton.isEnabled = true
    }
}
