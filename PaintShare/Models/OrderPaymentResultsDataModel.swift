//
//  OrderPaymentResultsDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/30.
//

import SwiftUI

class OrderPaymentResultsDataModel:ObservableObject{
    
    @Published var from: Int = 0
    
    @Published var result: Int = 0
    
    @Published var navigationTag: Int? = nil
        
    func reset() {
        navigationTag = nil
    }
}
