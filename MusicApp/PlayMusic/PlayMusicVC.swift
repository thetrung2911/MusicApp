//
//  PlayMusicVC.swift
//  MusicApp
//
//  Created by Trung Le on 10/8/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import Stevia
import AVFoundation
import Kingfisher

class PlayMusicVC: UIViewController {
    
    static var onlinePlayer: AVPlayer?
    var timePlay: Timer?
    
    var isPlaying = true
    var isShuffle = false
    var isRepeat = false
    
    var imageView = UIImageView()
    var scrollView = UIScrollView()
    var topView = UIView()
    var playView = UIView()
    var lyricsView = UIView()
    var sliderMusic = UISlider()
    var transparentView = UIView()
    var timerView = UIView()
    let height: CGFloat = 200
    
    static var songURL = ""
    static var imageURL = ""
    static var orderArray = Int()
    let ablumLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let songLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let singerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause"), for: .normal)
        //        button.setBackgroundImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(onPlayButton), for: .touchUpInside)
        return button
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "end"), for: .normal)
        button.addTarget(self, action: #selector(onNextButton), for: .touchUpInside)
        return button
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip"), for: .normal)
        button.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
        return button
    }()
    let clockButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clock"), for: .normal)
        button.addTarget(self, action: #selector(onClockButton(_:)), for: .touchUpInside)
        return button
    }()
    let dotsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dots"), for: .normal)
        button.addTarget(self, action: #selector(onDots), for: .touchUpInside)
        return button
    }()
    let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "repeat"), for: .normal)
        button.addTarget(self, action: #selector(onRepeatButton), for: .touchUpInside)
        return button
    }()
    let shuffleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shuffle"), for: .normal)
        button.addTarget(self, action: #selector(onShuffleButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppDelegate.backgroundColor
        
        view.sv(scrollView)
        scrollView.centerHorizontally().top(0).width(100%).bottom(0)
        
        scrollView.sv(topView, playView, lyricsView)
        
        topView.top(0).width(100%).centerHorizontally().height(400)
        
        playView.centerHorizontally().width(100%).height(200).Top == topView.Bottom
        
        lyricsView.centerHorizontally().width(100%).height(300).Top == playView.Bottom
        lyricsView.Bottom == scrollView.Bottom
        lyricsView.backgroundColor = .red
        
        autoLayoutTopView()
        autoLayoutPlayView()
        autoLayoutLyricsView()
        autoLayoutTimer()
        
        initOnlinePlayer()
        timePlay?.invalidate()
        timePlay = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        PlayMusicVC.onlinePlayer?.play()
    }
    
    func autoLayoutTopView(){
        let buttonView = UIView()
        let urlImage = URL(string: PlayMusicVC.imageURL)
        topView.sv(imageView, buttonView)
        
        buttonView.centerHorizontally().top(16).height(32).width(100%)
        
        buttonView.sv(ablumLabel, dotsButton, clockButton)
        
        ablumLabel.centerHorizontally().centerVertically().width(50%)
        
        dotsButton.centerVertically().right(8).size(24)
        
        clockButton.centerVertically().size(24).Right == dotsButton.Left - 8
        
        imageView.centerHorizontally().top(70).size(300)
        imageView.kf.setImage(with: urlImage)
        imageView.kf.indicatorType = .activity
        imageView.layer.cornerRadius = 150
        imageView.clipsToBounds = true
    }
    
    func autoLayoutPlayView(){
        
        let timeView = UIView()
        let buttonView = UIView()
        playView.sv(songLabel, singerLabel, timeView, buttonView)
        
        songLabel.centerHorizontally().top(0).width(90%).height(29)
        
        singerLabel.centerHorizontally().width(50%).Top == songLabel.Bottom + 4
        
        timeView.centerHorizontally().width(90%).height(30).Top == singerLabel.Bottom + 4
        timeView.sv(sliderMusic)
        
        sliderMusic.top(4).centerHorizontally().width(100%).height(4)
        sliderMusic.backgroundColor = .white
        sliderMusic.layer.cornerRadius = 2
        sliderMusic.clipsToBounds = true
        
        buttonView.centerHorizontally().width(90%).height(64).Top == timeView.Bottom + 4
        
        buttonView.sv(playButton, nextButton, backButton,repeatButton , shuffleButton)
        
        let delta = (Int(view.frame.width * 0.9) - 64 - 32 * 4) / 4
        
        playButton.centerHorizontally().centerVertically().size(64)
        
        nextButton.centerVertically().size(32).Left == playButton.Right + CGFloat(delta)
        
        backButton.centerVertically().size(32).Right == playButton.Left - CGFloat(delta)
        
        repeatButton.centerVertically().size(32).Left == nextButton.Right + CGFloat(delta)
        
        shuffleButton.centerVertically().size(32).Right == backButton.Left - CGFloat(delta)
        
        
    }
    func autoLayoutLyricsView(){
        
    }
    
    // layout view hẹn giờ tắt  
    func autoLayoutTimer(){
        let topView = UIView()
        let betweenView = UIView()
        let closeButton = UIButton()
        let title = UILabel()
        let timeLabel = UILabel()
        let timeSW = UISwitch()
        
        timerView.backgroundColor = AppDelegate.backgroundColor
        timerView.sv(topView,betweenView,closeButton)
        
        topView.centerHorizontally().width(90%).height(50).top(0)
        topView.sv(title, timeLabel, timeSW)
        
        title.centerVertically().left(0)
        title.text = "HẸN GIỜ TẮT"
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        timeSW.centerVertically().right(0).height(31).width(51)
        //        timeSW.isOn = true
        
        betweenView.centerHorizontally().width(90%).height(110).top(50)
        
        closeButton.centerHorizontally().width(100%).height(40).bottom(0)
        closeButton.setTitle("ĐÓNG", for: .normal)
        
        
    }
    
    // sự kiện next bài
    @objc func onNextButton(){
        if PlayMusicVC.orderArray == AlbumVC.songArray.count - 1 {
            PlayMusicVC.orderArray = 0
        }else{
            PlayMusicVC.orderArray += 1
        }
        PlayMusicVC.songURL = AppDelegate.ipConnect + "audio/" + AlbumVC.songArray[PlayMusicVC.orderArray].file
        PlayMusicVC.imageURL = AppDelegate.ipConnect + "image/" + AlbumVC.songArray[PlayMusicVC.orderArray].photo
        songLabel.text = AlbumVC.songArray[PlayMusicVC.orderArray].song
        singerLabel.text = AlbumVC.songArray[PlayMusicVC.orderArray].author
        imageView.kf.setImage(with: URL(string: PlayMusicVC.imageURL))
        initOnlinePlayer()
        timePlay?.invalidate()
        timePlay = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        PlayMusicVC.onlinePlayer?.play()
    }
    
    // sự kiện backButton
    @objc func onBackButton(){
        if PlayMusicVC.orderArray == 0 {
            PlayMusicVC.orderArray = AlbumVC.songArray.count - 1
        }else{
            PlayMusicVC.orderArray -= 1
        }
        PlayMusicVC.songURL = AppDelegate.ipConnect + "audio/" + AlbumVC.songArray[PlayMusicVC.orderArray].file
        PlayMusicVC.imageURL = AppDelegate.ipConnect + "image/" + AlbumVC.songArray[PlayMusicVC.orderArray].photo
        songLabel.text = AlbumVC.songArray[PlayMusicVC.orderArray].song
        singerLabel.text = AlbumVC.songArray[PlayMusicVC.orderArray].author
        imageView.kf.setImage(with: URL(string: PlayMusicVC.imageURL))
        initOnlinePlayer()
        timePlay?.invalidate()
        timePlay = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        PlayMusicVC.onlinePlayer?.play()
    }
    
    // sự kiện phát lại nhạc
    @objc func onRepeatButton(){
        repeatButton.isSelected = !repeatButton.isSelected
        if !isRepeat {
            repeatButton.setImage(UIImage(named: "repeats"), for: .normal)
            isRepeat = true
        } else {
            repeatButton.setImage(UIImage(named: "repeat"), for: .normal)
            isRepeat = false
        }
    }
    // sự kiện xáo trộn nhạc khi phát
    @objc func onShuffleButton(){
        shuffleButton.isSelected = !shuffleButton.isSelected
        if !isShuffle {
            shuffleButton.setImage(UIImage(named: "shuffles"), for: .normal)
            isShuffle = true
        } else {
            shuffleButton.setImage(UIImage(named: "shuffle"), for: .normal)
            isShuffle = false
        }
    }
    
    // sự kiện play/pause phát nhạc
    @objc func onPlayButton(){
        playButton.isSelected = !playButton.isSelected
        if !isPlaying {
            PlayMusicVC.onlinePlayer?.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            timePlay = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            //            rotate2(imageView: imageView, aCircleTime: 20)
            isPlaying = true
        } else {
            PlayMusicVC.onlinePlayer?.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
            timePlay?.invalidate()
            //            rotate2(imageView: imageView, aCircleTime: 20)
            isPlaying = false
        }
    }
    
    // sự kiện tap lựa chọn của trang phát nhạc
    @objc func onDots(){
        let optionPlay = OpPlayMusicVC()
        optionPlay.lblSong.text = songLabel.text
        optionPlay.lblAuthor.text = singerLabel.text
        self.present(optionPlay, animated: true, completion: nil)
    }
    
    // phát nhạc online (mới chỉ phát nhạc)
    func initOnlinePlayer() {
        let url = URL(string: PlayMusicVC.songURL)
        PlayMusicVC.onlinePlayer = AVPlayer(url: url!)
        if PlayMusicVC.onlinePlayer != nil{
            guard let duration = PlayMusicVC.onlinePlayer?.currentItem!.asset.duration else {
                return
            }
            print(duration)
            let durationBySecond = CMTimeGetSeconds((PlayMusicVC.onlinePlayer?.currentTime())!)
            
            //            print(durationBySecond)
            //            let min = Int(durationBySecond) / 60
            //            let second = Int(durationBySecond) % 60
            //        self.lbEnd.text = "\(min):\(second)"
            //            print("\(min):\(second)")
            
            //            self.sliderMusic.maximumValue = Float(durationBySecond)
        }
        
    }
    // slider chạy theo thời gian của nhạc (chưa xong)
    @objc func updateSlider() {
        if PlayMusicVC.onlinePlayer != nil {
            
            let currentTimeBySecond = CMTimeGetSeconds((PlayMusicVC.onlinePlayer!.currentTime()))
            sliderMusic.value = Float(currentTimeBySecond)
        }
    }
    
    // sự kiện xoay ảnh khi phát nhạc (chưa xong)
    func rotate2(imageView: UIImageView, aCircleTime: Double) { //UIView
        
        if !isPlaying{
            UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            }, completion: { finished in
                UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
                    imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
                }, completion: { finished in
                    self.rotate2(imageView: imageView, aCircleTime: aCircleTime)
                })
            })
        }else{
            
        }
    }
    
    // click vào đồng hồ thì hiện bảng hẹn giờ tắt nhạc
    @IBAction func onClockButton(_ sender: Any) {
        
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        let screenSize = UIScreen.main.bounds.size
        timerView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
        window?.addSubview(timerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.8
            self.timerView.frame = CGRect(x: 0, y: screenSize.height - self.height, width: screenSize.width, height: self.height)
        }, completion: nil)
        
    }
    
    // click ngoài thì ẩn view hẹn giờ tắt nhạc
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.timerView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.height)
        }, completion: nil)
    }
    
}
extension UIImageView {
    func setupIndicatorType() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
}
