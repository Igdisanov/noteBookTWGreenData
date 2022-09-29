//
//  NetworkService.swift
//  noteBookTWGreenData
//
//  Created by Vadim Igdisanov on 27.09.2022.
//

import Foundation
import UIKit

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (GetResultsResponse) -> () ) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let  data = data else {return}
            DispatchQueue.main.async {
                do {
                    let user = try JSONDecoder().decode(GetResultsResponse.self, from: data)
                    completion(user)
                } catch let error {
                    print("Error serialization jsone", error)
                }
            }
            
        }.resume()
    }
    
    public func getImage(url: URL, completion: @escaping (UIImage) -> () ) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let  data = data, let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
