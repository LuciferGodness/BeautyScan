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


final class ApiServices {
    func sendRequest<Response: Decodable>(url: Endpoints, method: HTTPMethod = .get) -> Single<Response> {
        guard let url = URL(string: url.string) else { return Single.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return fetchData(urlRequest: urlRequest).asSingle()
    }
    
    func sendRequest<Response: Decodable, Request: PFormEncoding>(url: Endpoints, model: Request, method: HTTPMethod = .get, contentType: String = "application/x-www-form-urlencoded") -> Single<Response> {
        guard let url = URL(string: url.string) else { return Single.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if contentType == "application/json" {
            urlRequest.httpBody = try? JSONEncoder().encode(model)
        } else if contentType == "application/x-www-form-urlencoded" {
            urlRequest.httpBody = model.formsData.data(using: .utf8)
        }
        return fetchData(urlRequest: urlRequest).asSingle()
    }
    
    func sendRequest<Response: Decodable>(url: Endpoints, imageData: Data, fileName: String, method: HTTPMethod = .post) -> Single<Response> {
        guard let url = URL(string: url.string) else {
            return Single.error(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
        //TODO: move and refactor
        let boundary = "Boundary-\(UUID().uuidString)"
        let headers = [
            "content-type": "multipart/form-data; boundary=\(boundary)",
            "X-RapidAPI-Key": "ecccd7f8fdmshe620156647a36f0p173ee5jsnd24c19ed4066",
            "X-RapidAPI-Host": "skin-analyze.p.rapidapi.com"
        ]
        
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = body
        
        return fetchData(urlRequest: urlRequest).asSingle()
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
