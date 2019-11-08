//
//  HomeCollectionCell.swift
//  MusicApp
//
//  Created by Trung Le on 10/21/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class HomeCollectionCell: UICollectionViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "")
        return imageView
    }()
    
    lazy var nameAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = ""
        label.textColor = .white
        return label
    }()
    lazy var titleAlbum: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = ""
        label.textColor = .white
        return label
    }()
    
    func setupLayout(){
        backgroundColor = .clear
        sv(containerView)
        
        containerView.top(4).left(8).right(0).bottom(4)
        
        containerView.sv(nameAlbum, titleAlbum ,photoImageView)
        
        titleAlbum.bottom(0).left(0).right(0)
        
        nameAlbum.left(0).right(0).Bottom == titleAlbum.Top
        
        photoImageView.top(0).right(0).left(0).Bottom == nameAlbum.Top
    }
    
    
    func setupDataAlbum(album: Album){
        self.photoImageView.image = album.imageAlbum
        self.nameAlbum.text = album.nameAlbum
        self.titleAlbum.text = album.titleAlbum
    }
    
    
    // khởi tạo cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
