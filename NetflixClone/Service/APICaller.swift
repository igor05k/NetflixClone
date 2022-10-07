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
    
    func getTrendingMovies(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/trending/movie/day?api_key=\(ConstantsAPI.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTVShows(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/trending/tv/day?api_key=\(ConstantsAPI.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/movie/upcoming?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/movie/top_rated?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularTVShows(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/tv/popular?api_key=\(ConstantsAPI.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch  {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoveryMovies(completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/discover/movie?api_key=\(ConstantsAPI.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[MoviesAndTVShows], Error>) -> Void) {
        guard let queryFormatted = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(ConstantsAPI.baseURL)/3/search/movie?api_key=\(ConstantsAPI.API_KEY)&query=\(queryFormatted)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(MoviesAndTVShowsResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
