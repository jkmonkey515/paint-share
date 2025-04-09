//
//  CreditCardManagementDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/28.
//

import SwiftUI

class CreditCardManagementDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    func reset(){
        navigationTag = nil
    }
}

