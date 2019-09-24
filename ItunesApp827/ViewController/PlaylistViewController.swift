//
//  PlaylistViewController.swift
//  ItunesApp827
//
//  Created by Sky on 9/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var playlistTableView: UITableView!
    
    
    var viewModel : ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaylist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPlaylist()
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
                print(sender.tag)
                let track = viewModel.tracks[sender.tag]
                print(track.name)
                viewModel.delete(track: track)
    }
    

    private func setupPlaylist() {
        //you must register XIB to table view
//        playlistTableView.register(UINib(nibName: TrackTableCellTwo.identifier, bundle: Bundle.main), forCellReuseIdentifier: TrackTableCellTwo.identifier)
        
        playlistTableView.tableFooterView = UIView(frame: .zero) //remove unused cells
        viewModel.playlistDelegate = self
    }
}

extension PlaylistViewController: UITableViewDelegate {
    
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreManager.shared.load().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableCell.identifier, for: indexPath) as! PlaylistTableCell
        let track = viewModel.playlist[indexPath.row]
        cell.track = track
        cell.removeButton.tag = indexPath.row
        
//        cell.trackPreviewButton.tag = indexPath.row
//        cell.trackPreviewButton.addTarget(self, action: #selector(previewButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
}

extension PlaylistViewController: PlaylistDelegate {
    func update() {
        DispatchQueue.main.async {
            self.playlistTableView.reloadData()        }
    }
}
