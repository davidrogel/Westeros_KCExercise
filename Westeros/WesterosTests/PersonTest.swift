//
//  CharacterTest.swift
//  WesterosTests
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTest: XCTestCase
{
    // como podemos crear variables sin inicializar?
    // 1 - le damos un valor por defecto
    // 2 - La creo de tipo opcional, para que pueda ser nil
    var starkHouse: House!
    var starkSigil: Sigil!
    var ned: Person!
    
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Logo Huargo")
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is comming")
        ned = Person(name: "Eddard", fullName: "Eddard Stark", alias: "Ned", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterExistence()
    {
        XCTAssertNotNil(ned)
    }
    
    // añadir una propiedad full name
    
    func testPersonHasFullName()
    {
        XCTAssertEqual(ned.fullName, "Eddard Stark")
    }
}
