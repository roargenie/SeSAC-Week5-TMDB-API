

import Foundation
import Alamofire
import SwiftyJSON

class APIManagers {
    
    static let shared = APIManagers()
    private init() { }
    
    typealias movieCompletionHandler = (Int, [MovieResults]) -> Void
    typealias genreCompletionHandler = ([Int: String]) -> Void
    typealias castCompletionHandler = ([CastResults]) -> Void
    
    func movieRequest(start: Int, completionHandler: @escaping movieCompletionHandler) {
        
        let url = EndPoint.tmdbURL
        
        let parameter: Parameters = ["api_key": APIKey.TMDB, "page": start]
        
        AF.request(url, method: .get, parameters: parameter).validate().responseDecodable(of: MovieModel.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let totalCount = value.total_results
                let data = value.results
                
                completionHandler(totalCount, data)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func genreRequest(completionHandler: @escaping genreCompletionHandler) {
        
        let url = EndPoint.genreURL
        
        let parameter: Parameters = ["api_key": APIKey.TMDB]
        
        AF.request(url, method: .get, parameters: parameter).validate().responseData(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var genresDic: [Int: String] = [:]
                for i in json["genres"].arrayValue {
                    let id = i["id"].intValue
                    let name = i["name"].stringValue
                    
                    genresDic.updateValue(name, forKey: id)
                }
                
                completionHandler(genresDic)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func castRequest(movie_id: Int, completionHandler: @escaping castCompletionHandler) {
        
        let url = EndPoint.castURL + "\(movie_id)/credits"
        
        let parameter: Parameters = ["api_key": APIKey.TMDB]
        
        AF.request(url, method: .get, parameters: parameter).validate().responseDecodable(of: CastModel.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let data = value.cast
                
                completionHandler(data)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
}







