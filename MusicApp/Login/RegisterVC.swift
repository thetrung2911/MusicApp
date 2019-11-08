//
//  RegisterVC.swift
//  MusicApp
//
//  Created by Trung Le on 11/8/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import TextFieldEffects
import Firebase

class RegisterVC: UIViewController {
    
    let txtName: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Nhập tên của bạn"
        tl.placeholderColor = .white
        tl.backgroundColor = AppDelegate.backgroundColor
        tl.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
        
        return tl
    }()
    
    let txtEmail: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Nhập Email của bạn"
        tl.placeholderColor = .white
        tl.backgroundColor = AppDelegate.backgroundColor
        tl.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
        
        return tl
    }()
    
    let txtPassword: HoshiTextField = {
        let tl = HoshiTextField()
        tl.placeholder = "Nhập mật khẩu"
        tl.placeholderColor = .white
        tl.backgroundColor = AppDelegate.backgroundColor
        tl.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
        
        return tl
    }()
    
    let btnRegister: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng kí", for: .normal)
        button.backgroundColor = UIColor(red:0.35, green:0.69, blue:0.18, alpha:1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let lblEror: UILabel = {
        let le = UILabel()
        le.numberOfLines = 0
        le.textColor = .red
        le.textAlignment = .center
        
        return le
    }()
    let scrollView = TPKeyboardAvoidingScrollView()
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    let validation = Validation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = AppDelegate.backgroundColor
        title = "Đăng kí"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        setupView()
        btnRegister.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtName.tag = 100
        txtEmail.tag = 101
        txtPassword.tag = 102
        
    }
    
    @objc func handleSignUp(){
        
        let error = validateField()
        
        if error != nil {
            //showError(error!)
            AlertHelper.showAlert(message: error!, viewController: self)
        }
        else
        {
            guard let name = txtName.text else {return}
            guard let email = txtEmail.text else {return}
            guard let pass = txtPassword.text else {return}
            
            
            
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                if error == nil && user != nil {
                    print("User created")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges(completion: { (error) in
                        if error == nil {
                            print("user display name changed")
                            
                            UIView.animate(withDuration: 1, animations: {
                                self.activityIndicator.isHidden = false
                                self.activityIndicator.startAnimating()
                                self.activityIndicator.style = .gray
                            }, completion: { (_) in
                                self.activityIndicator.stopAnimating()
                            })
                            
                            DispatchQueue.main.async {                                self.navigationController?.pushViewController(setupTabBarController(), animated: true)
                            }
                            
                        }
                    })
                }else{
                    print("Error:\(error!.localizedDescription)")
                }
            }
        }
    }
    
    func setupView(){
        txtPassword.isSecureTextEntry = true
        
        view.sv(scrollView)
        scrollView.sv(containerView)
        containerView.sv(txtName,txtEmail,txtPassword,btnRegister,activityIndicator)
        
        //        scrollView.Top == view.safeAreaLayoutGuide.Top
        //        scrollView.bottom(0).centerHorizontally().width(100%)
        //        containerView.top(20).centerHorizontally().bottom(0).Width == view.Width
        //        txtName.top(20).right(16).left(16).height(50)
        //        txtEmail.left(16).right(16).height(50).Top == txtName.Bottom + 30
        //        txtPassword.left(16).right(16).height(50).Top == txtEmail.Bottom + 30
        //        btnRegister.left(50).right(50).height(50).Top == txtPassword.Bottom + 50
        //        activityIndicator.centerHorizontally().Top == btnRegister.Bottom + 10
        scrollView.Top == view.safeAreaLayoutGuide.Top
        
        
        view.layout(
            0,
            |scrollView|,
            0
        )
        
        scrollView.layout(
            20,
            |containerView|,
            0
        )
        containerView.Width == view.Width
        containerView.layout(
            20,
            |-16-txtName-16-| ~ 50,
            30,
            |-16-txtEmail-16-| ~ 50,
            30,
            |-16-txtPassword-16-| ~ 50,
            50,
            |-50-btnRegister-50-| ~ 50,
            10,
            |activityIndicator.centerHorizontally()|,
            (>=20)
            
            
        )
        
    }
    
    func showError(_ message:String){
        lblEror.text = message
        lblEror.alpha = 1
    }
    func validateField() -> String?{
        
        
        if txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        let cleanPassword = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validatePassword(cleanPassword!) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        let cleanName = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validateName(cleanName!) == false {
            // Password isn't secure enough
            return "Name is invalid"
        }
        
        let cleanEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validation.validateEmailId(cleanEmail!) == false {
            // Password isn't secure enough
            return "Email is invalid"
        }
        
        
        return nil
    }
}
extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBottomBorder(color: UIColor(red:0.35, green:0.69, blue:0.18, alpha:1.0).cgColor,height: 2.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
    }
}

