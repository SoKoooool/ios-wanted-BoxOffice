//
//  Repository.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class Repository {
    
    private let movieApiKey = "key=42067899a1fd583566eb123ec528802d"
    private let posterApiKey = "apikey=325ca562"
    
    private let apiUrl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    private let posterUrl = "https://www.omdbapi.com/?"
    
    typealias FetchResult = Result<Data, Error>
    
    func fetch(completion: @escaping (FetchResult) -> Void) {
        let urlString = apiUrl + movieApiKey + "&targetDt=20220101"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "네트워킹 실패", code: -1)))
                return
            }
            print("\(#function), \(response.statusCode)")
            
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
    
    func posterFetch(term: String, completion: @escaping (String?) -> Void) {
        let urlString = posterUrl + posterApiKey + "&t=" + term
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print("\(#function), \(response.statusCode)")
            
            guard let data = data else { return }
            
            struct Poster: Decodable {
                let poster: String?
                
                enum CodingKeys: String, CodingKey {
                    case poster = "Poster"
                }
            }
            let decodeData = try? JSONDecoder().decode(Poster.self, from: data)
            completion(decodeData?.poster)
        }.resume()
    }
}
