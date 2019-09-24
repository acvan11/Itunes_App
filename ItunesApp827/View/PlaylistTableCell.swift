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
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var priceLable: UILabel!

    
    static let identifier = "PlaylistTableCell"
    
    var track: Track! {
        didSet {
            duration.text = track.duration!.toMinutes
            priceLable.text = "$" + String(track.price!)
            trackTitle.text = track.name
            
        }
    }

}
