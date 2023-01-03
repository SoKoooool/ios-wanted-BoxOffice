//
//  Observable.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/03.
//

import Foundation

final class Observable<T> {
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    private var closure: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func subscribe(completion: @escaping (T) -> Void) {
        completion(value)
        closure = completion
    }
}
