//
//  ViewController.swift
//  Firebase
//
//  Created by cubicinc on 2023/06/20.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(loginBtn)
        
        loginBtn.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)

        let loginBtnConstraints = [
            loginBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loginBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        NSLayoutConstraint.activate(loginBtnConstraints)
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        print("join")
        let joinVC = JoinViewController()
        joinVC.modalPresentationStyle = .overFullScreen
        present(joinVC, animated: true)
    }
}

