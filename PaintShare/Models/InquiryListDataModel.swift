//
//  InquiryListDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/20.
//

import SwiftUI

class InquiryListDataModel:ObservableObject {
    @Published var navigationTag: Int? = nil
    
    @Published var chatroomListItems:[ChatroomListItem]=[]
    
    @Published var paintId: Int = -1
    
    @Published var inventoryDto:InventoryDto?
    
    func reset(){
        paintId = -1
        inventoryDto = nil
        chatroomListItems=[]
    }
    
    func getLoginUserParticipateChatroomList(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_GET_PARTICIPANT_CHATROOM_LIST,type: [ChatroomDto].self,dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDtos in
                DispatchQueue.main.async {
                    var list:[ChatroomListItem]=[]
                    chatroomDtos?.forEach{
                        dto in
                        list.append(ChatroomListItem(id: dto.id, chatroomDto: dto))
                    }
                    self.chatroomListItems = list
                }
            }
    }
}


