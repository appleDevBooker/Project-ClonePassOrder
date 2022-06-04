//
//  MenuCollectionViewModel.swift
//  Project-ClonePassOrder
//
//  Created by miori Lee on 2022/05/17.
//

import Foundation

class MenuCollectionViewModel  {

    let categoryCellData = CategoryCellData()
    let categoryArr : [CategoryModel]
    
    let defaultItemIdx : Int = 0
    
    init() {
        categoryArr = categoryCellData.getCategoryCelDummyData()
    }
    
    var numberOfCategoryArr: Int {
        return categoryArr.count
    }
    
    func getCategoryName(index: Int) -> CategoryModel {
        return categoryArr[index]
    }
}
