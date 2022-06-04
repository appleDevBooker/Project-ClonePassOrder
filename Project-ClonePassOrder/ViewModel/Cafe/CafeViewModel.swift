//
//  CafeViewModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation
import CoreLocation
import UIKit

//MARK: - List

final class CafeListViewModel {
    
    init(service: CafeServicePorotocol = CafeService(), corrdinate: CLLocationCoordinate2D) {
        self.cafeSerivce = service
        self.coordinate = corrdinate
    }
    
    var cafeSerivce: CafeServicePorotocol
    var items: Observer<[CafeViewModelItem]> = Observer(value: [])
    var cafeServiceError: Observer<CafeServiceError> = Observer(value: .snapShotError)
    var coordinate: CLLocationCoordinate2D
}

extension CafeListViewModel {
    
    func count() -> Int {
        self.items.value.count
    }
    func itemAtIndex(_ index: Int) -> CafeViewModelItem {
        let item = self.items.value[index]
        return item
    }
    func orderNearStore() -> [CafeViewModelItem] {
       let items = items.value.sorted {
            $0.distance < $1.distance
        }
        return items
    }
    func orderManyStoryStore() -> [CafeViewModelItem] {
        let items = items.value.sorted {
            $0.storyCount > $1.storyCount
        }
        return items
    }
    func orderNewStore() -> [CafeViewModelItem] {
        let items = items.value.sorted {
             $0.distance  < $1.distance
        }.filter {
            return $0.newTime == "신규매장"
        }
        return items
    }
    func searchCafe(text: String) -> [CafeViewModelItem] {
        let items = items.value.filter {
            $0.name.contains(text)
        }
        return items
    }
    func fetchCafe() {
        cafeSerivce.fetchCafe { [weak self] result in
            switch result {
            case .success(let models):
                let items = models.map {
                    CafeViewModelItem.init(
                        model: $0,
                        userCoordinate: CLLocation(
                            latitude: self!.coordinate.latitude,
                            longitude: self!.coordinate.longitude
                        )
                    )
                }
                self?.items.value = items
            case .failure(let error):
                self?.cafeServiceError.value = error
            }
        }
    }
}

//MARK: - item

final class CafeViewModelItem {
    
    init(model: CafeModel, userCoordinate: CLLocation) {
        self.model = model
        self.userCoordinate = userCoordinate
    }
    
    var model: CafeModel
    var userCoordinate: CLLocation
    var cellImage: UIImage?
    var name: String {
       return model.name
    }
    var address: String {
        return model.address
    }
    var storyCount: Int {
        return model.storyCount
    }
    var favoriteCount: Int {
        return model.favoriteCount
    }
    var info: String {
        return model.info
    }
    var offDay: String {
        return model.offDay
    }
    var openTime: String {
        return model.openTime
    }
    var orderTime: String {
        return model.orderTime
    }
    var phoneNumber: String {
        return model.phoneNumber
    }
    var benefit: String {
        return model.benefit
    }
    var newTime: String {
        return model.newTime
    }
    var distanceString: String {
        let cafeCoordinate = userCoordinate
        let userCoordinate = CLLocation(latitude: model.lat, longitude: model.lon)
        let distance = userCoordinate.distance(from: cafeCoordinate)
        if Int(distance) < 1000 {
            return  "\(Int(distance))m"
        } else {
            return String(format: "%.2f", Double(distance) / 1000) + "km"
        }
    }
    var distance: Int {
        let cafeCoordinate = userCoordinate
        let userCoordinate = CLLocation(latitude: model.lat, longitude: model.lon)
        let distance = userCoordinate.distance(from: cafeCoordinate)
        return Int(distance)
    }
    var cafeImageURL: URL? {
        return URL(string: model.imageURL)
    }
}
