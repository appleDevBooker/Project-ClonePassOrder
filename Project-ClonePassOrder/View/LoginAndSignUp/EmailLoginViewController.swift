//
//  EmailLoginController.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/16.
//

import SnapKit
import UIKit
import SVProgressHUD

class EmailLoginViewController: UIViewController {
    
    //MARK: - 프로퍼티
    
     var authViewModel: AuthViewModel = AuthViewModel()
    private let emailLoginButton: UIButton = UIButton().emailLoginButton()
    private let emailTextField: UITextField = UITextField().loginTextField(returnKey: .next)
    private let passwordTextField: UITextField = UITextField().loginTextField(returnKey: .continue)
    private let emailLabel: UILabel = UILabel().emailLoginLabel(text: "아이디")
    private let passwordLabel: UILabel = UILabel().emailLoginLabel(text: "비밀번호")
    private let welcomeView: UIView = UIView().welcomeView(text: "이메일로 로그인하기",height: 10)
        
    //MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSetAttribute()
        setAtrribute()
        setLayout()
        setBind()
    }
    
    //MARK: - 셀렉터메서드
    @objc func emailLoginButtonTapped() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        authViewModel.userLogin(email: email, password: password)
    }
    
    //MARK: - 메서드
    private func setLayout() {
        [emailTextField,emailLabel,passwordTextField,passwordLabel,emailLoginButton].forEach {
            view.addSubview($0)
        }
        self.welcomViewSetLayout(view: view, welcomeView: welcomeView)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeView.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField).offset(-20)
            make.leading.equalTo(emailTextField)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        passwordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField).offset(-20)
            make.leading.equalTo(passwordTextField)
        }
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    private func setAtrribute() {
        view.backgroundColor = .systemBackground
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailLoginButton.addTarget(self,
                                   action: #selector(emailLoginButtonTapped),
                                   for: .touchUpInside)
        emailTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true
    }
    private func naviSetAttribute() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
    }
    private func setBind() {
        authViewModel.textfildEmpty.bind { [weak self] _ in
            Toast.message(superView: self!.view, text: self!.authViewModel.textFieldEmptyString())
        }
        authViewModel.loginStart.bind { [weak self] bool in
            SVProgressHUD.SVshow(view: self!.view, text: "로그인중입니다...", button: [self!.emailLoginButton])
        }
        authViewModel.authError.bind { [weak self] error in
            Toast.message(superView: self!.view, text: error.errorMessage)
            SVProgressHUD.SVoff(view: self!.view, button: [self!.emailLoginButton])
        }
        authViewModel.uid.bind { uid in
            guard let uid = uid else {
                return
            }
            UserViewModel.shared.userFetch(uid: uid)
        }
        UserViewModel.shared.model.bind { [weak self] _ in
            SVProgressHUD.SVoff(view: self!.view, button: [self!.emailLoginButton])
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            guard let delegate = sceneDelegate else {
                return
            }
            delegate.window?.rootViewController = TabBarController()
        }
    }
}

//MARK: - 텍스트필드 델리게이트
extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            emailLoginButtonTapped()
        }
        return true
    }
}
