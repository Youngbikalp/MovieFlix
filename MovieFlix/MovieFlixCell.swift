//
//  MovieFlixCell.swift
//  MovieFlix
//
//  Created by Bikalp  Timalsina on 2/5/20.
//  Copyright © 2020 Bikalp  Timalsina. All rights reserved.
//

import UIKit

class MovieFlixCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var movieDescriptionLable: UILabel!
    @IBOutlet weak var movieTitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
