//
//  ApiManager.swift
//  ApiManager
//
//  Created by Арген on 11.06.2021.
//

import Foundation

enum ApiType {
    case getUser
    case getAlbum
    case getPost
    
    //Bazovyi URL
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    //URL path
    var path: String {
        switch self {
        case .getUser: return "users"
        case .getAlbum: return "albums"
        case .getPost: return "posts"
        }
    }
    
    //Header
    var header: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
    
    //Sozdaem put' request
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL))
        var requset = URLRequest(url: url!)
        requset.allHTTPHeaderFields = header
        switch self {
        default:
            requset.httpMethod = "GET"
            return requset
        }
    }
}

//Singleton
class Session {
    static let shared = Session()
    
    let session = URLSession.shared
    
    func getUser(completion: @escaping(Users) -> Void) {
        let requset = ApiType.getUser.request
        let task = session.dataTask(with: requset) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(UserElement.self, from: data)
                print("User:", user)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    func getAlbums(complition: @escaping(Albums) -> Void) {
        let request = ApiType.getAlbum.request
        let task = session.dataTask(with: request) { data, respons, error in
            guard let data = data else { return }
            print(data)
            
            if error != nil {
                print("Error:",error)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("JSON:", json)
            } catch let error {
                print("Error:",error)
            }
        }
        task.resume()
    }
    
    func getPost(complition: @escaping(Posts) -> Void) {
        let request = ApiType.getPost.request
        let task = session.dataTask(with: request) { data, response, error in
            print(data?.count)
        }
    }
}
