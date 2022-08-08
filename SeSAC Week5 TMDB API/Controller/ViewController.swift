
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController {
    
    static let identifier = "ViewController"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieData = [MovieResults]()
    var movieDatas: MovieResults?
    var castData: [CastResults] = []
    var genresDic: [Int: String] = [:]
    
    var start = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        collectionViewLayout()
        //requestGenre()
        requestMovie()
        //requestCast()
    }
    
    func requestMovie() {
        
        APIManagers.shared.movieRequest(start: start) { totalCount, data in
            self.totalCount = totalCount
            self.movieData.append(contentsOf: data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.requestGenre()
            self.requestCast()
        }
    }
    
    func requestGenre() {
        APIManagers.shared.genreRequest { data in
            self.genresDic = data
            
        }
    }
    
    func requestCast() {
        
        guard let movieID = self.movieDatas?.id else { return }
        
        APIManagers.shared.castRequest(movie_id: movieID) { data in
            print("Data: =================\(data)")
            self.castData.append(contentsOf: data)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            print("============\(self.castData)===========")
        }
    }
    
    @objc func linkButtonTapped(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: WebKitViewController.identifier) as? WebKitViewController else { return }
        vc.movieID = movieData[sender.tag].id
        vc.navigationItem.title = movieData[sender.tag].title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 400
        
        layout.itemSize = CGSize(width: width, height: height)
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
        //let cast = castData[indexPath.item]
        var genreString: [String] = []
        
        for id in data.genre_ids {
            if genresDic.keys.contains(id) {
                if let genre = genresDic[id] {
                    genreString.append(genre)
                }
            }
        }
        //print(genreString)
        
        cell.setUI(data)
        cell.setGenre(genreString)
        cell.linkButton.tag = indexPath.item
        cell.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        vc.movieData = movieData[indexPath.item]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.item && movieData.count < totalCount {
                start += 20
                requestMovie()
            }
        }
    }

    
}

