//
//  SpeedVC.swift
//  Keep Pace
//
//  Created by Fong Lor, Carey Kuehl on 10/28/16.
//  Copyright © 2016 Capstone. All rights reserved.
// Changed TEST22222

import UIKit
//import MediaPlayer
//import NotificationCenter
//import CoreLocation

class SpeedVC: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    
    
    
    //, CLLocationManagerDelegate {
    
//    var player: MPMusicPlayerController!
//    
//    let slowerSpeed: Float = 0.7
//    let slowSpeed: Float = 0.8
//    let normalSpeed: Float = 1.0
//    let fastSpeed:Float = 1.15
//    let fasterSpeed:Float = 1.4
//    
//    var index = 0
//    
//    let manager = CLLocationManager()
    
//    func changeCurrentPlaybackRate(to speed: Float) {
//        while player.currentPlaybackRate > speed {
//            player.currentPlaybackRate -= 0.01
//            print(player.currentPlaybackRate)
//        }
//        
//        while player.currentPlaybackRate < speed {
//            player.currentPlaybackRate += 0.01
//            print(player.currentPlaybackRate)
//        }
//        
//        player.currentPlaybackRate = speed
//        print(player.currentPlaybackRate)
//    }
    
    func setButtonInsets(button: UIButton){
        let spacing : CGFloat = 20
        
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Keep Pace"
        
        // http://stackoverflow.com/questions/33033737/display-image-and-text-in-button
        setButtonInsets(button: slowButton)
        setButtonInsets(button: mediumButton)
        setButtonInsets(button: fastButton)
        
        
//        MPMediaLibrary.requestAuthorization { (status) in
//            if status == .authorized {
//                
//                let songs = MPMediaQuery.songs().items
//                print("you have \(songs!.count) songs")
//                
//                if !songs!.isEmpty {
//                    print("bpm: \(songs![0].beatsPerMinute)")
//                    //let query = MPMediaQuery.songsQuery()
//                    let collection = MPMediaItemCollection(items: songs!)
//                    self.player = MPMusicPlayerController.systemMusicPlayer()
//                    self.player.setQueue(with: collection)
//                    
//                    self.player.play()
//                    print("play music")
//                }
//                
//                self.manager.desiredAccuracy = kCLLocationAccuracyBest
//                self.manager.requestAlwaysAuthorization()
//                self.manager.delegate = self
//                self.manager.startUpdatingLocation()
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let speed = manager.location!.speed
//        
//        index += 1
//        //speedLabel.text =  speed > 0 ? "i: \(index) Speed: \(manager.location!.speed)" : "i: \(index) Speed: 0"
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//
//    private func stopMusic() {
//        if player != nil {
//            //player.stop()
//            print("player stopped")
//        }
//    }
    
}
