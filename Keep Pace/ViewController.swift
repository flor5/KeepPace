//
//  ViewController.swift
//  Keep Pace
//
//  Created by Fong Lor on 10/28/16.
//  Copyright © 2016 Capstone. All rights reserved.
//

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
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBAction func slowerSong(_ sender: AnyObject) {
        changeCurrentPlaybackRate(to: slowerSpeed)
    }
    
    @IBAction func slowSong(_ sender: AnyObject) {
        changeCurrentPlaybackRate(to: slowSpeed)
    }
    
    @IBAction func normalSong(_ sender: AnyObject) {
        changeCurrentPlaybackRate(to: normalSpeed)
        
        player.currentPlaybackRate = normalSpeed
    }
    
    @IBAction func fastSong(_ sender: AnyObject) {
        changeCurrentPlaybackRate(to: fastSpeed)
    }
    
    @IBAction func fasterSong(_ sender: AnyObject) {
        changeCurrentPlaybackRate(to: fasterSpeed)
    }
    
    func changeCurrentPlaybackRate(to speed: Float) {
        while player.currentPlaybackRate > speed {
            player.currentPlaybackRate -= 0.01
            print(player.currentPlaybackRate)
        }
        
        while player.currentPlaybackRate < speed {
            player.currentPlaybackRate += 0.01
            print(player.currentPlaybackRate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
        
        // Detect when the app enters the background
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        let songs = MPMediaQuery.songs().items
        print("you have \(songs?.count) songs")
        
        if !songs!.isEmpty {
            print("\(songs![0].beatsPerMinute)")
            //let query = MPMediaQuery.songsQuery()
            let collection = MPMediaItemCollection(items: songs!)
            player = MPMusicPlayerController.systemMusicPlayer()
            player.setQueue(with: collection)
            
            player.play()
            print("play music")
        }
 /*
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.runMediaLibraryQuery()
            } else {
                //displayMediaLibraryError()
            }
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let speed = manager.location!.speed
        
        index += 1
        speedLabel.text =  speed > 0 ? "i: \(index) Speed: \(manager.location!.speed)" : "i: \(index) Speed: 0"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func runMediaLibraryQuery() {
        let songs = MPMediaQuery.songs().items
        print("you have \(songs?.count) songs")
        
        if !songs!.isEmpty {
            print("\(songs![0].beatsPerMinute)")
            //let query = MPMediaQuery.songsQuery()
            let collection = MPMediaItemCollection(items: songs!)
            player = MPMusicPlayerController.systemMusicPlayer()
            player.setQueue(with: collection)
            
            player.play()
            print("play music")
        }
    }

    
    func stopMusic(){
        //player.stop()
        print("player stopped")
    }
    
}
