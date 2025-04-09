//
//  StringUtils.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/11/21.
//

import Foundation

class StringUtils {
    
    static func toMaskedEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        var masked: String = components[0][0]
        if components[0].count > 1 {
            masked += "****"
            masked += components[0][components[0].count - 1]
        }
        let laterComponents = components[1].components(separatedBy: ".")
        masked += "@"
        masked += laterComponents[0][0]
        masked += "****"
        masked += "."
        masked += laterComponents[laterComponents.count - 1]
        return masked
    }
}

extension StringProtocol {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
