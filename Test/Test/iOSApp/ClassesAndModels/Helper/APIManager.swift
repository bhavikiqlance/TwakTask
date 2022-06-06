//
//  APIManager.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import UIKit

let WSTimeOut : TimeInterval = 180

enum HtttpType: String {
    case POST = "POST"
    case GET  = "GET"
}

class APIManager: NSObject {
    
    
    static let sharedInstance: APIManager = {
        
        let instance = APIManager()
        return instance
    }()
    private override init() {}
    
    func getJson(completion: @escaping (Home)-> ()) {
        let urlString = "https://jsonplaceholder.typicode.com/todos/11"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, res, err in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(Home.self, from: data)
                        completion(json)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

extension URLSession {
    
    func fetchUsersList(at url: URL, completion: @escaping (Result<[UsersData], Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let toDos = try JSONDecoder().decode([UsersData].self, from: data)
                    completion(.success(toDos))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
    
    func fetchUsersData(at url: URL, completion: @escaping (Result<UsersData, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let toDos = try JSONDecoder().decode(UsersData.self, from: data)
                    completion(.success(toDos))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
