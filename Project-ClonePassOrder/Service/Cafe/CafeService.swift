//
//  CafeService.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation
import Firebase

enum CafeServiceError: Error {
    case CafeFetchError
    case snapShotError
}

protocol CafeServicePorotocol {
    func fetchCafe(completion: @escaping (Result<[CafeModel], CafeServiceError>) -> Void)
}

struct CafeService: CafeServicePorotocol {
    func fetchCafe(completion: @escaping (Result<[CafeModel], CafeServiceError>) -> Void) {
        Firestore.firestore().collection("cafe").getDocuments { snapShot, error in
            if error != nil {
                completion(.failure(.CafeFetchError))
            } else {
                guard let documets = snapShot?.documents else {
                    completion(.failure(.snapShotError))
                    return
                }
                let models = documets.map {
                    CafeModel(
                        name: $0.data()["name"] as? String ?? "",
                        address: $0.data()["address"] as? String ?? "",
                        storyCount: $0.data()["storyCount"] as? Int ?? 0,
                        favoriteCount: $0.data()["favoriteCount"] as? Int ?? 0,
                        imageURL: $0.data()["imageURL"] as? String ?? "",
                        info: $0.data()["info"] as? String ?? "",
                        lat: $0.data()["lat"] as? Double ?? 0,
                        lon: $0.data()["lon"] as? Double ?? 0,
                        offDay: $0.data()["offDay"] as? String ?? "",
                        openTime: $0.data()["openTime"] as? String ?? "",
                        orderTime: $0.data()["orderTime"] as? String ?? "",
                        phoneNumber: $0.data()["phoneNumber"] as? String ?? "",
                        benefit: $0.data()["benefit"] as? String ?? "",
                        newTime: $0.data()["newTime"] as? String ?? ""
                    )
                }
                completion(.success(models))
            }
        }
    }
    
    
}
