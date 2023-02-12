//
//  URLFondler.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import Foundation

class HttpData {
    
    public var homeData: String = ""
    
    init() {
        fetchHomeData()
    }


public func fetchData(from urlString: String, completion: @escaping (Result<String, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(URLError(.badURL)))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not retrieved from the request"])))
            return
        }

        guard let encodedString = String(data: data, encoding: .utf8) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data could not be encoded as UTF-8"])))
            return
        }

        completion(.success(encodedString))
    }.resume()
}
        
    func fetchHomeData() {
        let urlString = "http://100.26.154.173/"
        fetchData(from: urlString) { result in
            if case .success(let data) = result {
                self.homeData = data
            } else if case .failure(let error) = result {
                print("Error fetching data: \(error)")
            }
        }
    }
}

class PostHTTP {
    func postRequest(url: URL, parameters: [String: Any], completion: @escaping (Result<Data?, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
