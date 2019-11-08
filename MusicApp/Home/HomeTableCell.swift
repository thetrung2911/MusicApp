//
//  HomeTableCell.swift
//  MusicApp
//
//  Created by Trung Le on 10/21/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class HomeTableCell: UITableViewCell {
    
    weak var homeVC: HomeVC?
    let data = DataHome.isDataHome
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    let albumView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "album")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(titleLabel, albumView)
        backgroundColor = .clear
        
        titleLabel.top(0).left(8).right(0).height(30)
        
        albumView.top(30).left(0).right(0).bottom(0).height(136.5)
        
        albumView.backgroundColor = .clear
        albumView.delegate = self
        albumView.dataSource = self
        if let flowLayout_1 = albumView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout_1.scrollDirection = .horizontal
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension HomeTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // hàm trả về số item trong một section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch albumView.tag {
        case 0:
            return data.albumArray0.count
        case 1:
            return data.albumArray1.count
        case 2:
            return data.albumArray2.count
        case 3:
            return data.albumArray3.count
        default:
            return 0
        }
    }
    
    // hàm trả về nội dung của mỗi item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "album", for: indexPath) as! HomeCollectionCell
        // gán dữ liệu từng phần tử của mảng vào trong item trong collection
        switch albumView.tag {
        case 0:
            cell.setupDataAlbum(album: data.albumArray0[indexPath.row])
            titleLabel.text = "Dành cho bạn"
        case 1:
            cell.setupDataAlbum(album: data.albumArray1[indexPath.row])
            titleLabel.text = "Để cảm xúc thăng hoa"
        case 2:
            cell.setupDataAlbum(album: data.albumArray2[indexPath.row])
            titleLabel.text = "Tập luyện"
        case 3:
            cell.setupDataAlbum(album: data.albumArray3[indexPath.row])
            titleLabel.text = "Lựa chọn của bạn"
        default:
            break
        }
        return cell
        
    }
    // hàm trả về kích thước của item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height: collectionView.frame.size.height)
        
        
    }
    
    // hàm trả về khoảng cách giữa hai hàng
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // hàm trả về khoảng cách giữa 2 item (tương tự 2 cột)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    // hàm chọn item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let albumVC = AlbumVC()
        
        switch albumView.tag {
        case 0:
            let item = data.albumArray0[indexPath.row]
            albumVC.navigationItem.title = item.nameAlbum
            AlbumVC.urlAblum = AppDelegate.ipConnect + item.nameAlbum
            homeVC?.navigationController?.pushViewController(albumVC, animated: true)
            print(item.nameAlbum!)
        case 1:
            let item = data.albumArray1[indexPath.row]
            albumVC.navigationItem.title = item.nameAlbum
            AlbumVC.urlAblum = AppDelegate.ipConnect + item.nameAlbum
            homeVC?.navigationController?.pushViewController(albumVC, animated: true)
            print(item.nameAlbum!)
            
        case 2:
            let item = data.albumArray2[indexPath.row]
            albumVC.navigationItem.title = item.nameAlbum
            AlbumVC.urlAblum = AppDelegate.ipConnect + item.nameAlbum
            homeVC?.navigationController?.pushViewController(albumVC, animated: true)
            print(item.nameAlbum!)
        case 3:
            let item = data.albumArray3[indexPath.row]
            albumVC.navigationItem.title = item.nameAlbum
            AlbumVC.urlAblum = AppDelegate.ipConnect + item.nameAlbum
            homeVC?.navigationController?.pushViewController(albumVC, animated: true)
            print(item.nameAlbum!)
            
        default:
            break
        }
        
    }
    
    
}
