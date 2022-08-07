

import UIKit

struct MovieModel: Codable {
    
    var page: Int
    var results: [MovieResults]
    var total_pages: Int
    var total_results: Int
    
}

struct MovieResults: Codable {
    
    var adult: Bool
    var id: Int
    var title: String
    var release_date: String
    var overview: String
    var poster_path: String
    var backdrop_path: String
    var genre_ids: [Int]
    var vote_average: Double
    
}

struct CastModel: Codable {
    
    var id: Int
    var cast: [CastResults]
    
}

struct CastResults: Codable {
    
    var name: String
    var profile_path: String
    var character: String
    
}

struct Video: Codable {
    
    var id: Int
    var results: [VideoResults]
    
}

struct VideoResults: Codable {
    
    var key: String
    var site: String
    var type: String
    
}
