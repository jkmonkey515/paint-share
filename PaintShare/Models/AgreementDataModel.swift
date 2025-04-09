//
//  AgreementDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 7/2/21.
//

import SwiftUI

class AgreementDataModel: ObservableObject {
    
    @Published var fromRegister: Int? = nil
    
    @Published var fromRank: Int? = nil
    
    @Published var fromRequest: Int? = nil
}
