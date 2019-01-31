//
//  House.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import Foundation

typealias Words = String

final class House
{
    let name: String
    let sigil: Sigil
    let words: Words
    
    init(name: String, sigil: Sigil, words: Words)
    {
        self.name = name
        self.sigil = sigil
        self.words = words
    }
}
