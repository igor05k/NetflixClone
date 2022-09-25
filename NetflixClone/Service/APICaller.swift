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

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movies], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/trending/movie/day?api_key=\(ConstantsAPI.API_KEY)") else { return }
        // https://api.themoviedb.org/3/trending/movie/day?api_key=c66d38aca3dfd09100ce4808233b0121
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping (Result<[TVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/trending/tv/day?api_key=\(ConstantsAPI.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(TVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movies], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/movie/upcoming?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movies], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/movie/top_rated?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(result.results))
            } catch  {
                print(error.localizedDescription)
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularTVShows(completion: @escaping (Result<[TVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/tv/popular?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                let result = try JSONDecoder().decode(TVShowsResponse.self, from: data)
//                completion(.success(result.results))
                print(result)
            } catch  {
                print(error.localizedDescription)
//                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
