//
//  AblumVC.swift
//  MusicApp
//
//  Created by Trung Le on 10/14/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import SwiftyJSON
import Alamofire

class AlbumVC: UIViewController {
    
    static var urlAblum =  ""
    let table = UITableView()
    static var json: JSON?
    static var songArray = [Songs]()
    
    // load dữ liệu các bài hát trong album từ API về
    func loadDataAlbum(){
        AlbumVC.songArray.removeAll()
        Alamofire.request(AlbumVC.urlAblum).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                AlbumVC.json = JSON(value)
                for i in 0 ..< AlbumVC.json!.count{
                    // tạo thành 1 mảng chứa danh sách bài hát đó
                    AlbumVC.songArray.append(Songs(_id: AlbumVC.json![i]["id"].intValue, _song: AlbumVC.json![i]["song"].stringValue, _author: AlbumVC.json![i]["author"].stringValue, _file: AlbumVC.json![i]["file"].stringValue, _photo: AlbumVC.json![i]["photo"].stringValue))
                }
                //sau khi toạ xong thì reload lại table để hiển thị
                self.table.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppDelegate.backgroundColor
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.sv(table)
        
        loadDataAlbum()
        table.backgroundColor = .clear
        table.centerHorizontally().width(100%).Top == view.safeAreaLayoutGuide.Top
        table.Bottom == view.safeAreaLayoutGuide.Bottom
        table.dataSource = self
        table.delegate = self
        table.register(AlbumTableCell.self, forCellReuseIdentifier: "songs")
        
        
    }
}
extension AlbumVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (AlbumVC.json == nil) {
            print("but json is nil")
            return 0
        } else {
            return AlbumVC.songArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = table.dequeueReusableCell(withIdentifier: "songs", for: indexPath) as? AlbumTableCell else {
            fatalError("fail")
        }
        cell.backgroundColor = .clear
        cell.setupDataSong(songs: AlbumVC.songArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let playMusic = PlayMusicVC()
        PlayMusicVC.orderArray = indexPath.row
        PlayMusicVC.songURL = AppDelegate.ipConnect + "audio/" + AlbumVC.songArray[PlayMusicVC.orderArray].file
        PlayMusicVC.imageURL = AppDelegate.ipConnect + "image/" + AlbumVC.songArray[PlayMusicVC.orderArray].photo
        playMusic.ablumLabel.text = self.navigationItem.title
        playMusic.songLabel.text = AlbumVC.songArray[indexPath.row].song
        playMusic.singerLabel.text = AlbumVC.songArray[indexPath.row].author
        present(playMusic, animated: true, completion: nil)
    }
    
}
