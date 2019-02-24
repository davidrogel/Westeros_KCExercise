//
//  Person.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

final class Person
{
    // MARK: - Properties
    let name: String
    //let fullName: String
    private let _alias: String?
    let house: House
    
    // Variable computada
    var alias: String
    {
        // Las propiedades computadas cuando solo tienen un getter no hace falta poner el get { ... }
//        get
//        {
            // Con if-let
//            if let alias = _alias
//            {
//                return alias
//            }
//            else
//            {
//                return ""
//            }
            // Con guard
//            guard let alias = _alias else {
//                return ""
//            }
//
//            return alias
            
            return _alias ?? "" // operador ternario, aunque se parece más al value || 0 de Javascript
//        }
    }
    
    // MARK: - Initialization
    init(name: String, alias: String? = nil, house: House)
    {
        self.name     = name
        //self.fullName = fullName
             _alias   = alias
        self.house    = house
    }
    
    // los convenience inits tiene que llamar a self.init (el designado)
//    convenience init(name: String, house: House)
//    {
//        self.init(name: name, alias: nil, house: house)
//    }
    
}

extension Person
{
    var fullName: String
    {
        return "\(name) \(house.name)"
    }
}

extension Person
{
    // un proxy es algo que hace un trabajo sucio que no quieres hacer tu ahora
    var proxyForEquality : String
    {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison : String
    {
        return fullName
    }
}

extension Person : Hashable
{
    var hashValue: Int
    {
        return proxyForEquality.hashValue
    }
}

extension Person : Equatable
{
    static func == (lhs: Person, rhs: Person) -> Bool
    {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person : Comparable
{
    static func < (lhs: Person, rhs: Person) -> Bool
    {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
