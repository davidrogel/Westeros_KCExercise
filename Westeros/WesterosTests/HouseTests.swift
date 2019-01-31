//
//  HouseTests.swift
//  WesterosTests
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {

    override func setUp()
    {
        
    }

    override func tearDown()
    {
        // Aqui asignaríamos los objetos a nil
    }
    
    // todo test tiene que empezar por la palabra "test"
    
    // Given - When - Then
    
    func testHouseExistance()
    {
        let stark = House(name: "Stark", sigil: Sigil(image: UIImage(), description: "Lobo Huargo"), words: "Winter is comming")
        XCTAssertNotNil(stark)
    }
    
    func testSigilExistance()
    {
        let starkSigil = Sigil(image: UIImage(), description: "Lobo Huargo")
        XCTAssertNotNil(starkSigil)
        
        let lannisterSigil = Sigil(image: UIImage(), description: "León Rampante")
        XCTAssertNotNil(lannisterSigil)
    }
}
