
import UIKit

import Kingfisher
import Alamofire



class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    var movieData: MovieResults?
    
    var castData: [CastResults] = []
    
    var isExpanded = false
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "출연/제작"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        requestCast()
        configureUI()
    }
    
    func requestCast() {
        
        guard let movieID = self.movieData?.id else { return }
        
        APIManagers.shared.castRequest(movie_id: movieID) { data in
            print("Data: =================\(data)")
            self.castData.append(contentsOf: data)
            print("============\(self.castData)===========")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func configureUI() {
        if let data = self.movieData {
            let imageURL = "https://image.tmdb.org/t/p/w220_and_h330_face"
            guard
                let posterImage = URL(string: imageURL + data.poster_path),
                let backImage = URL(string: imageURL + data.backdrop_path) else { return }
            posterImageView.kf.setImage(with: posterImage)
            posterImageView.contentMode = .scaleAspectFill
            backgroundImageView.kf.setImage(with: backImage)
            backgroundImageView.contentMode = .scaleAspectFill
            movieTitleLabel.text = data.title
        }
    }
    
    @IBAction func overViewButtonTapped(_ sender: UIButton) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Overview"
        } else if section == 1 {
            return "Cast"
        } else {
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return castData.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
            
            if let data = self.movieData {
                cell.overViewLabel.text = data.overview
            }
            cell.overViewLabel.numberOfLines = isExpanded ? 0 : 2
            if isExpanded == false {
                cell.moreViewButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            } else {
                cell.moreViewButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            }
            
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            let data = castData[indexPath.row]
            print(data)
            cell.setUI(data)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else if indexPath.section == 1 {
            return 100
        } else {
            return 0
        }
    }
    
}


