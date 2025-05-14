//
//  WelcomeViewController.swift
//  Login
//
//  Created by 0-jerry on 5/15/25.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let welcomeMessageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "테스트용 문자"
        label.font = .System.medium20
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton.default(title: "로그아웃")
        
        return button
    }()
    
    private let leaveButton: UIButton = {
        let button = UIButton.default(title: "회원탈퇴")
        
        button.backgroundColor = .systemRed
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubViews(welcomeMessageLabel,
                         logoutButton,
                         leaveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        welcomeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeMessageLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120),
            welcomeMessageLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            welcomeMessageLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: welcomeMessageLabel.bottomAnchor, constant: 200),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leaveButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 40),
            leaveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            leaveButton.widthAnchor.constraint(equalToConstant: 200),
            leaveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}

@available(iOS 17, *)
#Preview {
    WelcomeViewController()
}
