//
//  CafeService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation
import Firebase

enum CafeListServiceError: Error {
    case CafeFetchError
    case snapShotError
}

protocol CafeListServicePorotocol {
    func fetchCafe(completion: @escaping (Result<[CafeListModel], CafeListServiceError>) -> Void)
}

struct CafeListService: CafeListServicePorotocol {
    func fetchCafe(completion: @escaping (Result<[CafeListModel], CafeListServiceError>) -> Void) {
        Firestore.firestore().collection("cafe").getDocuments { snapShot, error in
            if error != nil {
                completion(.failure(.CafeFetchError))
            } else {
                guard let documets = snapShot?.documents else {
                    completion(.failure(.snapShotError))
                    return
                }
                let models = documets.map {
                    CafeListModel(
                        name: $0.data()["name"] as? String ?? "",
                        storyCount: $0.data()["storyCount"] as? Int ?? 0,
                        favoriteCount: $0.data()["favoriteCount"] as? Int ?? 0,
                        imageURL: $0.data()["imageURL"] as? String ?? "",
                        lat: $0.data()["lat"] as? Double ?? 0,
                        lon: $0.data()["lon"] as? Double ?? 0,
                        orderTime: $0.data()["orderTime"] as? String ?? "",
                        newTime: $0.data()["newTime"] as? String ?? ""
                    )
                }
                completion(.success(models))
            }
        }
    }
}
