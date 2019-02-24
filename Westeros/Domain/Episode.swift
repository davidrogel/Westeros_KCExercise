//
//  Episode.swift
//  Westeros
//
//  Created by david rogel pernas on 23/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import Foundation

class Episode
{
    let title: String
    let releaseDate: Date
    weak var parent: Season?
    
    init(title: String, releaseDate: Date, season: Season)
    {
        self.title = title
        self.releaseDate = releaseDate
        self.parent = season
    }
}

extension Episode
{
    var proxyForEquality: String
    {
        return "\(title)"
    }
    
    var proxyForComparison: String
    {
        return releaseDate.description
    }
}


extension Episode : Equatable
{
    static func == (lhs: Episode, rhs: Episode) -> Bool
    {
        return lhs.title.uppercased() == rhs.title.uppercased()
    }
}

extension Episode : Hashable
{
    var hashValue: Int
    {
        return proxyForEquality.hashValue
    }
}

extension Episode : CustomStringConvertible
{
    var description: String
    {
        return "Episode \(title) released at \(releaseDate.description)"
    }
}

extension Episode : Comparable
{
    static func < (lhs: Episode, rhs: Episode) -> Bool
    {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

