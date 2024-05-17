//
//  ApiService.swift
//  BeautyScan
//
//  Created by admin on 10.11.2023.
//

import Foundation
import RxSwift

enum ApiCoders {
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        
        return decoder
    }
}

struct APIData {
    let data: Data?
    let statusCode: Int
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

enum ApiError: Error {
    case invalidURL
    case noDataReceived
}


final class ApiServices {
    func sendRequest<Response: Decodable>(url: Endpoints, method: HTTPMethod = .get) -> Single<Response> {
        guard let url = URL(string: url.string) else {
            return Single.error(ApiError.invalidURL)
        }
        var urlRequest = URLRequest(url: url)
        if let token = AppState.current.accessToken {
            addAuthorizationHeader(to: &urlRequest)
        }
        urlRequest.httpMethod = method.rawValue
        
        return fetchData(urlRequest: urlRequest).asSingle()
    }
    
    func sendRequest<Response: Decodable, Request: PFormEncoding>(url: Endpoints, model: Request, method: HTTPMethod = .get, contentType: String = "application/x-www-form-urlencoded") -> Single<Response> {
        guard let url = URL(string: url.string) else {
            return Single.error(ApiError.invalidURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if contentType == "application/json" {
            //TODO: REMOVE IT
            if let token = AppState.current.accessToken {
                addAuthorizationHeader(to: &urlRequest)
            }
            urlRequest.httpBody = try? JSONEncoder().encode(model)
        } else if contentType == "application/x-www-form-urlencoded" {
            urlRequest.httpBody = model.formsData.data(using: .utf8)
        }
        return fetchData(urlRequest: urlRequest).asSingle()
    }
    
    private func addAuthorizationHeader(to request: inout URLRequest) {
        if let token = AppState.current.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    func fetchData<Response: Decodable>(urlRequest: URLRequest) -> Observable<Response> {
        return Observable<Response>.create { observer -> Disposable in
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                _ = String(data: data ?? Data(), encoding: .utf8) ?? ""
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(Response.self, from: data)
                    observer.onNext(model)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
