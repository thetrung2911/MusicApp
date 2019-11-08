//
//  AlbumTableCell.swift
//  MusicApp
//
//  Created by Trung Le on 11/6/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class AlbumTableCell: UITableViewCell {
    lazy var songLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    lazy var authorLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.sv(songLabel,authorLabel)
        
        songLabel.left(16).right(0).top(12)
        
        authorLabel.left(16).right(0).bottom(12).Top == songLabel.Bottom
        
    }
    func setupDataSong(songs: Songs){
       
        self.songLabel.text = songs.song
        self.authorLabel.text = songs.author
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
