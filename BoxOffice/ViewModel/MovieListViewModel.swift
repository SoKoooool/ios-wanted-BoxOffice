//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
 
    private let service = APIService()
    
    var movieList: Observable<[MovieModel]?>?
    
    func onFetch() {
        service.fetch { [weak self] result in
            switch result {
            case let .success(movieList):
                self?.movieList?.value = movieList
            case let .failure(error):
                print(error)
            }
        }
    }
}
