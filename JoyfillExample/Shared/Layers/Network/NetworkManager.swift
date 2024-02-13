//
//  NetworkManager.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

public class NetworkManager: NetworkProtocol {
    
    public func request<T, U>(_ endpoint: U, expectedType: T.Type, _ onResponse: @escaping (Result<T, Error>) -> Void) where T: Decodable, U: Endpoint {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        configureRequestBody(for: &urlRequest, with: endpoint.task)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onResponse(.failure(error))
                    return
                }
                
                guard let data else {
                    onResponse(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                    return
                }
                
                if expectedType == Data.self, let dataAsT = data as? T {
                    onResponse(.success(dataAsT))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(expectedType, from: data)
                    onResponse(.success(decodedResponse))
                } catch {
                    onResponse(.failure(error))
                }
            }
        }.resume()
    }
}

private extension NetworkManager {
    func configureRequestBody(for request: inout URLRequest, with task: HTTPTask) {
        switch task {
        case .requestPlain:
            break
        case let .requestParameters(parameters, encoding):
            switch encoding {
            case .url:
                if var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                    let queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
                    request.url = urlComponents.url
                }
            case .json:
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        case let .requestBody(body):
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
