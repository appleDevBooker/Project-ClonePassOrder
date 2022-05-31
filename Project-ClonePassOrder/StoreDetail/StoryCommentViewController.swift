//
//  StoryCommentViewController.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/26.
//

import UIKit
import SnapKit

final class StoryCommentViewController: UIViewController {

    // MARK: - UI Properties

    private let commentTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    private let floatingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let commentTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.placeholder = "댓글을 입력해 주세요"
        textField.addLeftPadding()
        return textField
    }()
    private let commentWriteCompletButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.isEnabled = false
        return button
    }()

    // MARK: - viewLifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setNavigation()
        setTableView()
        setTextField()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:))))
        
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
        
        view.addSubview(commentTableView)
        view.addSubview(floatingView)
        floatingView.addSubview(commentTextField)
        floatingView.addSubview(commentWriteCompletButton)
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(floatingView.snp.top)
        }
        floatingView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(80)
        }
        commentTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(30)
        }
        commentWriteCompletButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextField)
            make.width.equalTo(40)
            make.trailing.equalTo(commentTextField).inset(10)
        }
    }

    // MARK: - setTableView

    private func setTableView() {
        commentTableView.separatorStyle = .none
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - setTextField

    private func setTextField() {
        commentTextField.delegate = self
    }

    // MARK: - setNavigation

    private func setNavigation() {
        title = "댓글"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark")
            , style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Methods

    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    @objc private func moreButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "신고", style: .default))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    @objc private func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -300
    }
    @objc private func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension StoryCommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = commentTableView.dequeueReusableCell(withIdentifier: "cell") as? CommentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return cell
    }
}

// MARK: - UITextFieldDelegate

extension StoryCommentViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if range.location == 0 && range.length != 0 {
            commentWriteCompletButton.isEnabled = false
            commentWriteCompletButton.setTitleColor(.gray, for: .normal)
        } else {
            commentWriteCompletButton.isEnabled = true
            commentWriteCompletButton.setTitleColor(.orange, for: .normal)
        }
        return true
    }
}

// MARK: - extension UITextField

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
