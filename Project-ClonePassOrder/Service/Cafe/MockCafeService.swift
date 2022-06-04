//
//  MockCafeService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation

struct MockCafeService: CafeServicePorotocol {
    
    var result: Result<[CafeModel], CafeServiceError>?
    
    func fetchCafe(completion: @escaping (Result<[CafeModel], CafeServiceError>) -> Void) {
        completion(result!)
    }
}
