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
    var arya: Person!
    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "Logo Huargo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is comming", wikiURL: starkURL)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
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
    
    // given - when - then
    func testPersonHashable()
    {
        XCTAssertNotNil(ned.hashValue)
    }
    
    func testPersonEquality()
    {
        // Comprobar la Identidad
        XCTAssertEqual(ned, ned)
        
        // La Igualdad
        let eddard = Person(name: "Eddard", alias: "Ned", house: starkHouse)
        XCTAssertEqual(eddard, ned)
        
        // La Desigualdad
        XCTAssertNotEqual(ned, arya)
    }
}
