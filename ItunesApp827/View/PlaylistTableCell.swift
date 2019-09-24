//
//  PlaylistTableCell.swift
//  ItunesApp827
//
//  Created by Sky on 9/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PlaylistTableCell: UITableViewCell {


    @IBOutlet weak var trackTitle: UILabel!

    @IBOutlet weak var removeButton: UIButton!
    
    static let identifier = "PlaylistTableCell"
    
    var track: Track! {
        didSet {
            trackTitle.text = track.name
        }
    }
}
