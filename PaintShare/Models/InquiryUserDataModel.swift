//
//  InquiryUserDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/08.
//

import SwiftUI

class InquiryUserDataModel: ObservableObject {
    @Published var navigationTag: Int? = nil
    
    @Published var chatroomUsersListItems:[ChatroomUsersListItem]=[]
    
    @Published var paintId: Int = -1
    
    @Published var inventoryDto:InventoryDto?
    
    // @Published var logo: UIImage? = Constants.imageHolderUIImage!
    @Published var imgKey: String?
    
    func reset(){
        // logo = Constants.imageHolderUIImage!
        imgKey = nil
        paintId = -1
        inventoryDto = nil
        chatroomUsersListItems=[]
    }
        
    func getOwnerChatroomList(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_GET_DISTINCTCHATROOM_GROUPBY_CHATROOMLIST+"/\(paintId)",type: [ChatroomDto].self,dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDtos in
                DispatchQueue.main.async {
                    var list:[ChatroomUsersListItem]=[]
                    chatroomDtos?.forEach{
                        dto in
                        list.append(ChatroomUsersListItem(id: dto.id, chatroomDto: dto))
                    }
                    self.chatroomUsersListItems = list
                }
            }
    }

}
