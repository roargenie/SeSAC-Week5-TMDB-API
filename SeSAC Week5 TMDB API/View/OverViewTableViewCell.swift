//
//  OverViewTableViewCell.swift
//  SeSAC Week5 TMDB API
//
//  Created by 이명진 on 2022/08/07.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {
    
    static let identifier = "OverViewTableViewCell"
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var moreViewButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }

}
