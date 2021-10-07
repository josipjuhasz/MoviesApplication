//
//  HomeRepository.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 13.07.2021..
//

import Foundation
import RxSwift

class RepositoryImpl: Repository {
    
    let movieServiceAPI: MovieServiceAPI
    
    init(movieServiceAPI: MovieServiceAPI) {
        self.movieServiceAPI = movieServiceAPI
    }
    
    func getMovies() -> Observable<NowPlayingResponse> {
        let moviesResponseObservable: Observable<NowPlayingResponse> = movieServiceAPI.getData(url: NetworkData.moviesUrl.value + movieServiceAPI.apiKey)
        return moviesResponseObservable
    }
    
    func getGenres() -> Observable<GenresResponse> {
        let genresResponseObservable: Observable<GenresResponse> = movieServiceAPI.getData(url: NetworkData.genreUrl.value + movieServiceAPI.apiKey)
        return genresResponseObservable
    }
    
    func getDirector(id: Int) -> Observable<CreditsResponse> {
        let directorResponseObservable: Observable<CreditsResponse> = movieServiceAPI.getData(url: NetworkData.directorUrl(id: id).value + movieServiceAPI.apiKey)
        return directorResponseObservable
    }
}

protocol Repository: AnyObject {
    
    func getMovies() -> Observable<NowPlayingResponse>
    func getGenres() -> Observable<GenresResponse>
    func getDirector(id: Int) -> Observable<CreditsResponse>
}

extension RepositoryImpl {
    
    enum NetworkData{
        
        case moviesUrl
        case genreUrl
        case directorUrl(id: Int)
        
        var value: String {
            switch(self) {
                case .moviesUrl:
                    return "https://api.themoviedb.org/3/movie/now_playing"
                case .genreUrl:
                    return "https://api.themoviedb.org/3/genre/movie/list"
                case .directorUrl(id: let id):
                    return "https://api.themoviedb.org/3/movie/\(id)/credits"
            }
        }
    }
}

