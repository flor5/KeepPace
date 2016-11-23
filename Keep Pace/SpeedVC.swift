//
//  SpeedVC.swift
//  Keep Pace
//
//  Created by Fong Lor, Carey Kuehl on 10/28/16.
//  Copyright © 2016 Capstone. All rights reserved.

import UIKit
import MediaPlayer
import CoreLocation

class SpeedVC: UIViewController {

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    
    var filteredSongs: [MPMediaItem]!
    var speed: String!
    var status: MPMediaLibraryAuthorizationStatus!
    var locationManager: CLLocationManager = CLLocationManager()
    var range: ClosedRange<Int>!
    
    @IBAction func switchToSongList(_ sender: UIButton) {
        switch sender {
        case slowButton:
            speed = K.Speed.slow
            range = K.BeatsPerMinuteRange.slowRange
        case mediumButton:
            speed = K.Speed.medium
            range = K.BeatsPerMinuteRange.mediumRange
        case fastButton:
            speed = K.Speed.fast
            range = K.BeatsPerMinuteRange.fastRange
        default:
            break
        }
        
        if status == .authorized {
            let songs = MPMediaQuery.songs().items
            
            if !songs!.isEmpty {
                self.filteredSongs = self.filterSongs(from: songs!)
            }
        }
        
        super.performSegue(withIdentifier: K.SegueID.showSongList, sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        MPMediaLibrary.requestAuthorization{(status) in
            self.status = status
        }
        
        self.navigationController!.setToolbarHidden(true, animated: true)
        
        setButtonInsets(button: slowButton)
        setButtonInsets(button: mediumButton)
        setButtonInsets(button: fastButton)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.toolbar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let songListVC = segue.destination as? SongListVC {
            songListVC.filteredSongs = filteredSongs
            songListVC.navigationTitle = speed
        }
    }
    
    func setButtonInsets(button: UIButton){
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func filterSongs(from songs : [MPMediaItem]) -> [MPMediaItem]! {
        var filteredSongs: [MPMediaItem] = []
        
        for song in songs {
            let beatsPerMinute = song.beatsPerMinute
            
            if range.contains(beatsPerMinute) {
                filteredSongs.append(song)
            }
        }

        return filteredSongs
    }
    
}
