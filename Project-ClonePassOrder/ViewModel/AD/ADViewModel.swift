//
//  ADViewModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/02.
//

import Foundation

//MARK: - List



final class ADListViewModel {
    
    init(service: ADServiceProtocol = ADService()) {
        self.adService = service
    }
    
    var adService: ADServiceProtocol
    
    var imageLoadEnd: Observer<Bool> = Observer(value: false)
    var items: Observer<[ADViewModelItem]> = Observer(value: [])
    var ADServiceError: Observer<ADServiceError> = Observer(value: .snapShotError)
}

extension ADListViewModel {
    
    func count() -> Int {
        self.items.value.count
    }
    func itemAtIndex(_ index: Int) -> ADViewModelItem {
        let item = self.items.value[index]
        return item
    }
    func fetchAD(collectionName: String) {
        adService.fetchAD(collectionName: collectionName) { [weak self] result in
            switch result {
            case .success(let models):
                let items = models.map {
                    ADViewModelItem(model: $0)
                }
                self?.items.value = items
            case .failure(let error):
                self?.ADServiceError.value = error
            }
        }
    }
}

//MARK: - item

struct ADViewModelItem: Equatable {
    
    static func == (lhs: ADViewModelItem, rhs: ADViewModelItem) -> Bool {
        return lhs.model == rhs.model
    }
    
    var model: ADModel
    
    var ADImageURL: URL? {
        return URL(string: model.ADImageUrl)
    }
}

