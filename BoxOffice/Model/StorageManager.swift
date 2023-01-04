//
//  StorageManager.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/04.
//

import Foundation
import FirebaseStorage

final class StorageManager {
   
    func putMovieList(models: [MovieModel]) {
        let reference = Storage.storage().reference().child("movieList")
        guard let data = encodeJson(data: models) else { return }
        reference.putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func fetchMovieList(completion: @escaping ([MovieModel]) -> Void) {
        let reference = Storage.storage().reference(withPath: "movieList")
        let megaByte = Int64(1 * 1024 * 1024)
        reference.getData(maxSize: megaByte) { data, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    private func encodeJson(data: [MovieModel]) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let encodeData = try encoder.encode(data)
            return encodeData
        } catch {
            print("인코딩 실패")
            return nil
        }
    }
    
    private func decodeJson(data: Data) -> [MovieModel]? {
        do {
            let decodeData = try JSONDecoder().decode([MovieModel].self, from: data)
            return decodeData
        } catch {
            print("디코딩 실패")
            return nil
        }
    }
    
}
