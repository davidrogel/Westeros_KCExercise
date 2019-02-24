//
//  EpisodeTest.swift
//  WesterosTests
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import XCTest

@testable import Westeros

class SeasonTest: XCTestCase
{
    var season: Season!
    
    override func setUp()
    {
        season = Season(name: "Primera Temprada", releaseDate: Date())
    }

    override func tearDown()
    {
        
    }
    
    func testSeasonExistance()
    {
        XCTAssertNotNil(season)
    }
    
    func testSeasonCustomStringConvertible()
    {
        XCTAssertNotEqual(season.description, "")
    }
    
    func testSeasonEquality()
    {
        XCTAssertEqual(season, season)
        
        let season1 = Season(name: "Segunda Temporada", releaseDate: Date())
        
        XCTAssertNotEqual(season, season1)
    }
    
    func testSeasonHashable()
    {
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeasonComparison()
    {
        let season1 = Season(name: "Segunda Temporada", releaseDate: Date(timeIntervalSince1970: 200.0))
        
        XCTAssertLessThan(season1, season)
    }
    
//    func testSeasonAddEpisode()
//    {
//        let episode = Episode(title: "Primer Episodio", releaseDate: Date(), season: season)
//        //season.add(episode: episode)
//        #warning("añadir episodes a seasons a ver que pasa")
//    }
}
