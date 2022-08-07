
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController {
    
    static let identifier = "ViewController"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieData = [MovieResults]()
    var genres: [Int: String] = [:]
    
    var start = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        collectionViewLayout()
        requestGenre()
        
    }
    
    func requestMovie() {
        
        APIManagers.shared.movieRequest(start: start) { totalCount, data in
            self.totalCount = totalCount
            self.movieData.append(contentsOf: data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    func requestGenre() {
        APIManagers.shared.genreRequest { data in
            self.genres = data
            
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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let data = movieData[indexPath.item]
        
        cell.openDateLabel.text = data.release_date
        cell.movieTitleLabel.text = data.title
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.item && movieData.count < totalCount {
                start += 1
                requestMovie()
            }
        }
    }

    
}

