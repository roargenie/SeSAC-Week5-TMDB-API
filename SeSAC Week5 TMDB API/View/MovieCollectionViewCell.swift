



import UIKit
import Kingfisher


class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet weak var openDateLabel: UILabel!
    
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var castingCharactersLabel: UILabel!
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var linkButton: UIButton!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var rateNumberLabel: UILabel!
    
    @IBOutlet weak var detailViewLabel: UILabel!
    
    @IBOutlet weak var detailViewButton: UIButton!
    
    @IBOutlet weak var dividingLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func setUI(_ data: MovieResults) {
        openDateLabel.text = data.release_date
        movieTitleLabel.text = data.title
        rateNumberLabel.text = String(format: "%.1f", data.vote_average)
        
        
        let imageURL = "https://image.tmdb.org/t/p/w220_and_h330_face"
        
        guard let url = URL(string: (imageURL + data.poster_path)) else { return }
        movieImage.kf.setImage(with: url)
        
        movieImage.layer.cornerRadius = 12
        
        subView.backgroundColor = .white
        subView.layer.borderColor = UIColor.systemGray4.cgColor
        subView.layer.borderWidth = 1
        subView.layer.cornerRadius = 12
        subView.layer.shadowOffset = CGSize(width: 5, height: 5)
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowRadius = 4
        subView.layer.shadowOpacity = 0.3
        
        dividingLineView.layer.borderWidth = 1
        dividingLineView.layer.borderColor = UIColor.systemGray4.cgColor
        
    }
    
    func setGenre(_ genres: [String]) {
        var text = ""
        for i in genres {
            text = text + " #\(i)"
        }
        movieGenreLabel.text = text
        
    }
    
    
    
    
    
    
}
