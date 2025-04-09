//
//  MapSearchDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/6.
//

import SwiftUI

class MapSearchDataModel:ObservableObject{
    
    // search
    @Published var searchPhrase: String = ""
    
    @Published var adressPhrase: String = ""
    
    @Published var selectionSwitchTab: Int = 0
}
