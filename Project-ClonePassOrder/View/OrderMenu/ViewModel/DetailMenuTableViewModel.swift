//
//  DetailMenuTableViewModel.swift
//  Project-ClonePassOrder
//
//  Created by miori Lee on 2022/05/18.
//

import Foundation

class DetailMenuTableViewModel {
    
    let categoryCellData = CategoryCellData()
    let categoryArr : [CategoryModel]
    
    init() {
        categoryArr = categoryCellData.getCategoryCelDummyData()
    }
    
    var numberOfCategoryArrForHeader: Int {
        return categoryArr.count
    }
    
    func getCategoryName(index: Int) -> CategoryModel {
        return categoryArr[index]
    }
}
