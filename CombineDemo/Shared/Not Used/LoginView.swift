//
//  LoginView.swift
//  CombineDemo
//
//  Created by Michal Cichecki on 07/06/2019.
//

import UIKit

final class LoginView: UIView {
    
    lazy var loginTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var loginButton = UIButton()
    lazy var myText = UILabel()
    lazy var button2 = UIButton()
    
    lazy var activityIndicator = ActivityIndicatorView(style: .medium)
    
    var isLoading: Bool = false {
        didSet { isLoading ? startLoading() : finishLoading() }
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    private func addSubviews() {
        [loginTextField, passwordTextField, loginButton, activityIndicator, button2]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30.0),
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40.0),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40.0),
            loginTextField.heightAnchor.constraint(equalToConstant: 30.0),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10.0),
            passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor, multiplier: 1.0),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            loginButton.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120.0),
            loginButton.heightAnchor.constraint(equalToConstant: 30.0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50.0),
            
            button2.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            button2.centerXAnchor.constraint(equalTo: centerXAnchor),
            button2.widthAnchor.constraint(equalToConstant: 50),
            button2.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setUpViews() {
        backgroundColor = .background
        loginTextField.backgroundColor = .systemBackground
        loginTextField.placeholder = "login"
        
        passwordTextField.backgroundColor = .systemBackground
        passwordTextField.placeholder = "password"
        
        loginButton.setTitle("Log in", for: UIControl.State())
        loginButton.setTitleColor(.white, for: UIControl.State())
        loginButton.backgroundColor = .nonValid
        loginButton.isUserInteractionEnabled = true
        
        button2.setTitle("Log in", for: UIControl.State())
        button2.setTitleColor(.white, for: UIControl.State())
        button2.backgroundColor = .nonValid
        button2.isUserInteractionEnabled = true
    }
}
