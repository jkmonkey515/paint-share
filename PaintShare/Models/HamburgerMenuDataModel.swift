//
//  HamburgerMenuDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/26.
//

import SwiftUI

class HamburgerMenuDataModel:ObservableObject{
    
    @Published var show: Bool = false
    
    @Published var ownerUnreadMessage: Int = 0
    
    @Published var userUnreadMessage: Int = 0
    
    //@Published var UnreadMessage: Int = 0
    
    @Published var free: Bool = false
    
    func reset() {
        ownerUnreadMessage = 0
        userUnreadMessage = 0
        free = false
       // UnreadMessage = 0
    }
    
    func getOwnerUnreadMessage(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_GET_DISTINCTCHATROOMLIST_BY_OWNER,type: [ChatroomDistinctDto].self,dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDistinctDtos in
                DispatchQueue.main.async {
                  //  dialogsDataModel.UnreadMessage = 0
                    if  chatroomDistinctDtos != nil{
                        chatroomDistinctDtos!.forEach{
                            results in
                            if (results.readStatus != 1){
                                self.ownerUnreadMessage = 1
                                dialogsDataModel.UnreadMessage = 1
                                debugPrintLog(message:"+++OwnerUnreadMessage+++")
                                return
                            }
                    }
                }
            }
            }
    }
    
    func getUserUnreadMessage(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_GET_PARTICIPANT_CHATROOM_LIST,type: [ChatroomDto].self,dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDtos in
                DispatchQueue.main.async {
                    if  chatroomDtos != nil{
                        chatroomDtos!.forEach{
                            results in
                            if (results.unreadMessageCount != 0){
                                self.userUnreadMessage = 1
                                dialogsDataModel.UnreadMessage = 1
                                debugPrintLog(message:"+++getUserUnreadMessage+++")
                                return
                            }
                    }
                }
                }
            }
    }
    
    func checkSubscription(dialogsDataModel: DialogsDataModel){
            let mytime = Date()
            let format = DateFormatter()
            format.dateFormat = "yyyy年MM月dd日"
            let now = format.string(from: mytime)
            let freeUseUntil = DateTimeUtils.timestampToStrFormat(timestamp: dialogsDataModel.freeUseUntil)
            if(now.compare(freeUseUntil) == .orderedDescending){
                self.free = false
            }else{
                self.free = true
            }
        
    }
    
}
