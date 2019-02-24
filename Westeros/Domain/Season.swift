//
//  Season.swift
//  Westeros
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

class Season
{
    var name: String
    var releaseDate: Date
    private var episodes: Episodes
    
    init(name: String, releaseDate: Date)
    {
        self.name = name
        self.releaseDate = releaseDate
        episodes = Episodes()
    }
}

extension Season
{
    var count: Int
    {
        return episodes.count
    }
    
    var sortedEpisodes: [Episode]
    {
        return episodes.sorted()
    }
    
    func add(episode: Episode)
    {
        guard episode.parent == self else { return }
        episodes.insert(episode)
    }
    
    func add(episodes: Episode...)
    {
        episodes.forEach({ add(episode: $0) })
    }
}

extension Season
{
    var proxyForEquality: String
    {
        return "\(name)"
    }
    
    var proxyForComparison: String
    {
        return releaseDate.description
    }
}

extension Season : CustomStringConvertible
{
    var description: String
    {
        return "Season \(name) released at \(releaseDate.description), has \(episodes.count) Episodes"
    }
}

extension Season : Equatable
{
    static func == (lhs: Season, rhs: Season) -> Bool
    {
        return lhs.name.uppercased() == rhs.name.uppercased()
    }
}

extension Season : Hashable
{
    var hashValue: Int
    {
        return proxyForEquality.hashValue
    }
}

extension Season : Comparable
{
    static func < (lhs: Season, rhs: Season) -> Bool
    {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

/*
 CustomStringConvertible
 Equatable
 Hashable
 Comparable
 
 */
