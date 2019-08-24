//
//  NetworkManager.swift
//  Synup_Keshav
//
//  Created by Keshav Raj on 24/08/19.
//  Copyright © 2019 BVAPvtLtd. All rights reserved.
//

import Foundation

typealias JSONTaskCompletionHandler = (Result<[String: Any]>) -> ()

enum Result <T> {
    case success(T)
    case error(SynupApiError)
}

enum SynupApiError: Error {
    case noInternet
    case invalidUrl
    case someOtherError
    case invalidData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private lazy var urlSession: URLSession = {
        let session = URLSession.shared
        //Do any other configurations
        return session
    }()
    
    private var serializeDataToJson: (Data) -> Any? = {
        data in
        do {
            let JSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return JSON
        }
        
        catch let error {
            debugPrint("Error in json serialization of data")
            return nil
        }
    }
    
    //Make initializer private for singleton class
    private init() { }
    
    /**
     Makes the GET request for JSON
     - Parameter endPoint: End point where the get request is to be made
     - Parameter completion: Completion block to be called when the request has finished
     */
    func JSONGetRequest(endPoint: SynupEndPoint,
                    completion: @escaping JSONTaskCompletionHandler) {
        
        guard let url = URL(string: endPoint.request) else {
            debugPrint("Invalid url")
            completion(.error(.invalidUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        //Configure URL Request further
        urlSession.dataTask(with: urlRequest) {
            [weak self] data, response, error in
            if let error = error {
                if (error as NSError).code == -1009 { //No internet Apple error
                    completion(.error(.noInternet))
                } else {
                    completion(.error(.someOtherError))
                }
            }
            
            guard let data = data else { //If there is no error, then there should be some data in get reuest
                completion(.error(.someOtherError))
                return
            }
            
            if let JSON = self?.serializeDataToJson(data) as? [String: Any] {
                completion(.success(JSON))
            } else {
                completion(.error(.invalidData))
            }
        }.resume()
    }
}
