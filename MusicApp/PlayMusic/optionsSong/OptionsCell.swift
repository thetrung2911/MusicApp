//
//  OptionsCell.swift
//  MusicApp
//
//  Created by Trung Le on 10/16/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class OptionsCell: UITableViewCell {

    
    lazy var title : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.sizeToFit()
        return label
    }()
    lazy var icon : UIImageView = {
        let image = UIImageView()
        return image
    }()
    func setUpData(optionSong: OptionSongs){
        self.title.text = optionSong.title
        self.icon.image = optionSong.image
    }
    fileprivate func autoLayoutOptions(){
        self.sv(icon,title)
        icon.centerVertically().width(30).height(30)
        icon.Leading == self.Leading + 16
//        icon.layer.cornerRadius = 40
//        icon.clipsToBounds = true
        
        title.centerVertically()
        title.Leading == icon.Trailing + 10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        autoLayoutOptions()
    }

}
