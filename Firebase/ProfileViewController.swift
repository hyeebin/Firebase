//
//  ProfileViewController.swift
//  Firebase
//
//  Created by cubicinc on 2023/07/11.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ProfileViewController: UIViewController {
    lazy var baseView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    lazy var stackView: UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 12
        return view
    }()
    
    lazy var nameLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "닉네임"
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameTf: UITextField = {
        var view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "닉네임을 입력해주세요"
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var changeNameBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("닉네임 변경", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    lazy var profileImg: UIImageView = {
        var view = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 2
        return view
    }()
    
    lazy var changeImgBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("프로필 변경", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    override func loadView() {
        super.loadView()
        getProfileInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "프로필관리"
        view.backgroundColor = .white
        addViews()
        applyConstraints()
        addTarget()
    }

    fileprivate func addViews() {
        view.addSubview(baseView)
        baseView.addSubview(stackView)
        stackView.addArrangedSubview(changeImgBtn)
        stackView.addArrangedSubview(nameLb)
        stackView.addArrangedSubview(nameTf)
        stackView.addArrangedSubview(changeNameBtn)
        baseView.addSubview(profileImg)

    }
    
    fileprivate func applyConstraints() {
        let baseViewConstraints = [
            baseView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            baseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
    
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
        ]
        
        let nameTfConstraints = [
            nameTf.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let profileImgConstraints = [
            profileImg.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            profileImg.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 30),
            profileImg.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -30),
        ]
        
        NSLayoutConstraint.activate(baseViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(nameTfConstraints)
        NSLayoutConstraint.activate(profileImgConstraints)

    }
        
    fileprivate func addTarget() {
        changeNameBtn.addTarget(self, action: #selector(didTapchangeNameButton(_:)), for: .touchUpInside)
        changeImgBtn.addTarget(self, action: #selector(didTapchangeImgButton(_:)), for: .touchUpInside)
    }
        
    @objc func didTapchangeNameButton(_ sender: UIButton) {
        changeName()
    }
    
    @objc func didTapchangeImgButton(_ sender: UIButton) {
        changeImg()
    }
    
    fileprivate func changeName() {
        guard let name = nameTf.text else { return }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { [self] error in
            guard let error = error else {
                nameLb.text = name
                return
            }
            print("Error : ",error)
        }
    }
    
    fileprivate func changeImg() {
        let imageURL =  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGpoKZBzAsDRMIYXSKRRjkhKAqzSxQ1wq9wQ&usqp=CAU"
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = URL(string: imageURL)
        changeRequest?.commitChanges { [self] error in
            guard let error = error else {
                let url = URL(string: imageURL)
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.profileImg.image = image
                            }
                        }
                    }
                }
                return
            }
            print(error)
        }
    }
    
    fileprivate func getProfileInfo() {
        if let user = Auth.auth().currentUser {
            if let photoURL = user.photoURL {
                let url = photoURL
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.profileImg.image = image
                            }
                        }
                    }
                }            }
            if let userName = user.displayName {
                nameLb.text = userName
            }
        }
        else {
            print("Login : Error")
        }
    }
    
}
