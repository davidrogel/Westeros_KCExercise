//
//  House.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House
{
    // MARK: - Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    
    // MARK: - Initialization
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL)
    {
        self.name = name
        self.sigil = sigil
        self.wikiURL = wikiURL
        self.words = words
        _members = Members()
    }
}

extension House
{
    var count: Int
    {
        return _members.count
    }
    
    var sortedMembers: [Person]
    {
        return _members.sorted()
    }
    
    func add(person: Person)
    {
        //guard person.house.name == name else { return }
        guard person.house == self else { return }
        _members.insert(person)
    }
    
    // funciones variádicas
    func add(persons: Person...)
    {
        persons.forEach { add(person: $0) }
    }
}

extension House
{
    var proxyForEquality: String
    {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String
    {
        return name
    }
}

extension House : Equatable
{
    static func == (lhs: House, rhs: House) -> Bool
    {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House : Hashable
{
    var hashValue: Int
    {
        return proxyForEquality.hashValue
    }
}

extension House : Comparable
{
    static func < (lhs: House, rhs: House) -> Bool
    {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
