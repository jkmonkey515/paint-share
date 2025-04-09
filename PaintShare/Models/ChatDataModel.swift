//
//  ChatDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/21.
//

import SwiftUI

class ChatDataModel:ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var chatText: String = ""
    
    @Published var paintId: Int = -1
    
    @Published var shouldPresentImagePicker: Bool = false
    
    @Published var shouldPresentCamera: Bool = false
    
    @Published var shouldMappin: Bool = false
    
    @Published var showSendBankNumberDialog: Bool = false
    
    @Published var inventoryDto:InventoryDto?
    
    @Published var chatImage: UIImage? = Constants.imageHolderUIImage!{
        didSet{
            if(chatImage != Constants.imageHolderUIImage){
                subwindowTag = 1
            }
        }
    }
    
    @Published var imgKey: String?
    
    @Published var logo: UIImage? = Constants.imageHolderUIImage!
    
    @Published var chatroomDto:ChatroomDto?
    
    @Published var msgs:[MessageDto]=[]
    
    @Published var chatUserLogo:UIImage? = Constants.imageHolderUIImage!
    
    @Published var reviewDto: ReviewDto? = nil
    
    @Published var subwindowTag : Int? = nil
    
    @Published var deliveryStatu:Int = -1
    
    @Published var groupId: Int = -1
    
    @Published var fromMenu:Bool = false
    
    @Published var orderPaymentResults:Int = -1
    
   // @Published var from:ChatFrom
    
//    enum ChatFrom{
//        case inventoryInquiry
//        case orderPaymentResultsView
//    }
    
    func reset(){
        imgKey = nil
        chatUserLogo = Constants.imageHolderUIImage!
        chatText = ""
        logo = Constants.imageHolderUIImage!
        //chatType = ""
        paintId = -1
        inventoryDto = nil
        chatroomDto = nil
        showSendBankNumberDialog = false
        msgs = []
        deliveryStatu = -1
        groupId = -1 
    }
    
    func initPaintData(mainViewDataModel:MainViewDataModel,dialogsDataModel: DialogsDataModel){
        // 在庫データ 取得
        UrlUtils.getRequest(url: UrlConstants.PAINT + "/\(self.paintId)", type: InventoryDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                DispatchQueue.main.async {
                    if(result == nil){
                        return
                    }
                    self.inventoryDto = result
                }
            }
    }
    
    func getReviewDto(dialogsDataModel: DialogsDataModel) {
        if(chatroomDto == nil){
            return
        }
        UrlUtils.getRequest(url: UrlConstants.REVIEW_GET_FOR_LOGGED_IN + "?groupId=\(self.chatroomDto!.paint.ownedBy.id)", type: ReviewDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                result in
                self.reviewDto = result
            }
    }
    
    func getHeaderName(loginUserId:Int)->String{
        if(inventoryDto == nil||chatroomDto == nil){
            return ""
        }
        if(loginUserId != inventoryDto!.ownedBy.groupOwner.id){
        return inventoryDto!.ownedBy.groupOwner.lastName + " " + inventoryDto!.ownedBy.groupOwner.firstName
        }else{
            return chatroomDto!.participant.lastName + " " + chatroomDto!.participant.firstName
        }
    }
    
    func getExistingChatroom( mainViewDataModel: MainViewDataModel,paintId:Int,dialogsDataModel: DialogsDataModel,
                              chatDataModel:ChatDataModel ,inventoryInquiryDataModel:InventoryInquiryDataModel,orderConfirmDataModel:OrderConfirmDataModel?,orderWish:Bool){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_CHECK_EXIST+"?paintId="+String(paintId), type: ChatroomDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDto in
                DispatchQueue.main.async {
                    self.paintId = paintId
                    self.chatroomDto=chatroomDto
                    self.loadImg(mainViewDataModel: mainViewDataModel,dialogsDataModel: dialogsDataModel)
                    chatDataModel.getReviewDto(dialogsDataModel: dialogsDataModel)
                    if self.fromMenu == false{
                        dialogsDataModel.mainViewNavigationTag = 40
                    }else{
                    inventoryInquiryDataModel.navigationTag = 4
                    }
                    
                    if orderConfirmDataModel != nil{
                    self.sendChatMessage(mainViewDataModel: mainViewDataModel, type:0, content: "購入の申し込みをしました。\n数量：\(orderConfirmDataModel!.paintCount)。\nご確認をお願いします。", dialogsDataModel: dialogsDataModel)
                    }
                    
                    if orderWish == true{
                    self.sendChatMessage(mainViewDataModel: mainViewDataModel, type:0, content: "こちらの在庫を共有頂きたいです。\n数量：\(inventoryInquiryDataModel.wishNumber)。\nご確認をお願いします。", dialogsDataModel: dialogsDataModel)
                    }
                }
            }
    }
    
    func saveChatroom(mainViewDataModel: MainViewDataModel,type:Int,content:String,dialogsDataModel: DialogsDataModel){
        let body=ChatroomBody(paintId: paintId)
        UrlUtils.postRequest(url: UrlConstants.CHATROOM_SAVE, body:body,type: ChatroomDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                chatroomDto in
                DispatchQueue.main.async {
                    self.chatroomDto = chatroomDto
                    self.loadImg(mainViewDataModel: mainViewDataModel,dialogsDataModel: dialogsDataModel)
                    self.sendChatMessage(mainViewDataModel: mainViewDataModel,type:type,content: content,dialogsDataModel: dialogsDataModel)
                }
            }
    }
    
    // type 0:meseege 1:imag 2:coordinate
    func sendChatMessage(mainViewDataModel: MainViewDataModel,type:Int, content:String,dialogsDataModel: DialogsDataModel,needNumberCheck:Bool=true){
        if (content.trimmingCharacters(in: .whitespaces) == "" && type == 0){
            return
        }
        let trimmed=content.trimmingCharacters(in: .whitespaces)
        if(chatroomDto == nil){
            self.saveChatroom(mainViewDataModel: mainViewDataModel,type:type,content:trimmed,dialogsDataModel: dialogsDataModel)
        }else{
            //BankAccount check
            if (needNumberCheck && validatedBankAccount(type: 0, content: trimmed) && type == 0){
                self.showSendBankNumberDialog = true
                debugPrintLog(message:"BankAccount")
                
            }else{
            
            let body=SendMessageBody(chatroomId: chatroomDto!.id, readStatus: 0, text: trimmed, type: type)
            UrlUtils.postRequest(url: UrlConstants.CHATROOM_MESSAGE_SEND, body: body, dialogsDataModel: dialogsDataModel)
                .then{
                    DispatchQueue.main.async {
                        self.getChatMessageList(dialogsDataModel: dialogsDataModel)
                        if(type == 0){
                            self.chatText = ""
                        }
                        
                    }
                }
        }
        }
    }
    
    func getChatMessageList(dialogsDataModel: DialogsDataModel){
        if(chatroomDto == nil){
            return
        }
        UrlUtils.getRequest(url: UrlConstants.CHAATROOM_MESSAGE_GETLIST+"/\(chatroomDto!.id)", type: [MessageDto].self, dialogsDataModel: dialogsDataModel)
            .then{
                messageDtos in
                DispatchQueue.main.async {
                    self.msgs = messageDtos ?? []
                }
            }
    }

    //https://paintshare-dev-s3.s3.ap-northeast-1.amazonaws.com/key
    
    func sendImage(mainViewDataModel: MainViewDataModel,dialogsDataModel: DialogsDataModel){
        let imgData = self.chatImage!.jpegData(compressionQuality: 0.6)!
        self.uploadImage(mainViewDataModel: mainViewDataModel,imageData: imgData,dialogsDataModel:dialogsDataModel)
    }
    
    func uploadImage(mainViewDataModel: MainViewDataModel,imageData: Data,dialogsDataModel:DialogsDataModel) {
        let request = MultipartFormDataRequest(url: URL(string: UrlConstants.FILE_UPLOAD_IMAGE)!)
        request.addDataField(named: "file", data: imageData, mimeType: "image/jpeg")
        
        UrlUtils.imgUploadRequest(request: request, dialogsDataModel: dialogsDataModel)
            .then {
                dataString in
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        self.sendChatMessage(mainViewDataModel: mainViewDataModel,type: 1, content: dataString,dialogsDataModel:dialogsDataModel)
                    }
                }
            }
    }

   func sendAddressMapLink(mainViewDataModel: MainViewDataModel,lat: Double, lng: Double, dialogsDataModel: DialogsDataModel) {
                    let coordinate = "\(lat),\(lng)"
                    debugPrintLog(message:coordinate)
                    DispatchQueue.main.async {
                        self.sendChatMessage(mainViewDataModel: mainViewDataModel,type: 2, content: coordinate,dialogsDataModel:dialogsDataModel)
            }
    }
    
    func loadImg(mainViewDataModel:MainViewDataModel,dialogsDataModel: DialogsDataModel) {
        var imgKey:String?
        if(mainViewDataModel.loggedInUserId != chatroomDto?.participant.id){
            imgKey = chatroomDto?.participant.profileImgKey
        }else{
            imgKey=chatroomDto?.owner.profileImgKey
        }
        
        if (imgKey == nil) {
            return
        }
        UrlUtils.getData(urlString: UrlConstants.IMAGE_S3_ROOT + imgKey!) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async {
                self.chatUserLogo = UIImage(data: data)
            }
        }
    }
    
    func validatedBankAccount(type:Int, content:String)->Bool{
        let trimmed = content.replacingOccurrences(of:" ", with: "")
        let pattern = "[0-9０-９]{5,8}"
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: trimmed, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: trimmed.count))
        return results!.count > 0
       
    }
    
   // ?groupId=12&userId=86&paintId=55
    func getOrderDeliveryStatus(groupId:Int,userId:Int,paintId:Int,dialogsDataModel: DialogsDataModel){
        if(chatroomDto == nil){
            return
        }
        UrlUtils.getRequest(url: UrlConstants.ORDER_GET_CHATROOM_ORDERS+"?groupId=\(groupId)"+"&userId=\(userId)"+"&paintId=\(paintId)", type: [ChatroomOrdersDto].self, dialogsDataModel: dialogsDataModel)
            .then{
                chatroomOrdersDto in
                DispatchQueue.main.async {
//                    if(chatroomOrdersDto == nil){
//                        debugPrintLog(message:"====no order====")
//                        return
//                    }
               if chatroomOrdersDto != nil {
                    debugPrintLog(message:"++++groupId=\(groupId)-userId=\(userId)-paintId=\(paintId)++++")
                    chatroomOrdersDto!.forEach{
                        results in
                        if (results.deliveryStatus == 2){
                            self.deliveryStatu = results.deliveryStatus!
                            debugPrintLog(message:"+++\(results.deliveryStatus!)+++")
                            return
                        }
                    }
                }
            }
            }
    }
    
}
