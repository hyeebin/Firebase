//
//  ViewController.swift
//  Firebase
//
//  Created by cubicinc on 2023/06/20.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var joinBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        return button
    }()

    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그인", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(joinBtn)
        view.addSubview(loginBtn)

        joinBtn.addTarget(self, action: #selector(didTapJoinButton(_:)), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)

        let joinBtnConstraints = [
            joinBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            joinBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            joinBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            joinBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        let loginBtnConstraints = [
            loginBtn.topAnchor.constraint(equalTo: joinBtn.bottomAnchor, constant: 40),
            loginBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        NSLayoutConstraint.activate(joinBtnConstraints)
        NSLayoutConstraint.activate(loginBtnConstraints)
    }
    
    @objc func didTapJoinButton(_ sender: UIButton) {
        let joinVC = JoinViewController()
        joinVC.modalPresentationStyle = .overFullScreen
        present(joinVC, animated: true)
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true)
    }
}

