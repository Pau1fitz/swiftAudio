//
//  FirstViewController.swift
//  mp3Player
//
//  Created by Paul Fitzgerald on 11/23/18.
//  Copyright © 2018 Paul Fitzgerald. All rights reserved.
//

import UIKit
import AVFoundation

var list: [String] = [];
var player: AVAudioPlayer?
var thisSong = 0

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        list = []
        getSongs()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playSong(index: indexPath.row)
        thisSong = indexPath.row
        performSegue(withIdentifier: "song", sender: self)
    }
    
    func getSongs() {
        let songsArray = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "Songs")! as [NSURL]
        do {
            for song in songsArray {
                let mySong = song.absoluteString
                if (mySong?.contains(".mp3"))! {
                    let findString = mySong?.components(separatedBy: "/")
                    var songName = findString![(findString?.count)! - 1]
                    songName = songName.replacingOccurrences(of: ".mp3", with: "")
                    songName = songName.replacingOccurrences(of: "%20", with: " ")
                    list.append(songName)
                }
            }
            
            myTableView.reloadData()
        }
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
