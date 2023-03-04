//
//  ConfigFetcher.swift
//  Pizza
//
//  Created by Alexey Ivanov on 4/3/23.
//

import Foundation

class ConfigFetcher {
    let configURL = URL(string: "https://raw.githubusercontent.com/t0rn/Pizza/main/Pizza/AppConfig.json")!
    
//    func completionHandler(_ data: Data?, response: URLResponse?, error: Error?) {
//
//    }
    func fetchConfig(completion: @escaping ((Error?, AppConfig?) -> Void) ) {
        let request = URLRequest(url: configURL)
        let task = URLSession.shared.dataTask(with: request,
                                   completionHandler: { (data, response, error) in
            print("data task result")
            if let error = error {
                print(error)
                completion(error, nil)
                return
            }
            guard let data = data else {return}
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            do {
                let config = try JSONDecoder().decode(AppConfig.self, from: data)
                completion(nil, config)
            } catch {
                print(error)
                completion(error, nil)
            }
        })
        
        task.resume()
        print("continue execution")
    }
}
