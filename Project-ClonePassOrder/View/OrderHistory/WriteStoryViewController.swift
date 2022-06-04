//
//  WriteStoryViewController.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/25.
//

import UIKit
import SnapKit

final class WriteStoryViewController: UIViewController {

    // MARK: - UI Properties

    private let storeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘도, 카페일리터 동두천점"
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "스토리를 작성해 주세요"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    private let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    private let registePictureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 등록이 필요해요"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let registePictureButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "addPicture"), for: .normal)
        return button
    }()
    private let storytitleLabel: UILabel = {
        let label = UILabel()
        let text = "Q 음료의 양은 어땠나요?"
        label.text = "Q 음료의 양은 어땠나요?"
        label.font = .systemFont(ofSize: 20)
        
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.orange, range: (text as NSString).range(of: "Q"))
        label.attributedText = attributeString
        return label
    }()
    private let storyTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        return textView
    }()
    private let floatingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setTitle("작성하기", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4730066061, blue: 0.2864735723, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    private lazy var informationLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storeNameLabel, informationLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        return stackView
    }()
    private lazy var writeStoryInpormationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [informationLabelStackView, storeImageView])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setLayout()
        dismissKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: - setLayout

    private func setLayout() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        
        view.addSubview(writeStoryInpormationStackView)
        view.addSubview(registePictureTitleLabel)
        view.addSubview(registePictureButton)
        view.addSubview(storytitleLabel)
        view.addSubview(storyTextView)
        view.addSubview(floatingView)
        floatingView.addSubview(floatingButton)
        
        storeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        writeStoryInpormationStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        registePictureTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(writeStoryInpormationStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        registePictureButton.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(registePictureTitleLabel.snp.bottom).offset(20)
        }
        storytitleLabel.snp.makeConstraints { make in
            make.top.equalTo(registePictureButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        storyTextView.snp.makeConstraints { make in
            make.top.equalTo(storytitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        floatingView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        floatingButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - setNavigation

    private func setNavigation() {
        title = "스토리 작성"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Methods
    @objc private func back() {
        dismiss(animated: true)
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -320
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}
