//
//  SongVC.swift
//  Keep Pace
//
//  Created by Fong Lor on 11/9/16.
//  Copyright © 2016 Capstone. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MediaPlayer

class SongVC: UIViewController, CLLocationManagerDelegate {
    
    // Labels for artist, song, status ?
    // Use UIToolbar ?
    // UIBarButtonItem for play and pause ?
    
    // Variable here for target speed (slow, medium, fast) that comes in from another ViewController
    //var chosenSpeed = Speed chose from another view controller
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    //var running = false
    //var pause = false
    //var jogging = false
    //var walking = false
    var speed: CLLocationSpeed = CLLocationSpeed()   // set to 0.0 ?
    var player: MPMusicPlayerController!
    var collection: MPMediaItemCollection!
    var filteredSongs: [MPMediaItem]!
    var startingIndex: Int!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var currentSpeed: UILabel!
    @IBOutlet weak var targetSpeed: UILabel!
    @IBOutlet weak var song: UILabel!
    @IBOutlet weak var playPause: UIButton!
    
    @IBAction func playPausePressed(_ sender: Any) {
        
        
        let playbackState = self.player.playbackState    //change to var
        
        if playbackState == .stopped || playbackState == .paused {
            self.player.play()
            playPause.setImage(UIImage(named: "pauseButton"), for: UIControlState.normal)
        }
        else if playbackState == .playing {
            self.player.pause()
            playPause.setImage(UIImage(named: "playButton"), for: UIControlState.normal)        }
        
        //self.toolbar.setItems(items, animated: false)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        if self.player.indexOfNowPlayingItem == 0 {
            self.player.skipToBeginning()
        }
        else {
            self.player.endSeeking()
            self.player.skipToPreviousItem()
        }
    }
    
    @IBAction func forwardPressed(_ sender: Any) {
        
        let nowPlayingIndex = self.player.indexOfNowPlayingItem    // change to var
        self.player.endSeeking()
        self.player.skipToNextItem()
        if self.player.nowPlayingItem == nil {
            if self.collection.count > nowPlayingIndex + 1 {
                // added more songs while playing
                self.player.setQueue(with: self.collection)
                let item = self.collection.items[nowPlayingIndex + 1]   // change to var
                self.player.nowPlayingItem = item
                self.player.play()
            }
            else {
                // no more songs
                self.player.stop()
                //var items = [Any](arrayLiteral: self.toolbar.items)
                //items[3] = self.play()   Change play/pause icon to 'play icon'
                //self.toolbar.items = items
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //targetSpeed.text = String(format: "%.0f mph", chosenSpeed)   // Giving error because no speed passed in yet
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        speed = locationManager.location!.speed
        
        // Speed is provided in meter per second, so need to multiply to get conversion
        currentSpeed.text = String(format: "%.0f mph", speed * 2.23693629)  //  Use 3.6 for km per hour
        
        self.player = MPMusicPlayerController.systemMusicPlayer()
        let notificationCenter = NotificationCenter.default   // change to var
        notificationCenter.addObserver(self, selector: #selector(self.nowPlayingItemChanged), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: self.player)
        self.player.beginGeneratingPlaybackNotifications()
        self.player.beginGeneratingPlaybackNotifications()
        let playbackState = self.player.playbackState     // change to var
        if playbackState == .playing {
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locationManager.location!.speed)
        speed = locationManager.location!.speed
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func nowPlayingItemChanged(_ notification: Notification) {
        let currentItem = self.player.nowPlayingItem
        
        if currentItem == nil {
            self.imageView!.image = nil
            self.imageView!.isHidden = true
            // self.artist.text = nil
            self.song.text = nil
            
        } else {
            let size = CGSize(width: 260, height: 260)
            
            if let artwork = currentItem?.artwork?.image(at: size) {
                self.imageView!.image = artwork
                self.imageView!.isHidden = false
            }
            
            // Display the artist and song name for the now-playing media item
            //var artistStr = currentItem?.value(forProperty: MPMediaItemPropertyArtist)
            //var albumStr = currentItem?.value(forProperty: MPMediaItemPropertyAlbumTitle)
            //self.artist.text = "\(artistStr) — \(albumStr)"
            //self.song.text = currentItem?.value(forProperty: MPMediaItemPropertyTitle) as! String?
            
        }
    }
    
}
