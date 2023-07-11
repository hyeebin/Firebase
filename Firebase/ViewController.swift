//
//  ViewController.swift
//  Firebase
//
//  Created by cubicinc on 2023/06/20.
//

import UIKit
import FirebaseAuth
import FirebaseCore

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
    
    lazy var logoutBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그아웃", for: .normal)
        return button
    }()
    
    lazy var pwresetBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("비밀번호 재설정", for: .normal)
        return button
    }()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원탈퇴", for: .normal)
        return button
    }()
    
    lazy var profileBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("프로필관리", for: .normal)
        return button
    }()
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action:  #selector(self.backAction))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(joinBtn)
        view.addSubview(loginBtn)
        view.addSubview(logoutBtn)
        view.addSubview(pwresetBtn)
        view.addSubview(deleteBtn)
        view.addSubview(profileBtn)
    
        joinBtn.addTarget(self, action: #selector(didTapJoinButton(_:)), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        logoutBtn.addTarget(self, action: #selector(didTapLogoutButton(_:)), for: .touchUpInside)
        pwresetBtn.addTarget(self, action: #selector(didTapPwResetButton(_:)), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        profileBtn.addTarget(self, action: #selector(didTapProfileButton(_:)), for: .touchUpInside)

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
        let logoutBtnConstraints = [
            logoutBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 40),
            logoutBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logoutBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logoutBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        let pwresetBtnConstraints = [
            pwresetBtn.topAnchor.constraint(equalTo: logoutBtn.bottomAnchor, constant: 40),
            pwresetBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pwresetBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pwresetBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        let deleteBtnConstraints = [
            deleteBtn.topAnchor.constraint(equalTo: pwresetBtn.bottomAnchor, constant: 40),
            deleteBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        let profileBtnConstraints = [
            profileBtn.topAnchor.constraint(equalTo: deleteBtn.bottomAnchor, constant: 40),
            profileBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileBtn.heightAnchor.constraint(equalToConstant: 64)
        ]
        NSLayoutConstraint.activate(joinBtnConstraints)
        NSLayoutConstraint.activate(loginBtnConstraints)
        NSLayoutConstraint.activate(logoutBtnConstraints)
        NSLayoutConstraint.activate(pwresetBtnConstraints)
        NSLayoutConstraint.activate(deleteBtnConstraints)
        NSLayoutConstraint.activate(profileBtnConstraints)
    }
    
    @objc func didTapJoinButton(_ sender: UIButton) {
        let joinVC = JoinViewController()
        let navVC = UINavigationController(rootViewController: joinVC)
        navVC.modalPresentationStyle = .overFullScreen
        joinVC.navigationItem.leftBarButtonItem = backButton
        present(navVC, animated: true)
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        let loginVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.modalPresentationStyle = .overFullScreen
        loginVC.navigationItem.leftBarButtonItem = backButton
        present(navVC, animated: true)
    }
    
    @objc func didTapLogoutButton(_ sender: UIButton) {
        signOut()
        print("로그아웃")
    }
    
    fileprivate func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @objc func didTapPwResetButton(_ sender: UIButton) {
        let pwresetVC = PwResetViewController()
        let navVC = UINavigationController(rootViewController: pwresetVC)
        navVC.modalPresentationStyle = .overFullScreen
        pwresetVC.navigationItem.leftBarButtonItem = backButton
        present(navVC, animated: true)
    }
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
        let deleteVC = DeleteAccountViewController()
        let navVC = UINavigationController(rootViewController: deleteVC)
        navVC.modalPresentationStyle = .overFullScreen
        deleteVC.navigationItem.leftBarButtonItem = backButton
        present(navVC, animated: true)
    }
    
    @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapProfileButton(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        let navVC = UINavigationController(rootViewController: profileVC)
        navVC.modalPresentationStyle = .overFullScreen
        profileVC.navigationItem.leftBarButtonItem = backButton
        present(navVC, animated: true)
    }
}

