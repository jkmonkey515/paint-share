//
//  CustomError.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/28/21.
//

import Foundation

struct CustomError: Error {

    var code: Int
    var description: String

    init(description: String, code: Int) {
        self.description = description
        self.code = code
    }
}

struct ValidationError: Decodable, Error {
    var errors: [String: String]
}
