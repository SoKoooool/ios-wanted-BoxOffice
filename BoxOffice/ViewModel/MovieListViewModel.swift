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
    
    func onStorageFetch() {
        
    }
    
    // 네트워킹 한 데이터를 클라이언트 모델로 변환 후, 스토리지에 저장
    // 스토리지에 저장된 데이터를 로드
    // 댓글을 작성하여 스토리지에 저장
    
    // 네트워킹을 한 데이터와 스토리지의 데이터 검증 필요
    // 리스트뷰는 스토리지를 의존하고 있다
    
    // 네트워킹 한 데이터의 영화 이름과 스토리지의 영화 이름을 비교하여
    // 겹치는 영화와 새로 추가된 영화를 다시 저장한다
}
