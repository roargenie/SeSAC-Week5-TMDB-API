//
//  CastTableViewCell.swift
//  SeSAC Week5 TMDB API
//
//  Created by 이명진 on 2022/08/07.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    static let identifier = "CastTableViewCell"
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
