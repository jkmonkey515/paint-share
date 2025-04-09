//
//  SellPrecautionsDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/16.
//

import SwiftUI

class SellPrecautionsDataModel:ObservableObject{
    
    @Published var show: Bool = false
    
    @Published var checked: Bool = false{
        didSet{
            let defaults = UserDefaults.standard
            defaults.set(checked, forKey: Constants.IS_NOT_SKIP_PRECAUTIONS)
        }
    }
}
