//
//  CastTableViewCell.swift
//  SeSAC Week5 TMDB API
//
//  Created by 이명진 on 2022/08/07.
//

import UIKit
import Kingfisher

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
    
    func setUI(_ data: CastResults) {
        nameLabel.text = data.name
        characterLabel.text = data.character
        
        let imageURL = "https://image.tmdb.org/t/p/w220_and_h330_face"
        guard let img = data.profile_path else { return }
        let image = URL(string: imageURL + img)
        castImageView.kf.setImage(with: image)
        castImageView.contentMode = .scaleToFill
        castImageView.layer.cornerRadius = castImageView.frame.height / 2
        
    }
    
    

}
