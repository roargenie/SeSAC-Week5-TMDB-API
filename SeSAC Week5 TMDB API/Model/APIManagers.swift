

import Foundation
import Alamofire
import SwiftyJSON

class APIManagers {
    
    static let shared = APIManagers()
    private init() { }
    
    typealias movieCompletionHandler = (Int, [MovieResults]) -> Void
    typealias genreCompletionHandler = ([Int: String]) -> Void
    typealias castCompletionHandler = ([CastResults]) -> Void
    typealias videoCompletionHandler = ([VideoResults]) -> Void
    
    func movieRequest(start: Int, completionHandler: @escaping movieCompletionHandler) {
        
        let url = EndPoint.tmdbURL + "\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MovieModel.self, queue: .global()) { response in
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
        
        let url = EndPoint.genreURL + "\(APIKey.TMDB)&language=en-US"
        
        AF.request(url, method: .get).validate().responseData(queue: .global()) { response in
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
        
        let url = EndPoint.castURL + "\(movie_id)/credits?api_key=\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: CastModel.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let data = value.cast
                print(data)
                completionHandler(data)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func videoRequest(movie_id: Int, completionHandler: @escaping videoCompletionHandler) {
        
        let url = EndPoint.videoURL + "\(movie_id)/videos?api_key=\(APIKey.TMDB)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Video.self, queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let data = value.results
                completionHandler(data)
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}





