//
//  APIService.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class APIService {
    
    let repository = Repository()
    
    typealias ParseResult = Result<[MovieModel]?, Error>
    
    func fetch(completion: @escaping (ParseResult) -> Void) {
        repository.fetch { [weak self] result in
            switch result {
            case let .success(data):
                let movieList = self?.parseJson(data: data)
                self?.fetchImageUrl(from: movieList, completion: { models in
                    completion(.success(models))
                })
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseJson(data: Data) -> BoxOfficeEntity? {
        do {
            let decodeData = try JSONDecoder().decode(BoxOfficeEntity.self, from: data)
            return decodeData
        } catch {
            print("디코딩 실패")
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func fetchImageUrl(from: BoxOfficeEntity?, completion: @escaping ([MovieModel]) -> Void) {
        var models = [MovieModel]()
        from?.boxOfficeResult.dailyBoxOfficeList.forEach { movie in
            repository.posterFetch(term: "avengers") { str in
                let model = MovieModel(rank: movie.rank,
                                       title: movie.title,
                                       date: movie.openDate,
                                       thumbnail: str ?? "",
                                       reply: nil)
                models.append(model)
                guard models.count == from?.boxOfficeResult.dailyBoxOfficeList.count else { return }
                completion(models)
            }
        }
    }
}
