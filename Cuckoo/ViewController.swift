//
//  ViewController.swift
//  Cuckoo
//
//  Created by zhl on 2020/4/14.
//  Copyright © 2020 wingsrao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        img1.image = UIImage.init(named: "11")
        img2.image = UIImage.init(named: "11")
        img3.image = UIImage.init(named: "11")
        img4.image = UIImage.init(named: "11")
        //循环播放音乐
        player?.play()
        //每几秒切换随机的背景图
        beginTimer()
    }

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    var timer:Timer!
    var timeCount:Int = 0
    func beginTimer() -> () {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }
    
    @objc func tickDown(){
        timeCount+=1
        print(timeCount)
        changePic()
    }
    
    func changePic() -> () {
        let imgCount = arc4random_uniform(4)+1 //1-4
        if imgCount == 1 {
            
        }
        
        switch imgCount {
        case 1:
            let ranCount1 = arc4random_uniform(2)+1 //1-2
            let ranPic1 = arc4random_uniform(2)+1 //1-3
            img1.image = UIImage.init(named: "\(ranPic1)\(ranCount1)")
            break;
        case 2:
            let ranCount2 = arc4random_uniform(2)+1 //1-2
            let ranPic2 = arc4random_uniform(2)+1 //1-3
            img2.image = UIImage.init(named: "\(ranPic2)\(ranCount2)")
            break;
        case 3:
            let ranCount3 = arc4random_uniform(2)+1 //1-2
            let ranPic3 = arc4random_uniform(2)+1 //1-3
            img3.image = UIImage.init(named: "\(ranPic3)\(ranCount3)")
            break;
        case 4:
            let ranCount4 = arc4random_uniform(2)+1 //1-2
            let ranPic4 = arc4random_uniform(2)+1 //1-3
            img4.image = UIImage.init(named: "\(ranPic4)\(ranCount4)")
            break;
            
        default:
            let ranCount1 = arc4random_uniform(2)+1 //1-2
            let ranPic1 = arc4random_uniform(2)+1 //1-3
            img1.image = UIImage.init(named: "\(ranPic1)\(ranCount1)")
        }
        
    }
    
    lazy var player:AVAudioPlayer? = {
        let url = Bundle.main.url(forResource: "布谷鸟", withExtension: "mp3")
        do {
            let player = try AVAudioPlayer(contentsOf: url!)
            player.delegate = self
            
            player.enableRate = true//播放速率
            player.prepareToPlay()//准备播放
            
            return player
        } catch {
            print(error)
            return nil
        }
    }()
    
    func playBack() -> () {
        //获取音频会话
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        do {
            //设置会话类型
            if #available(iOS 10.0, *){
                try audioSession.setCategory(.playback, mode: .default, options:.defaultToSpeaker)
            }else{
                // Fallback on earlier versions
            }
            
            //激活会话
            try audioSession.setActive(true, options: [])
        } catch  {
            print(error)
        }
    }
    
    
    
    
    
    
    
}

extension ViewController:AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("播放完成")
        player.play()
    }
}

