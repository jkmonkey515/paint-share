//
//  InquiryManagementDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/06.
//

import SwiftUI

class InquiryManagementDataModel:ObservableObject {
    @Published var navigationTag: Int? = nil
    
    @Published var chatroomDistinctListItems:[ChatroomDistinctListItem]=[]
    
    @Published var paintId: Int = -1
    
    @Published var inventoryDto:InventoryDto?
    
    @Published var selectionSwitchTab: Int? = nil

    
    func reset(){
        paintId = -1
        inventoryDto = nil
        chatroomDistinctListItems=[]
    }
    
    func getChatroomDistinctList(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_GET_DISTINCTCHATROOMLIST_BY_OWNER,type: [ChatroomDistinctDto].self,dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDistinctDtos in
                DispatchQueue.main.async {
                    var list:[ChatroomDistinctListItem]=[]
                    chatroomDistinctDtos?.forEach{
                        dto in
                        list.append(ChatroomDistinctListItem(id: self.paintId, chatroomDistinctDto:dto))
                    }
                    self.chatroomDistinctListItems = list
                }
            }
    }
}
