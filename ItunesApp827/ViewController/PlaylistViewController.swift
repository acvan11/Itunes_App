//
//  PlaylistViewController.swift
//  ItunesApp827
//
//  Created by Sky on 9/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    
    private func setupPlaylist() {
        //you must register XIB to table view
//        playlistTableView.register(UINib(nibName: TrackTableCellTwo.identifier, bundle: Bundle.main), forCellReuseIdentifier: TrackTableCellTwo.identifier)
        
        playlistTableView.tableFooterView = UIView(frame: .zero) //remove unused cells
        viewModel.playlistDelegate = self
    }
}



extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreManager.shared.load().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableCell.identifier, for: indexPath) as! PlaylistTableCell
        let track = viewModel.playlist[indexPath.row]
        cell.track = track
    
        
//        cell.trackPreviewButton.tag = indexPath.row
//        cell.trackPreviewButton.addTarget(self, action: #selector(previewButtonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print(viewModel.playlist[indexPath.row].name!)
            viewModel.delete(track: viewModel.playlist[indexPath.row])
            viewModel.playlist.remove(at: indexPath.row)
        }
    }
}

extension PlaylistViewController: PlaylistDelegate {
    func update() {
        DispatchQueue.main.async {
            self.playlistTableView.reloadData()        }
    }
}
