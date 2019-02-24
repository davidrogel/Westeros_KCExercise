//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by david rogel pernas on 06/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import XCTest

@testable import Westeros

class RepositoryTests: XCTestCase
{
    var houses: [House]!
    
    override func setUp()
    {
        houses = Repository.local.houses
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence()
    {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHouseExistance()
    {
        XCTAssertNotNil(houses)
    }

    func testLocalRepositoryHouseCount()
    {
        XCTAssertEqual(houses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses()
    {
        XCTAssertEqual(houses, houses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively()
    {
        let stark = Repository.local.house(named: "sTaRk")
        XCTAssertNotNil(stark)
        XCTAssertEqual(stark!.name, "Stark")
    }
    
    // given-when-then
    func testLocalFactory_HousesFilteredBy_ReturnsTheCorrectValue()
    {
        // devuelveme todas las cosas que solo tengan un miembro
//        let filtered = Repository.local.houses {
//            $0.count == 1
//        }
        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })

        XCTAssertEqual(filtered.count, 1)
    }
    
    func testLocalRepository_SeasonsFilteredBy_ReturnsTheCorrectValue()
    {
        // miramos a ver cuantas tienen 2 capitulos
        let filtered = Repository.local.seasons(filteredBy: {$0.count == 2 })
        
        // que en este caso son 7 (todas)
        XCTAssertEqual(filtered.count, 7)
        
    }
}
