//
//  LocationStructs.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/27/22.
//

import Foundation



struct AreaCategory: Hashable, Decodable {
    var code: Int
    var name: String
    var prefectures: [Prefecture]
}

struct Prefecture: Hashable, Decodable {
    var code: Int
    var name: String
    var cities: [Machi]
}

struct Machi: Hashable, Decodable {
    var code: Int
    var name: String
}
