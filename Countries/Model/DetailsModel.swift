//
//  DetailsModel.swift
//  Countries
//
//  Created by Pratik Gavit on 25/12/22.
//

import Foundation

struct DetailsModel : Codable {
    let flags : Flags?
    let name : Name?
    let region : String?
    let subregion : String?
    let capital : [String]?
    let timezones : [String]?
    let population : Int?
    let languages : Languages?
    let currencies : Currencies?
    let car : Car?
    let coatOfArms : CoatOfArms?
    let maps : Maps?
   
    
    enum CodingKeys: String, CodingKey {
        case flags = "flags"
        case name = "name"
        case region = "region"
        case subregion = "subregion"
        case capital = "capital"
        case timezones = "timezones"
        case population = "population"
        case languages = "languages"
        case currencies = "currencies"
        case car = "car"
        case coatOfArms = "coatOfArms"
        case maps = "maps"
    
    }
    init(flags: Flags?, name: Name?, region: String?, subregion: String?, capital: [String]?, timezones: [String]?, population: Int?, languages: Languages?, currencies: Currencies?, car: Car?, coatOfArms: CoatOfArms?, maps: Maps?) {
        self.flags = flags
        self.name = name
        self.region = region
        self.subregion = subregion
        self.capital = capital
        self.timezones = timezones
        self.population = population
        self.languages = languages
        self.currencies = currencies
        self.car = car
        self.coatOfArms = coatOfArms
        self.maps = maps
    }
    
}

struct Flags : Codable {
    let png : String?
    let svg : String?

    enum CodingKeys: String, CodingKey {

        case png = "png"
        case svg = "svg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        png = try values.decodeIfPresent(String.self, forKey: .png)
        svg = try values.decodeIfPresent(String.self, forKey: .svg)
    }

}

struct Name : Codable {
    let common : String?
    let official : String?
   

    enum CodingKeys: String, CodingKey {

        case common = "common"
        case official = "official"
      
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        common = try values.decodeIfPresent(String.self, forKey: .common)
        official = try values.decodeIfPresent(String.self, forKey: .official)
       
    }

}

struct Languages : Codable {
    let eng : String?
    let smo : String?

    enum CodingKeys: String, CodingKey {

        case eng = "eng"
        case smo = "smo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eng = try values.decodeIfPresent(String.self, forKey: .eng)
        smo = try values.decodeIfPresent(String.self, forKey: .smo)
    }

}

struct Currencies : Codable {
    let uSD : USD?

    enum CodingKeys: String, CodingKey {

        case uSD = "USD"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uSD = try values.decodeIfPresent(USD.self, forKey: .uSD)
    }

}
struct USD : Codable {
    let name : String?
    let symbol : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case symbol = "symbol"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
    }

}

struct Car : Codable {
    let signs : [String]?
    let side : String?

    enum CodingKeys: String, CodingKey {

        case signs = "signs"
        case side = "side"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        signs = try values.decodeIfPresent([String].self, forKey: .signs)
        side = try values.decodeIfPresent(String.self, forKey: .side)
    }

}

struct CoatOfArms : Codable {
    let png : String?
    let svg : String?

    enum CodingKeys: String, CodingKey {

        case png = "png"
        case svg = "svg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        png = try values.decodeIfPresent(String.self, forKey: .png)
        svg = try values.decodeIfPresent(String.self, forKey: .svg)
    }

}

struct Maps : Codable {
    let googleMaps : String?
    let openStreetMaps : String?

    enum CodingKeys: String, CodingKey {

        case googleMaps = "googleMaps"
        case openStreetMaps = "openStreetMaps"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        googleMaps = try values.decodeIfPresent(String.self, forKey: .googleMaps)
        openStreetMaps = try values.decodeIfPresent(String.self, forKey: .openStreetMaps)
    }

}
