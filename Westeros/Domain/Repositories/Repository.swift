//
//  Repository.swift
//  Westeros
//
//  Created by david rogel pernas on 06/02/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

final class Repository
{
    static let local = LocalFactory()
}

protocol HouseFactory
{
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get } // será de solo lectura
    func house(named: String) -> House?
    // a esta funcion le vamos a pasar un filtro que es una funcion que pide una casa y devuelve un boolean
    func houses(filteredBy filter: HouseFilter) -> [House]
}

protocol SeasonFactory
{
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    func seasons(filteredBy filter: SeasonFilter) -> [Season]
}

final class LocalFactory : HouseFactory
{
    var houses: [House]
    {
        // creación de las casas
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!, description: "León Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragon tricéfalo")
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "El Invierno se acerca", wikiURL: starkURL)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", wikiURL: lannisterURL)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", wikiURL: targaryenURL)
        
        // añadir algunos personajes
        let robb = Person(name: "Robb", alias: "El jovel lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "Mata Reyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        starkHouse.add(persons: robb, arya)
        lannisterHouse.add(persons: tyrion, cersei, jaime)
        targaryenHouse.add(person: dani)
        
        return [lannisterHouse, starkHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House?
    {
//        let house = houses.filter { $0.name == name }.first
        let house = houses.first{ $0.name.uppercased() == name.uppercased()} // AZUCAAAR
        return house
    }
    
    func houses(filteredBy theGodFilter: HouseFilter) -> [House]
    {
        return houses.filter(theGodFilter)
    }
}

extension LocalFactory : SeasonFactory
{
    var seasons: [Season]
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let season1 = Season(name: "Season 1", releaseDate: dateFormatter.date(from: "2011/04/17")!)
        let season2 = Season(name: "Season 2", releaseDate: dateFormatter.date(from: "2012/04/01")!)
        let season3 = Season(name: "Season 3", releaseDate: dateFormatter.date(from: "2013/03/31")!)
        let season4 = Season(name: "Season 4", releaseDate: dateFormatter.date(from: "2014/04/06")!)
        let season5 = Season(name: "Season 5", releaseDate: dateFormatter.date(from: "2015/04/12")!)
        let season6 = Season(name: "Season 6", releaseDate: dateFormatter.date(from: "2016/04/24")!)
        let season7 = Season(name: "Season 7", releaseDate: dateFormatter.date(from: "2017/07/16")!)
        
        let episode11 = Episode(title: "Winter Is Coming", releaseDate: dateFormatter.date(from: "2011/04/17")!, season: season1)
        let episode21 = Episode(title: "The Kingsroad", releaseDate: dateFormatter.date(from: "2011/04/24")!, season: season1)
        
        let episode12 = Episode(title: "The North Remembers", releaseDate: dateFormatter.date(from: "2012/04/01")!, season: season2)
        let episode22 = Episode(title: "The Night Lands", releaseDate: dateFormatter.date(from: "2012/04/08")!, season: season2)
        
        let episode13 = Episode(title: "Valar Dohaeris", releaseDate: dateFormatter.date(from: "2013/03/31")!, season: season3)
        let episode23 = Episode(title: "Dark Wings, Dark Words", releaseDate: dateFormatter.date(from: "2013/04/07")!, season: season3)
        
        let episode14 = Episode(title: "Two Swords", releaseDate: dateFormatter.date(from: "2014/04/06")!, season: season4)
        let episode24 = Episode(title: "The Lion and the Rose", releaseDate: dateFormatter.date(from: "2014/04/13")!, season: season4)
        
        let episode15 = Episode(title: "The Wars To Come", releaseDate: dateFormatter.date(from: "2015/04/12")!, season: season5)
        let episode25 = Episode(title: "The House of Black and White", releaseDate: dateFormatter.date(from: "2015/04/19")!, season: season5)
        
        let episode16 = Episode(title: "The Red Woman", releaseDate: dateFormatter.date(from: "2016/04/24")!, season: season6)
        let episode26 = Episode(title: "Home", releaseDate: dateFormatter.date(from: "2016/05/01")!, season: season6)
        
        let episode17 = Episode(title: "Dragonstone", releaseDate: dateFormatter.date(from: "2017/07/16")!, season: season7)
        let episode27 = Episode(title: "Stormborn", releaseDate: dateFormatter.date(from: "2017/07/23")!, season: season7)
        
        season1.add(episodes: episode11, episode21)
        season2.add(episodes: episode12, episode22)
        season3.add(episodes: episode13, episode23)
        season4.add(episodes: episode14, episode24)
        season5.add(episodes: episode15, episode25)
        season6.add(episodes: episode16, episode26)
        season7.add(episodes: episode17, episode27)
        
        return [season1, season2, season3, season4, season5, season6, season7].sorted()
    }
    
    func seasons(filteredBy theGodFilter: SeasonFilter) -> [Season]
    {
        return seasons.filter(theGodFilter)
    }
}
