//
//  APICaller.swift
//  NetflixClone
//
//  Created by Igor Fernandes on 25/09/22.
//

import Foundation

struct ConstantsAPI {
    static let API_KEY = "c66d38aca3dfd09100ce4808233b0121"
    static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
    static let shared = APICaller()
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/trending/all/day?api_key=\(ConstantsAPI.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self.self, from: data)
                print(result)
            } catch {
                print(error.localizedDescription)
            }   
        }
        task.resume()
    }
}
