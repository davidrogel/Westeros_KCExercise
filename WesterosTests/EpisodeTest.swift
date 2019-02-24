//
//  EpisodeTest.swift
//  WesterosTests
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import XCTest

@testable import Westeros

class EpisodeTest: XCTestCase
{
    var episode: Episode!
    var season: Season!
    
    override func setUp()
    {
        season = Season(name: "Primera Temprada", releaseDate: Date())
        episode = Episode(title: "Primer episodio", releaseDate: Date(), season: season)
    }

    override func tearDown()
    {
        
    }
    
    func testEpisodeExistance()
    {
        XCTAssertNotNil(episode)
    }
    
    func testEpisodeCustomStringConvertible()
    {
        XCTAssertNotEqual(episode.description, "")
    }
    
    func testEpisodeEquality()
    {
        XCTAssertEqual(episode, episode)
        
        let episode1 = Episode(title: "Segundo Episodio", releaseDate: Date(), season: season)
        
        XCTAssertNotEqual(episode, episode1)
    }
    
    func testEpisodeHashable()
    {
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisodeComparison()
    {
        let episode1 = Episode(title: "Segundo Episodio", releaseDate: Date(timeIntervalSince1970: 200.0), season: season)
        
        XCTAssertLessThan(episode1, episode)
    }

}
