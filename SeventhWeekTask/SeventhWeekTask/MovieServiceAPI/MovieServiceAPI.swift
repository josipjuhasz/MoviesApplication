//
//  MovieServiceAPI.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation
import Alamofire
import RxSwift

class MovieServiceAPI {
    
    public static let shared = MovieServiceAPI()
    
    init() {}
    let apiKey = "?api_key=a415cfdc3dc928bd4649d310e90939e6"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    func getData<T: Codable>(url: String) -> Observable<T>{
        return Observable.create{ observer in
            let request = AF.request(url).validate(statusCode: 100..<500).responseDecodable(of: T.self, decoder: self.jsonDecoder){ networkResponse in
                switch networkResponse.result {
                case .success:
                    do{
                        let response = try networkResponse.result.get()
                        observer.onNext(response)
                        observer.onCompleted()
                    }
                    catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


