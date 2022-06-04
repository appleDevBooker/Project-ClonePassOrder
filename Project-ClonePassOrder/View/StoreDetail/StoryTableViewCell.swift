//
//  StoryTableViewCell.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

final class StoryTableViewCell: UITableViewCell {

    // MARK: - UI Properties

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "프로필명"
        return label
    }()
    let createdDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.text = "4일 전"
        return label
    }()
    lazy var nameDateStackView: UIStackView = {
        let stackView = UIStackView()
        [profileNameLabel, createdDateLabel].forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameDateStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    lazy var userStackView: UIStackView = {
        let stackView = UIStackView()
        [profileStackView, moreButton].forEach{ stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    let storyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = """
                     너무 맛있구여
                     친절 하시구여
                     다음에 또 올거구여
                     """
        return label
    }()
    let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .gray
        return imageView
    }()
    let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("좋아요 0개", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    let commentsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("댓글 0개", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        [likeButton, commentsButton].forEach{ stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
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

    func setLayout() {
        contentView.addSubview(userStackView)
        contentView.addSubview(storyLabel)
        contentView.addSubview(storyImageView)
        contentView.addSubview(buttonStackView)
        contentView.addSubview(seperator)
        
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
        }
        userStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        storyLabel.snp.makeConstraints { make in
            make.top.equalTo(userStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        storyImageView.snp.makeConstraints { make in
            make.top.equalTo(storyLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(storyImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        seperator.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
