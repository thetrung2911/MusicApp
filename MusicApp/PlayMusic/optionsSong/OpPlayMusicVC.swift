//
//  opPlayMusicVC.swift
//  MusicApp
//
//  Created by Trung Le on 10/16/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import Kingfisher

class OpPlayMusicVC: UIViewController {
    static var imageURL = ""
    let urlImage = URL(string: PlayMusicVC.imageURL)
    
    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let contenerView = UIView()
    let imageView = UIImageView()
    let songView = UIView()
    let optionTable = UITableView()
    let closeButton = UIButton()
    let lblSong: UILabel = {
        let label = UILabel()
//        label.text = AlbumVC.json![1]["title"].stringValue
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    let lblAuthor: UILabel = {
        let label = UILabel()
//        label.text = AlbumVC.json![1]["author"].stringValue
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    var data = [OptionSongs]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataOption()
        
        let blueEffect = UIBlurEffect(style: .light)
        view.sv(blurView)
        blurView.effect = blueEffect
        blurView.top(0).left(0).right(0).bottom(0)
        blurView.contentView.sv(contenerView)
        
        contenerView.centerHorizontally().top(0).bottom(0).width(90%)
        contenerView.backgroundColor = AppDelegate.backgroundColor.withAlphaComponent(0.20)
        
        contenerView.sv(imageView,songView,optionTable,closeButton)
        
        imageView.centerHorizontally().top(32).size(250)
        imageView.kf.setImage(with: urlImage)
        imageView.kf.indicatorType = .activity
        
        songView.centerHorizontally().width(100%).height(56).Top == imageView.Bottom + 8
        songView.sv(lblSong, lblAuthor)
        lblSong.top(0).centerHorizontally().width(100%).height(32)
        lblAuthor.bottom(0).centerHorizontally().width(100%).height(24)
        
        
        closeButton.centerHorizontally().width(100%).height(40).bottom(0)
        closeButton.setTitle("ĐÓNG", for: .normal)
        closeButton.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        
        optionTable.centerHorizontally().width(100%).Top == songView.Bottom + 4
        optionTable.Bottom == closeButton.Top
        optionTable.backgroundColor = .clear
        optionTable.dataSource = self
        optionTable.delegate = self
        optionTable.separatorStyle = .none
        optionTable.tableFooterView = UIView()
        
        optionTable.register(OptionsCell.self, forCellReuseIdentifier: "option")
        
    }
    
    func setupDataOption(){
        data.append(OptionSongs(_title: "Ẩn bài hát", _image: UIImage(named: "no")!))
        data.append(OptionSongs(_title: "Thêm vào playlist", _image: UIImage(named: "addmusic")!))
        data.append(OptionSongs(_title: "Chia sẻ", _image: UIImage(named: "share")!))
        data.append(OptionSongs(_title: "Xem nghệ sĩ", _image: UIImage(named: "admin")!))
        
    }
    
    @objc func onClose(){
        self.dismiss(animated: true, completion: nil)
    }
}
extension OpPlayMusicVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = optionTable.dequeueReusableCell(withIdentifier: "option", for: indexPath) as? OptionsCell else {
            fatalError("fail")
        }
        cell.backgroundColor = .clear
        cell.setUpData(optionSong: data[indexPath.row] )
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.5
    }
    
}
