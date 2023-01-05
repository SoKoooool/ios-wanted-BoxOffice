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
    
    private var apiList: [MovieModel]?
    private var storageList: [MovieModel]?
    
    var movieListWithReply: [MovieModel]?
    
    func onFetch() {
        service.fetch { [weak self] result in
            switch result {
            case let .success(movieList):
                self?.apiList = movieList
                print(self?.apiList)
                self?.onStorageFetch()
//                print(self?.storageList)
//                self?.storageList = movieList
                self?.movieListWithReply = self?.checkSavedList()
                print(self?.movieListWithReply?.count)
//                print(self?.movieListWithReply)
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
            self?.storageList = models
        }
    }

    private func checkSavedList() -> [MovieModel] {
        var withReplyList = [MovieModel]()
        guard let storageList = storageList else {
            withReplyList = apiList!
            return withReplyList
        }
        
        apiList?.forEach { api in
            if storageList.contains(where: { storage in
                api.title == storage.title
            }) {
                print("포함")
            } else {
                print("미포함")
                withReplyList.append(api)
            }
        }
        return withReplyList
    }
}
