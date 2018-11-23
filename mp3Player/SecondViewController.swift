//
//  SecondViewController.swift
//  mp3Player
//
//  Created by Paul Fitzgerald on 11/23/18.
//  Copyright © 2018 Paul Fitzgerald. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    @IBAction func play(_ sender: Any) {
        if player?.isPlaying == false {
            player?.play()
        }
    }
  
    @IBAction func stop(_ sender: Any) {
        if player?.isPlaying == true {
            player?.pause()
        }
    }
    
    @IBAction func prevSong(_ sender: Any) {
        if(thisSong == 0) {
            thisSong = list.count - 1
        } else {
            thisSong -= 1
        }
        playSong(index: thisSong)
        label.text = list[thisSong]
    }
    
    @IBAction func nextSong(_ sender: Any) {
        if(thisSong < list.count  - 1) {
           thisSong += 1
        } else {
            thisSong = 0
        }
        playSong(index: thisSong)
        label.text = list[thisSong]
    }
    
    @IBAction func volume(_ sender: UISlider) {
        player?.volume = sender.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = list[thisSong]
    }

    func playSong(index: Int) {
        guard let url = Bundle.main.url(forResource: list[index], withExtension: "mp3", subdirectory: "Songs") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }


}

