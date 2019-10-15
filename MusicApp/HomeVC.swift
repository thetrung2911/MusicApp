//
//  HomeVC.swift
//  MusicApp
//
//  Created by Trung Le on 9/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import FacebookCore
import FacebookLogin

class HomeVC: UIViewController {
    
    let loginFb = UIButton()
    var strEmail: String!
    var strID: String!
    var strName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        view.backgroundColor = AppDelegate.backColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        view.sv(loginFb)
        
        loginFb.top(200).left(32).right(32).height(60)
        loginFb.backgroundColor = .gray
        
        loginFb.addTarget(self, action: #selector(onPlayMusic), for: .touchUpInside)
        
        
    }
    
    @objc func onPlayMusic(){
        let ablumVC = AblumVC()
        
        self.navigationController?.pushViewController(ablumVC, animated:
        true)
    }
    
    @objc func onLoginFB(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("Users cancelled")
                break
            case .failed(let err):
                print(err)
                break
            case .success(let grantedPermissions, let declinePermissions,let accessToken):
                
                if(grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    // fbLoginManager.logOut()
                }
            }
        }
    }
    
    func getFBUserData () {
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(normal), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    print((result! as AnyObject))
                    //  print(((result! as AnyObject).value(forKey: "id") as? String)!)
                    
                    self.strEmail = ((result! as AnyObject).value(forKey: "email") as? String) ?? ""
                    self.strID = ((result! as AnyObject).value(forKey: "id") as? String) ?? ""
                    self.strName = ((result! as AnyObject).value(forKey: "name") as? String) ?? ""
                    
                    print(self.strID!)
                    print(self.strName!)
                    print(self.strEmail!)
//                    self.TextFBEmail.text = self.strEmail
                    
                }
            })
        }
    }
    
}

