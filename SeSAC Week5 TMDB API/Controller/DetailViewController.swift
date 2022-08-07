
import UIKit

import Kingfisher
import Alamofire



class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    
    var movieData: MovieResults?
    
    var castData: [CastResults] = []
    
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
        
        
    }
    
    func requestCast() {
        
        guard let movieID = self.movieData?.id else { return }
        
        APIManagers.shared.castRequest(movie_id: movieID) { data in
            
            self.castData.append(contentsOf: data)
            print("\(self.castData)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            let data = castData[indexPath.row]
            
            cell.characterLabel.text = data.character
            cell.nameLabel.text = data.name
            
            return cell
        }
        return UITableViewCell()
    }
    
}


