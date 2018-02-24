//
//  ViewController.swift
//  Music Player
//
//  Created by Rohit Navalgund on 24/02/18.
//  Copyright © 2018 Rohit Navalgund. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    Create an AVAudio Player for us to be able to play audio.
    var AudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
/*      execute a do-try-catch condition here.
        Try to play the Audio Player created earlier and initialise the path for the audio file to be
        Played
*/
        do {
            AudioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".m4a")!))
            AudioPlayer.prepareToPlay()
            
//            Create an Audio Session for the app to play music in background
            let AudioSessions = AVAudioSession.sharedInstance()

            do {
                try AudioSessions.setCategory(AVAudioSessionCategoryPlayback)
            } catch {
                print("ERROR playing in background")
            }

        } catch {
            print(error)
        }
        
//        Slider animation / Slider Movement things -->>> Checkout the function SliderUpdate() For more info
        slider.maximumValue = Float(AudioPlayer.duration)
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SliderUpdate), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    Play Button
    @IBAction func play(_ sender: Any) {
        AudioPlayer.play()
    }

    
//    Pause Button
    @IBAction func pause(_ sender: Any) {
        if AudioPlayer.isPlaying == true {
            AudioPlayer.pause()
        } else {
            AudioPlayer.play()
        }
    }
    
    
//    Restart Button
    @IBAction func restart(_ sender: Any) {
        AudioPlayer.currentTime = 0.0
        AudioPlayer.play()
    }
    
//    Slider stuff which makes the slider to change audio time
    @IBAction func SliderFunc(_ sender: Any) {
        AudioPlayer.stop()
        AudioPlayer.currentTime = TimeInterval(slider.value)
        AudioPlayer.prepareToPlay()
        AudioPlayer.play()
    }
    
//    More Slider stuffs -->>> This is used for Slider Animation / Slider sliding movement.
    @objc func SliderUpdate() {
        slider.value = Float(AudioPlayer.currentTime)
    }
}
