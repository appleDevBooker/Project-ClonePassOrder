//
//  CafeUnitTest.swift
//  UnitTest
//
//  Created by 정덕호 on 2022/06/03.
//

import XCTest
import CoreLocation

class CafeListUnitTest: XCTestCase {
    
    var coordinate2D: CLLocationCoordinate2D!
    var coordinate: CLLocation!
    var sut: CafeListViewModel!
    var model: CafeModel!
    var item: CafeViewModelItem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coordinate2D = CLLocationCoordinate2D(latitude: 127.1111, longitude: 37.1111)
        coordinate = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        sut = CafeListViewModel(corrdinate: coordinate2D)
        model = CafeModel(
            name: "메가커피",
            address: "동두천시",
            storyCount: 1,
            favoriteCount: 5,
            imageURL: "imageurl",
            info: "메가커피입니다",
            lat: 127.1234,
            lon: 37.1234,
            offDay: "월요일",
            openTime: "11시~22시",
            orderTime: "10분후가능",
            phoneNumber: "010-1234-1234",
            benefit: "10번 구매시 2,000원 할인쿠폰 적립",
            newTime: "신규매장"
        )
        item = CafeViewModelItem(model: model, userCoordinate: coordinate)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        coordinate2D = nil
        coordinate = nil
        sut = nil
        model = nil
        item = nil
    }
    
    func test_cafeModel이_cafeViewModelItem에_원하는값으로_담기는지() {
        //given
        let cafeCorrdinate = CLLocation(latitude: model.lat, longitude: model.lon)
        let distance = Int(coordinate.distance(from: cafeCorrdinate))
        var dictanceString: String {
            if Int(distance) < 1000 {
                return  "\(Int(distance))m"
            } else {
                return String(format: "%.2f", Double(distance) / 1000) + "km"
            }
        }
        
        //then
        XCTAssertEqual(item.name, model.name)
        XCTAssertEqual(item.address, model.address )
        XCTAssertEqual(item.storyCount, model.storyCount)
        XCTAssertEqual(item.favoriteCount, model.favoriteCount)
        XCTAssertEqual(item.cafeImageURL, URL(string: model.imageURL))
        XCTAssertEqual(item.info, model.info)
        XCTAssertEqual(item.offDay, model.offDay)
        XCTAssertEqual(item.openTime, model.openTime)
        XCTAssertEqual(item.orderTime, model.orderTime)
        XCTAssertEqual(item.phoneNumber, model.phoneNumber)
        XCTAssertEqual(item.benefit,model.benefit )
        XCTAssertEqual(item.newTime, model.newTime)
        XCTAssertEqual(item.distance, distance)
        XCTAssertEqual(item.distanceString, dictanceString)
    }
    func test_count호출시_items의_count를_리턴하는지() {
        //given
        let items = [
            CafeViewModelItem(model: model, userCoordinate: coordinate),
            CafeViewModelItem(model: model, userCoordinate: coordinate)
        ]
        sut.items.value = items
        
        //when
        let valid = sut.count()
        
        //then
        XCTAssertEqual(valid, items.count)
    }
    func test_orderNearStore호출시_items가_distance가_낮은순으로_정렬이된배열로_반환되는지() {
    }
    

    
   

}
