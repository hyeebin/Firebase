//
//  PwResetViewController.swift
//  Firebase
//
//  Created by cubicinc on 2023/07/03.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class PwResetViewController: UIViewController {
    
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
    
    lazy var titleLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호 재설정"
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTf: UITextField = {
        var view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "이메일을 입력해주세요"
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var alertLb: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "로그인 정보가 일치하지 않습니다"
        label.textColor = .systemRed
        label.textAlignment = .left
        return label
    }()
    
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("임시 비밀번호 이메일로 보내기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    let emailPattern = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$"
    var emailValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "비밀번호 재설정"
        view.backgroundColor = .white
        addViews()
        applyConstraints()
        addTarget()
        
        alertLb.isHidden = true
    }

    fileprivate func addViews() {
        view.addSubview(baseView)
        baseView.addSubview(stackView)
        stackView.addArrangedSubview(titleLb)
        stackView.addArrangedSubview(emailTf)
        stackView.addArrangedSubview(alertLb)
        stackView.addArrangedSubview(loginBtn)
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
        
        let emailTfConstraints = [
            emailTf.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(baseViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(emailTfConstraints)
    }
        
    fileprivate func addTarget() {
        loginBtn.addTarget(self, action: #selector(didTaploginButton(_:)), for: .touchUpInside)
        
        emailTf.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    fileprivate func isValid(text: String, pattern: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: text)
    }
    
    fileprivate func checkEmail() {
        if isValid(text: emailTf.text!, pattern: emailPattern) {
            emailValid = true
        } else {
            emailValid = false
        }
    }
    
    fileprivate func checkAll() {
        if emailValid {
            print("email, pw Valid Success")
        } else {
            print("email, pw Valid Fail")
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) -> Bool {
        switch sender {
        case emailTf:
            checkEmail()
        default:
            break
        }
        checkAll()
        return true
    }
    
    @objc func didTaploginButton(_ sender: UIButton) {
        if let email = emailTf.text {
            print("Email : ",email)
        }
        
        alertLb.isHidden = false
        
        if emailValid {
            sendPasswordReset()
        } else if !emailValid {
            alertLb.text = "이메일/비밀번호 형식이 틀렸습니다"
            alertLb.textColor = .systemRed
        }
    }
    
    fileprivate func sendPasswordReset() {
        guard let email = emailTf.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [self] error in
            guard let error = error else {
                print("메세지 보내기 성공")
                return
            }
            let nsError : NSError = error as NSError
            switch nsError.code {
            case 17011:
                alertLb.text = "존재하지 않는 이메일입니다"
                print("메세지 보내기 실패")
            default:
                break
            }
        }
    }
}
