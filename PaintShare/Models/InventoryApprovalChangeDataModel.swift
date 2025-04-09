//
//  InventoryApprovalChangeDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/21.
//

import SwiftUI

class InventoryApprovalChangeDataModel:ObservableObject{
    
    @Published var navigationTag: Int? = nil
    
    @Published var permit: Bool = false
    
    func changeApproveStatus(dialogsDataModel: DialogsDataModel, mainViewDataModel:MainViewDataModel) {
        let permitValue:Int = mainViewDataModel.groupApproveStatusPermit ? 1 : 0
        UrlUtils.postRequest(url: UrlConstants.GROUP_CHANGE_GROUP_APPROVE_STATUS + "/\(permitValue)", body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then {
                
            }
            .always {
                
            }
    }
}
