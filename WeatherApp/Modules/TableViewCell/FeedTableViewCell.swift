//
//  FeedTableViewCell.swift
//  WeatherApp
//
//  Created by Mounika Gouni on 02/06/23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    var feed: FeedList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
