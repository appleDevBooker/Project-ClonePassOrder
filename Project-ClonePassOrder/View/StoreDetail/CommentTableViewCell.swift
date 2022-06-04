//
//  CommentTableViewCell.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

final class CommentTableViewCell: UITableViewCell {

    // MARK: - UI Properties

    private let commentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    private let writerProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    private let writerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "작성자"
        return label
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = """
                         여기 진짜 괜찮은거에요?
                         바이럴 마케팅 아닌가영?
                         """
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    private let writtenTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.05.13"
        label.textColor = .systemGray
        return label
    }()
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    private lazy var bottomAreaStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writtenTimeLabel, moreButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writerNameLabel, commentLabel, bottomAreaStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var contentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [writerProfileImageView, labelsStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .fill
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
        commentView.backgroundColor = .systemGray6
        
        contentView.addSubview(commentView)
        commentView.addSubview(contentsStackView)
        
        commentView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        writerProfileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        moreButton.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        contentsStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
