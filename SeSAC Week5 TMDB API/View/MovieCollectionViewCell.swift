



import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet weak var openDateLabel: UILabel!
    
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var castingCharactersLabel: UILabel!
    
    @IBOutlet weak var subView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    
    
    
    
}
