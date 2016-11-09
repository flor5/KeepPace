//
//  ViewController.swift
//  Keep Pace
//
//  Created by Fong Lor, Carey Kuehl on 10/28/16.
//  Copyright © 2016 Capstone. All rights reserved.
// Changed TEST22222

import UIKit
import MediaPlayer
import NotificationCenter
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var player: MPMusicPlayerController!
    
    let slowerSpeed: Float = 0.7
    let slowSpeed: Float = 0.8
    let normalSpeed: Float = 1.0
    let fastSpeed:Float = 1.15
    let fasterSpeed:Float = 1.4
    
    var index = 0
    
    let manager = CLLocationManager()
    
    func changeCurrentPlaybackRate(to speed: Float) {
//        while player.currentPlaybackRate > speed {
//            player.currentPlaybackRate -= 0.01
//            print(player.currentPlaybackRate)
//        }
//        
//        while player.currentPlaybackRate < speed {
//            player.currentPlaybackRate += 0.01
//            print(player.currentPlaybackRate)
//        }
        
        player.currentPlaybackRate = speed
        print(player.currentPlaybackRate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Keep Pace"
 
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                
                let songs = MPMediaQuery.songs().items
                print("you have \(songs!.count) songs")
                
                if !songs!.isEmpty {
                    print("bpm: \(songs![0].beatsPerMinute)")
                    //let query = MPMediaQuery.songsQuery()
                    let collection = MPMediaItemCollection(items: songs!)
                    self.player = MPMusicPlayerController.systemMusicPlayer()
                    self.player.setQueue(with: collection)
                    
                    self.player.play()
                    print("play music")
                }
                
                self.manager.desiredAccuracy = kCLLocationAccuracyBest
                self.manager.requestAlwaysAuthorization()
                self.manager.delegate = self
                self.manager.startUpdatingLocation()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let speed = manager.location!.speed
        
        index += 1
        //speedLabel.text =  speed > 0 ? "i: \(index) Speed: \(manager.location!.speed)" : "i: \(index) Speed: 0"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

    private func stopMusic() {
        if player != nil {
            //player.stop()
            print("player stopped")
        }
    }
    
}
