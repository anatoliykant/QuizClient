//
//  NetworkManager.swift
//  Quiz admin
//
//  Created by kant on 17/09/2019.
//  Copyright © 2019 kant. All rights reserved.
//

import UIKit

class NetworkManager<T: Codable> {
    
    enum Errors: Swift.Error {
        case cantDecodeData(Data)
        
        var description: String {
            switch self {
            case .cantDecodeData(let data):
                return "Can't  decode data \(data)"
            }
        }
    }
    
    // MARK: Private properties
    
    private let url: URL
    
    // MARK: Lifecycle
    
    init?(apiURL path: String) {
        guard let url = URL(string: path) else { return nil }
        self.url = url
    }
    
    func getAll(completion: @escaping (Codable?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(nil, error)
            }
            
            let decoder = JSONDecoder()
            guard let codable = try? decoder.decode([T].self, from: data) else {
                return completion(nil, Errors.cantDecodeData(data))
            }
            
            completion(codable, nil)
        }
        
        task.resume()
    }
}
