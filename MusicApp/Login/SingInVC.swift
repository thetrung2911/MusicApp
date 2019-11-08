//
//  SingInVC.swift
//  MusicApp
//
//  Created by Trung Le on 11/8/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import TextFieldEffects
import Firebase

class SingInVC: UIViewController {
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Đăng Nhập"
        label.font = Font.bold32
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let txtEmail: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Email hoặc tên người dùng"
        tf.placeholderColor = .white
        tf.placeholderFontScale = 1.0
        tf.tintColor = .white
        tf.textColor = .white
        tf.backgroundColor = AppDelegate.backgroundColor
        tf.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
        return tf
    }()
    
    let txtPassword: HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Mật khẩu"
        tf.placeholderColor = .white
        tf.placeholderFontScale = 1.0
        tf.tintColor = .white
        tf.textColor = .white
        tf.backgroundColor = AppDelegate.backgroundColor
        // set underline cho textfield
        tf.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let lblForgot: UILabel = {
        let label = UILabel()
        label.text = "Forgot password?"
        label.textColor = .white
        label.font = Font.system12
        return label
    }()
    
    let btnLogin: UIButton = {
        let button = UIButton()
        button.setTitle("Đăng Nhập", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Font.bold24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        
        return button
    }()
    let lblAccount: UILabel = {
        let label = UILabel()
        label.text = "Dont have an account? Regsiter"
        label.textAlignment = .center
        label.textColor = .white
        label.font = Font.system12
        return label
    }()
    
    
    let scrollView = TPKeyboardAvoidingScrollView()
    let containerView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    let validation = Validation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppDelegate.backgroundColor
        
        setupView()
        btnLogin.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtEmail.tag = 100
        txtPassword.tag = 101
        
    }
    @objc func handleSignIn(){
        guard let email = txtEmail.text else { return}
        guard let pass = txtPassword.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil {
                
                UIView.animate(withDuration: 1, animations: {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.style = .gray
                }, completion: { (_) in
                    self.activityIndicator.stopAnimating()
                })
                
                
                DispatchQueue.main.async {
                    let tabBarVC = setupTabBarController()
                    tabBarVC.navigationItem.hidesBackButton = true
                    self.navigationController?.pushViewController(tabBarVC, animated: false)
                    
                }
                
            }
            else{
                
                AlertHelper.showAlert(message: error!.localizedDescription, viewController: self)
                
            }
        }
    }
    
    func setupView(){
        
        view.sv(
            scrollView.sv(
                containerView.sv(
                    
                    lblTitle,
                    txtEmail,
                    txtPassword,
                    lblForgot,
                    btnLogin,
                    lblAccount,
                    activityIndicator
                )
            )
            
            
        )
        
        //lblTitle.Top == view.safeAreaLayoutGuide.Top + 30
        
        
        scrollView.Top == view.safeAreaLayoutGuide.Top
        view.layout(
            0,
            |-0-scrollView-0-|,
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
            |lblTitle.centerHorizontally()|,
            20,
            |-16-txtEmail-16-| ~ 50,
            30,
            |-16-txtPassword-16-| ~ 50,
            10,
            |-(>=50)-lblForgot-16-|,
            50,
            |-50-btnLogin-50-| ~ 50,
            20,
            |lblAccount.centerHorizontally()|,
            10,
            |activityIndicator.centerHorizontally()|,
            (>=20)
            
            
        )
        
    }
    
}
extension SingInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.setBottomBorder(color: UIColor.white.cgColor,height: 2.0)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.setBottomBorder(color: UIColor.white.cgColor,height: 1.0)
    }
}
