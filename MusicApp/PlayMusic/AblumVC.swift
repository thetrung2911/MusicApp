//
//  AblumVC.swift
//  MusicApp
//
//  Created by Trung Le on 10/14/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class AblumVC: UIViewController {

    let playButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppDelegate.backColor
//        self.tabBarController?.tabBar.isHidden = false
        navigationItem.title = "Tên Ablum"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.sv(playButton)
        
        playButton.width(100).height(32).top(435).centerHorizontally()
        playButton.backgroundColor = UIColor(red:0.54, green:0.17, blue:0.89, alpha:1.0)
        playButton.setTitle("Play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 16
        playButton.addTarget(self, action: #selector(onPlayVC), for: .touchUpInside)
        
    }
    @objc func onPlayVC(){
        let playVC = PlayMusicVC()
//
//        self.navigationController?.pushViewController(playVC, animated:
//        true)
        self.present(playVC, animated: true, completion: nil)
    }
    

  
}
