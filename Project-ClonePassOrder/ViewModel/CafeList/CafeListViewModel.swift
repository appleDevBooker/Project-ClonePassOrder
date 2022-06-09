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
    
    init(service: CafeListServicePorotocol = CafeListService()) {
        self.cafeSerivce = service
    }
    
    var cafeSerivce: CafeListServicePorotocol
    var items: Observer<[CafeListViewModelItem]> = Observer(value: [])
    var imageSuccess: Observer<Bool> = Observer(value: false)
    var cafeServiceError: Observer<CafeListServiceError> = Observer(value: .snapShotError)
}

extension CafeListViewModel {
    
    func count() -> Int {
        self.items.value.count
    }
    func itemAtIndex(_ index: Int) -> CafeListViewModelItem {
        let item = self.items.value[index]
        return item
    }
    func orderNearStore(coodinate: CLLocation) -> [CafeListViewModelItem] {
       let items = items.value.sorted {
           $0.distance(coordinate: coodinate) < $1.distance(coordinate: coodinate)
        }
        return items
    }
    func orderManyStoryStore() -> [CafeListViewModelItem] {
        let items = items.value.sorted {
            $0.storyCount > $1.storyCount
        }
        return items
    }
    func
    orderNewStore(coodinate: CLLocation) -> [CafeListViewModelItem] {
        let items = items.value.sorted {
             $0.distance(coordinate: coodinate)  < $1.distance(coordinate: coodinate)
        }.filter {
            return $0.newTime == "신규매장"
        }
        return items
    }
    func searchCafe(text: String) -> [CafeListViewModelItem] {
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
                    CafeListViewModelItem.init(
                        model: $0
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

final class CafeListViewModelItem {
    
    init(model: CafeListModel) {
        self.model = model
    }
    
    var model: CafeListModel
    var cellImageData: Data?
    var name: String {
       return model.name
    }
    var storyCount: Int {
        return model.storyCount
    }
    var favoriteCount: Int {
        return model.favoriteCount
    }
    var orderTime: String {
        return model.orderTime
    }
    var newTime: String {
        return model.newTime
    }
    var cafeImageURL: URL? {
        return URL(string: model.imageURL)
    }
    func distanceString(coordinate: CLLocation) -> String {
        let userCoordinate = coordinate
        let cafeCoordinate = CLLocation(latitude: model.lat, longitude: model.lon)
        let distance = userCoordinate.distance(from: cafeCoordinate)
        if Int(distance) < 1000 {
            return  "\(Int(distance))m"
        } else {
            return String(format: "%.2f", Double(distance) / 1000) + "km"
        }
    }
    func distance(coordinate: CLLocation) -> Int {
        let userCoordinate = coordinate
        let cafeCoordinate = CLLocation(latitude: model.lat, longitude: model.lon)
        let distance = userCoordinate.distance(from: cafeCoordinate)
        return Int(distance)
    }
}
