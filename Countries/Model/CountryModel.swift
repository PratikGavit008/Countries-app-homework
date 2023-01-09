//
//  Model.swift
//  Countries
//
//  Created by Pratik Gavit on 24/12/22.
//

import Foundation

struct CountryModel:Codable {
    let name: Names?
    let capital: [String]?
    let flags:Flag?
    
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case capital = "capital"
        case flags = "flags"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(Names.self, forKey: .name)
        capital = try values.decodeIfPresent([String].self, forKey: .capital)
        flags = try values.decodeIfPresent(Flag.self, forKey: .flags)
    }
}
struct Names:Codable {
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
       
    }}



struct Flag:Codable {
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







