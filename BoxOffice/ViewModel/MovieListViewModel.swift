//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
 
    private let service = APIService()
    private let storageManager = StorageManager()
    
    private var apiMovieList: [MovieModel]?
    private var storageMovieList: [MovieModel]?
    
    var movieListWithReply: [MovieModel]?
    
    func onFetch() {
        service.fetch { [weak self] result in
            switch result {
            case let .success(movieList):
                self?.apiMovieList = movieList
                self?.onStorageFetch()
                self?.movieListWithReply = self?.checkSavedList()
            case let .failure(error):
                print(error)
            }
        }
    }
    
//    private func onApiFetch() {
//        service.fetch { [weak self] result in
//            switch result {
//            case let .success(movieList):
//                self?.apiMovieList = movieList
//            case let .failure(error):
//                print(error)
//            }
//        }
//    }
    
    private func onStorageFetch() {
        storageManager.fetchMovieList { [weak self] models in
            self?.storageMovieList = models
        }
    }

    private func checkSavedList() -> [MovieModel] {
        var models = [MovieModel]()
        apiMovieList?.forEach { api in
            storageMovieList?.forEach { storage in
                if api.title == storage.title {
                    models.append(storage)
                } else {
                    models.append(api)
                }
            }
        }
        return models
    }
}
