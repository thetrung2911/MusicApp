//
//  HomeVC.swift
//  MusicApp
//
//  Created by Trung Le on 9/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia

class HomeVC: UIViewController {
    
    let table = UITableView()
    let data = DataHome.isDataHome
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        view.backgroundColor = AppDelegate.backgroundColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        view.sv(table)
        data.loadTableData()
        table.left(0).right(0).Top == view.safeAreaLayoutGuide.Top
        table.Bottom == view.safeAreaLayoutGuide.Bottom
        table.backgroundColor = .clear
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        table.bounces = false
        table.register(HomeTableCell.self, forCellReuseIdentifier: "album")
        
    }
    
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = table.dequeueReusableCell(withIdentifier: "album", for: indexPath) as? HomeTableCell else {
            fatalError("fail")
        }
        
        cell.albumView.tag = indexPath.row
        data.loadDataAlbum(cell.albumView.tag)
        cell.homeVC = self
        return cell
        
    }
    @objc func onClickedMapButton(button: UIButton) {
        button.setImage(UIImage(named: "hearts"), for: .normal)
    }
    

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
