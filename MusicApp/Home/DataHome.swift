//
//  DataHome.swift
//  MusicApp
//
//  Created by Trung Le on 10/21/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import Foundation
import UIKit

class Album {
    var nameAlbum : String!
    var imageAlbum : UIImage!
    var titleAlbum: String!
    
    init(_nameAlbum : String, _titleAlbum: String, _imageAlbum : UIImage!) {
        self.nameAlbum = _nameAlbum
        self.imageAlbum = _imageAlbum
        self.titleAlbum = _titleAlbum
    }
}


class DataHome {
    static let isDataHome = DataHome()
    var albumArray0 = [Album]()
    var albumArray1 = [Album]()
    var albumArray2 = [Album]()
    var albumArray3 = [Album]()
    var tableArray = [Any]()
    func loadDataAlbum(_ row: Int){
        switch row {
        case 0:
            albumArray0.append(Album(_nameAlbum: "album1", _titleAlbum: "tên ca sĩ", _imageAlbum: UIImage(named: "ai-bao-can-anh")))
            albumArray0.append(Album(_nameAlbum: "album2", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Nen-Yeu-Co-Ay-N-Ly")))
            
            
        case 1:
            albumArray1.append(Album(_nameAlbum: "album3", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Hua-Sao-Chang-Duoc-Huynh-Ai-Vy")))
            albumArray1.append(Album(_nameAlbum: "album4", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Dang-O-Dau-Day-Anh-Huong-Giang")))
            albumArray1.append(Album(_nameAlbum: "album5", _titleAlbum: "tên ca sĩ", _imageAlbum: UIImage(named: "Ai-La-Nguoi-Thuong-Em-Quan-A-P")))
            
        case 2:
            albumArray2.append(Album(_nameAlbum: "album6", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Dang-O-Dau-Day-Anh-Huong-Giang")))
            albumArray2.append(Album(_nameAlbum: "album7", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Ta-Khong-Thich-Toi-RHY")))
            albumArray2.append(Album(_nameAlbum: "album9", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Dang-O-Dau-Day-Anh-Huong-Giang")))
            albumArray2.append(Album(_nameAlbum: "album10", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Danh-Roi-Nguoi-Yeu-Nay-That-Tuyet-Voi-Khi-O-Ben-Em-OST-Andiez-AMEE")))
            albumArray2.append(Album(_nameAlbum: "album11", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Dang-O-Dau-Day-Anh-Huong-Giang")))
            albumArray2.append(Album(_nameAlbum: "album12", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Nen-Yeu-Co-Ay-N-Ly")))
            
        case 3:
            albumArray3.append(Album(_nameAlbum: "album13", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Hua-Sao-Chang-Duoc-Huynh-Ai-Vy")))
            albumArray3.append(Album(_nameAlbum: "album14", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Se-Den-Nhan-Duyen-Nguoi-Yeu-Tien-Kiep-OST-Trinh-Thang-Binh")))
            albumArray3.append(Album(_nameAlbum: "album15", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Nen-Yeu-Co-Ay-N-Ly")))
            albumArray3.append(Album(_nameAlbum: "album16", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Ta-Khong-Thich-Toi-RHY")))
            albumArray3.append(Album(_nameAlbum: "album17", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Ai-La-Nguoi-Thuong-Em-Quan-A-P")))
            albumArray3.append(Album(_nameAlbum: "album18", _titleAlbum: "tên ca sĩ", _imageAlbum:  UIImage(named: "Anh-Danh-Roi-Nguoi-Yeu-Nay-That-Tuyet-Voi-Khi-O-Ben-Em-OST-Andiez-AMEE")))
       
        default:
            break
        }
    }
    
    func loadTableData(){
        tableArray.append(HomeCollectionCell.init())
        tableArray.append(HomeCollectionCell.init())
        tableArray.append(HomeCollectionCell.init())
        tableArray.append(HomeCollectionCell.init())
    }
    
}
