//
//  CafeModel.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/06/03.
//

import Foundation

struct CafeListModel: Equatable {
    var name: String
    var storyCount: Int
    var favoriteCount: Int
    var imageURL: String
    var lat: Double
    var lon: Double
    var orderTime: String
    var newTime: String
}

