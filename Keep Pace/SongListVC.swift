//
//  SongListVC.swift
//  Keep Pace
//
//  Created by Fong Lor on 11/9/16.
//  Copyright © 2016 Capstone. All rights reserved.
//

import UIKit
import MediaPlayer

class SongListVC: UITableViewController {
    
    var filteredSongs: [MPMediaItem]!
    var navigationTitle: String!

    @IBOutlet weak var songListTableView: UITableView!
    @IBOutlet weak var songListVCTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songListVCTitle.title = navigationTitle
        
        self.navigationController!.navigationBar.backItem?.backBarButtonItem?.title = "Back"
        
        self.tableView!.backgroundColor = UIColor.black
        self.tableView!.tableFooterView = UIView()

        self.songListTableView.register(UITableViewCell.self, forCellReuseIdentifier: K.ReuseID.cell)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = filteredSongs[indexPath.row]
        
        let cell = songListTableView.dequeueReusableCell(withIdentifier: K.ReuseID.cell, for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel!.text = song.title

        if let albumArt = song.artwork {
            let size = 100
           cell.imageView?.image = albumArt.image(at: CGSize(width: size, height: size))
        } else {
            cell.imageView?.image = UIImage(named: "music_2x.png")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.SegueID.showSong, sender: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SongVC {
            if let indexPath = songListTableView.indexPathForSelectedRow {
                destination.filteredSongs = filteredSongs
                destination.startingIndex = indexPath.row
            }
        }
    }
    
}
