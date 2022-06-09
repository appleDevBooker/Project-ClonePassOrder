//
//  MockCafeService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation

struct MockCafeListService: CafeListServicePorotocol {
    
    var result: Result<[CafeListModel], CafeListServiceError>?
    
    func fetchCafe(completion: @escaping (Result<[CafeListModel], CafeListServiceError>) -> Void) {
        completion(result!)
    }
}
