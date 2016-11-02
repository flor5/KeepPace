//
//  ViewController.swift
//  Keep Pace
//
//  Created by Fong Lor, Carey Kuehl on 10/28/16.
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
    
    @IBAction func slowerSong(sender: AnyObject) {
        changeCurrentPlaybackRate(to: slowerSpeed)
    }
    
    @IBAction func slowSong(sender: AnyObject) {
        changeCurrentPlaybackRate(to: slowSpeed)
    }
    
    @IBAction func normalSong(sender: AnyObject) {
        changeCurrentPlaybackRate(to: normalSpeed)
        
        player.currentPlaybackRate = normalSpeed
    }
    
    @IBAction func fastSong(sender: AnyObject) {
        changeCurrentPlaybackRate(to: fastSpeed)
    }
    
    @IBAction func fasterSong(sender: AnyObject) {
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(stopMusic), name: UIApplicationWillResignActiveNotification, object: nil)
        
        let songs = MPMediaQuery.songsQuery().items
        
        if !songs!.isEmpty {
            print("\(songs![0].beatsPerMinute)")
            //let query = MPMediaQuery.songsQuery()
            let collection = MPMediaItemCollection(items: songs!)
            player = MPMusicPlayerController.systemMusicPlayer()
            player.setQueueWithItemCollection(collection)
            
            player.play()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let speed = manager.location!.speed
        
        index += 1
        speedLabel.text =  speed > 0 ? "i: \(index) Speed: \(manager.location!.speed)" : "i: \(index) Speed: 0"
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: \(error.localizedDescription)")
    }
    
    
    
    func stopMusic(){
        player.stop()
        print("player stopped")
    }
    
}
