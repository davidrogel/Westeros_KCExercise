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

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var robb: Person!
    var arya: Person!
    var tyrion: Person!
    
    override func setUp()
    {
        starkSigil = Sigil(image: UIImage(), description: "Logo Huargo")
        lannisterSigil = Sigil(image: UIImage(), description: "León Rampante")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        
        robb = Person(name: "Robb", alias: "El jovel lobo", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
    }

    override func tearDown()
    {
        // Aqui asignaríamos los objetos a nil
    }
    
    // todo test tiene que empezar por la palabra "test"
    
    // Given - When - Then
    
    func testHouseExistance()
    {
        XCTAssertNotNil(starkHouse)
    }
    
    func testSigilExistance()
    {
        XCTAssertNotNil(starkSigil)
        XCTAssertNotNil(lannisterSigil)
    }
    
    func testHouseAddPersons()
    {
        XCTAssertEqual(starkHouse.count, 0)
        starkHouse.add(person: robb)
        
        XCTAssertEqual(starkHouse.count, 1)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
        
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseAddPersonAtOnce()
    {
        starkHouse.add(persons: robb, arya, tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseEquality()
    {
        // Identidad
        XCTAssertEqual(starkHouse, starkHouse)
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        
        // Igualdad
        let jinxed = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", wikiURL: starkURL)
        XCTAssertEqual(starkHouse, jinxed)
        
        // Desigualdad
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseHashable()
    {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseComparison()
    {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
    
    func testHouse_SortedMembers_ReturnsAnArrayOfSortedMembers()
    {
        XCTAssertEqual(starkHouse.sortedMembers, starkHouse.sortedMembers.sorted())
    }
}
