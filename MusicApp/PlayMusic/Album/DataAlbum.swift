//
//  DataAlbum.swift
//  MusicApp
//
//  Created by Trung Le on 11/6/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import Foundation


class Songs {
    var id: Int!
    var song: String!
    var author: String!
    var file: String!
    var photo: String!
    
    init(_id: Int, _song: String, _author: String, _file: String, _photo: String) {
        self.id = _id
        self.song = _song
        self.author = _author
        self.file = _file
        self.photo = _photo
    }
}

//class DataAlbum {
//    static let isDataAlbum = DataAlbum()
//    
//}
