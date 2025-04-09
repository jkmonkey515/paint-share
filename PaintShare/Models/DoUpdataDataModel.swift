//
//  DoUpdataDataModel.swift
//  PaintShare
//
//  Created by Lee on 2023/6/9.
//

import SwiftUI

class DoUpdataDataModel: ObservableObject {
    
    @Published var showUpdate: Bool = false
    @Published var updateText: String = ""
    
    
    func doUpdate(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.APP_VERSION_NEEDS_UPDATE + "?version=2023.9", type: UpdateResponse.self, dialogsDataModel: dialogsDataModel)
            .then{
                updateresponse in
                DispatchQueue.main.async {
                    self.showUpdate = updateresponse?.update ?? false
                    self.updateText = updateresponse?.updateText ?? ""
                }
            }
    }
}
