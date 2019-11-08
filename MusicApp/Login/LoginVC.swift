//
//  LoginVC.swift
//  MusicApp
//
//  Created by Trung Le on 09/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class LoginVC: UIViewController {

    let loginView = UIImageView()
    let bestLabel: UILabel = {
        let label = UILabel()
        label.text = "BEST"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    let musicLabel: UILabel = {
        let label = UILabel()
        label.text = "MUSIC"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    let titleLabel1: UILabel = {
        let label = UILabel()
        label.text = "Hàng triệu bài hát."
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "Miễn phí trên Best Music."
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    let btnFacebook: UIButton = {
        let button = UIButton()
        button.setTitle("TIẾP TỤC VỚI FACEBOOK", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
        button.layer.cornerRadius = 15
        return button
    }()
    let btnRegister: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG KÍ MIỄN PHÍ", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red:0.35, green:0.69, blue:0.18, alpha:1.0)
        button.addTarget(self, action: #selector(onRegister), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    let btnSingIn: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG NHẬP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(AppDelegate.backgroundColor, for: .normal)
        button.addTarget(self, action: #selector(onSingIn), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppDelegate.backgroundColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        view.sv(loginView, bestLabel, musicLabel, titleLabel1, titleLabel2, btnFacebook,btnRegister,btnSingIn)
        
        loginView.top(40).left(20).size(175)
        loginView.image = UIImage(named: "logos")
        
        bestLabel.top(90).height(60).right(0).Left == loginView.Right + 4
        musicLabel.height(60).right(0).Left == loginView.Right + 4
        musicLabel.Top == bestLabel.Bottom
        
        titleLabel1.top(270).centerHorizontally().height(31)
        titleLabel2.centerHorizontally().height(31).Top == titleLabel1.Bottom
        
        btnRegister.top(410).centerHorizontally().width(240).height(40)
        btnFacebook.top(466).centerHorizontally().width(240).height(40)
        btnSingIn.top(522).centerHorizontally().width(240).height(40)
    }
    
    @objc func onRegister(){
        let registerVC = RegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    @objc func onSingIn(){
        let singInVC = SingInVC()
        self.navigationController?.pushViewController(singInVC, animated: true)
        
    }
   
}
