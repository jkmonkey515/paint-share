//
//  ViewExtension.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var isFloat: Bool {
        return Float(self) != nil
    }
    
    var isDouble: Bool {
        return Double(self) != nil
    }
    
    var isUInt: Bool   {
        return UInt(self) != nil
    }
}

