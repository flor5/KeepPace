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
        
        self.navigationController!.setToolbarHidden(false, animated: true)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "Back"

        self.songListTableView.register(UITableViewCell.self, forCellReuseIdentifier: K.ReuseID.cell)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSongs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = filteredSongs[indexPath.row]
        //let cell = songListTableView.dequeueReusableCell(withIdentifier: K.ReuseID.cell)! as UITableViewCell
        
        
        let cell = songListTableView.dequeueReusableCell(withIdentifier: K.ReuseID.cell, for: indexPath)
        
        cell.textLabel?.text = song.title
        
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
