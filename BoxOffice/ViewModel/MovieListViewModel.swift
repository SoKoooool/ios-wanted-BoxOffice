//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
 
    private let service = APIService()
    
    func onFetch() {
        service.fetch { result in
            switch result {
            case let .success(movieList):
                print(movieList)
            case let .failure(error):
                print(error)
            }
        }
    }
}
