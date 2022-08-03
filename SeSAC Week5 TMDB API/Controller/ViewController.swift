
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieData: [MovieModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        collectionViewLayout()
        requestData()
    }
    
    func requestData() {
        
        let url = EndPoint.tmdbURL + "\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for i in 0...19 {
                    let imageURL = json["results"][i]["backdrop_path"].stringValue
                    guard let image = URL(string: "http://image.tmdb.org/t/p/w185" + "\(imageURL)") else { return }
                    
                    let title = json["results"][i]["title"].stringValue
                    
                    let releaseDate = json["results"][i]["release_date"].stringValue
                    
                    let data = MovieModel(releaseDate: releaseDate, movieTitle: title, movieImage: image)
                    
                    self.movieData.append(data)
                    
                }
                self.collectionView.reloadData()
                print(self.movieData)
                
                
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (spacing * 2))
        
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let data = movieData[indexPath.row]
        
        cell.movieImage.kf.setImage(with: data.movieImage)
        cell.movieTitleLabel.text = data.movieTitle
        cell.openDateLabel.text = data.releaseDate
        
        return cell
    }
    
    
}
