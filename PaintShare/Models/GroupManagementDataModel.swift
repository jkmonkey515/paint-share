//
//  GroupManagementDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/7/21.
//

import SwiftUI

class GroupManagementDataModel: ObservableObject {
    @Published var selectedTab: Int = 0
    
    func reset() {
        selectedTab = 0
    }
}
