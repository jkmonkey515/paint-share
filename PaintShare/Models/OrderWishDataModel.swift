//
//  OrderWishDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/12/26.
//

import SwiftUI

class OrderWishDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
        
    func reset() {
        navigationTag = nil
    }
}
