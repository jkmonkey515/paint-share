//
//  CommonMacroDefinition.swift
//  PaintShare
//
//  Created by Lee on 2023/2/23.
//

import UIKit

func debugPrintLog<T>(message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    let name = (file as NSString).lastPathComponent
    let fileArray = name.components(separatedBy: ".")
    let fileName = fileArray[0]
    print("[\(fileName) \(funcName)](\(lineNum)): \(message)")
    #elseif RELEASE
    #else
    #endif
}
