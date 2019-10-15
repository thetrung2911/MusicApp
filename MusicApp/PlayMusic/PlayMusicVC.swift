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
    
    var onlinePlayer: AVPlayer?
    
    var isPlaying = false
    var isShuffle = false
    var isRepeat = false
    
    var imageView = UIImageView()
    var scrollView = UIScrollView()
    var topView = UIView()
    var playView = UIView()
    var lyricsView = UIView()
    var progressView = UIProgressView()
    var transparentView = UIView()
    var timerView = UIView()
    let height: CGFloat = 200
    
    let urlImage = URL(string: "http://0.0.0.0:8888/image/Ai-La-Nguoi-Thuong-Em-Quan-A-P.jpg")
    
    let ablumLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Mix 2"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let songLabel: UILabel = {
        let label = UILabel()
        label.text = "Ai Là Người Thương Em"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let singerLabel: UILabel = {
        let label = UILabel()
        label.text = "Quân A.P"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        //        label.font = UIFont(name: "Halvetica", size: 18)
        return label
    }()
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        //        button.setBackgroundImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(onPlayButton), for: .touchUpInside)
        return button
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "end"), for: .normal)
        //        button.addTarget(self, action: #selector(onPlayButton), for: .touchUpInside)
        return button
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "skip"), for: .normal)
        //        button.addTarget(self, action: #selector(onPlayButton), for: .touchUpInside)
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
        //        button.addTarget(self, action: #selector(onPlayButton), for: .touchUpInside)
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
        
        view.backgroundColor = AppDelegate.backColor
        initOnlinePlayer()
        
        view.sv(scrollView)
        scrollView.centerHorizontally().top(0).width(100%).bottom(0)
        //        scrollView.backgroundColor = .white
        
        scrollView.sv(topView, playView, lyricsView)
        
        
        topView.top(0).width(100%).centerHorizontally().height(400)
        //        topView.backgroundColor = .red
        
        playView.centerHorizontally().width(100%).height(200).Top == topView.Bottom
        //        playView.backgroundColor = .orange
        
        lyricsView.centerHorizontally().width(100%).height(300).Top == playView.Bottom
        lyricsView.Bottom == scrollView.Bottom
        lyricsView.backgroundColor = .red
        
        //        playButton.top(500).width(40).height(40).centerHorizontally()
        
        autoLayoutTopView()
        autoLayoutPlayView()
        autoLayoutLyricsView()
        autoLayoutTimer()
    }
    
    func autoLayoutTopView(){
        let buttonView = UIView()
        
        topView.sv(imageView, buttonView)
        
        buttonView.centerHorizontally().top(16).height(32).width(100%)
        //        buttonView.backgroundColor = .black
        
        buttonView.sv(ablumLabel, dotsButton, clockButton)
        
        ablumLabel.centerHorizontally().centerVertically().width(50%)
        //        ablumLabel.backgroundColor = .gray
        
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
        timeView.sv(progressView)
        
        progressView.top(4).centerHorizontally().width(100%).height(4)
        progressView.progressTintColor = .green
        progressView.backgroundColor = .white
        progressView.layer.cornerRadius = 2
        progressView.clipsToBounds = true
        
        buttonView.centerHorizontally().width(90%).height(64).Top == timeView.Bottom + 4
        //        buttonView.backgroundColor = .black
        
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
        
        timerView.backgroundColor = AppDelegate.backColor
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
    @objc func onPlayButton(){
        playButton.isSelected = !playButton.isSelected
        if !isPlaying {
            onlinePlayer?.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            isPlaying = true
        } else {
            onlinePlayer?.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
            isPlaying = false
        }
    }
    
    func initOnlinePlayer() {
        let url = URL(string: "http://0.0.0.0:8888/audio/Ai-La-Nguoi-Thuong-Em-Quan-A-P.mp3")
        onlinePlayer = AVPlayer(url: url!)
        guard let duration = onlinePlayer?.currentItem?.asset.duration else {
            return
        }
        let durationBySecond = CMTimeGetSeconds(duration)
        //        let min = Int(durationBySecond) / 60
        //        let second = Int(durationBySecond) % 60
        //        self.lbEnd.text = "\(min):\(second)"
        //        self.sliderMusic.maximumValue = Float(durationBySecond)
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
    
    // click ngoài thì ẩn lại view
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
