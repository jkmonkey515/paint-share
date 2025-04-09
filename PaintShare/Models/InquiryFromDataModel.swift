//
//  InquiryFromDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/15.
//

import SwiftUI

class InquiryFromDataModel:ObservableObject{
    
    @Published var description: String = ""{
        didSet {
            descriptionMessage = ""
        }
    }
    
    @Published var descriptionMessage: String = ""
    
    @Published var reportId: String = ""{
        didSet {
            reportIdMessage = ""
        }
    }
    
    @Published var reportIdMessage: String = ""
    
    //問い合わせ内容
    @Published var inquiryContent: [PickItem] = []
    
    @Published var showInquiryContentPick: Bool = false
    
    @Published var inquiryContentPickKey: Int = -1
    
    @Published var inquiryContentPickValue: String = ""{
        didSet {
            inquiryContentMessage = ""
        }
    }
    
    @Published var inquiryContentMessage: String = ""
    
    //定型文
    @Published var fixedPhrases: [PickItem] = []
    
    @Published var showFixedPhrasesPick: Bool = false
    
    @Published var fixedPhrasesValue:String = ""
    
    @Published var fixedPhrasesKey: Int = -1
    
    @Published var showSendedDialog: Bool = false
    
    @Published var addBottom: Bool = false
    
    @Published var showCoverNoti: Bool = false
    
    @State var fixedPhrasesText1: String = "ユーザー名：\n発生日時：\n（時間帯まで分かればご記載ください）\n例　2023年2月10日午後12時頃\n\n具体的な経緯：\n（具体的な経緯をご記載ください）"
    
    @State var fixedPhrasesText2: String = "発生した画面：\n（画面名をご記載ください）\n例　在庫登録\n\n発生日時：\n（時間帯まで分かればご記載ください）\n例　2023年2月10日午後12時頃\n\n具体的な経緯：\n（具体的な経緯をご記載ください）\n例　それ以前は登録できていたが突然エラーが起こり在庫登録が行えません。\n画像解析を何度行っても検索結果が出てきません。\n通知をONにしていてもアプリから通知が来ません。"
    
    init(){
        inquiryContent.append(PickItem(key: -1, value: ""))
        inquiryContent.append(PickItem(key: 0, value: "通報・苦情"))
        inquiryContent.append(PickItem(key: 1, value: "不具合"))
        inquiryContent.append(PickItem(key: 2, value: "機能要望報告"))
        inquiryContent.append(PickItem(key: 3, value: "その他"))
        
        /*
        fixedPhrases.append(PickItem(key: -1, value: ""))
        fixedPhrases.append(PickItem(key: 0, value: "エラーが起きて在庫登録が行えません。"))
        fixedPhrases.append(PickItem(key: 1, value: "画像解析を何度行っても検索結果が出てきません。"))
        fixedPhrases.append(PickItem(key: 2, value: "アプリからの通知が来ません。"))
        fixedPhrases.append(PickItem(key: 3, value: "右上のメニューバーに通知件数が表示されません。"))
         */
        fixedPhrases.append(PickItem(key: -1, value: "", valueName: ""))
        fixedPhrases.append(PickItem(key: 0, value: "「通報・苦情」の定例文", valueName: fixedPhrasesText1))
        fixedPhrases.append(PickItem(key: 1, value: "「不具合」の定例文", valueName: fixedPhrasesText2))
    }
    
    func setInquiryContentPickValue(){
        let inquiry=inquiryContent.first(where: {$0.key == inquiryContentPickKey})
        inquiryContentPickValue=inquiry?.value ?? ""
        fixedPhrases.removeAll()
        if inquiryContentPickKey == -1{
            fixedPhrases.append(PickItem(key: -1, value: "", valueName: ""))
            fixedPhrases.append(PickItem(key: 0, value: "「通報・苦情」の定例文", valueName: fixedPhrasesText1))
            fixedPhrases.append(PickItem(key: 1, value: "「不具合」の定例文", valueName: fixedPhrasesText2))
        }else if inquiryContentPickKey == 0{
            fixedPhrases.append(PickItem(key: -1, value: ""))
            fixedPhrases.append(PickItem(key: 0, value: "「通報・苦情」の定例文", valueName: fixedPhrasesText1))
        }else if inquiryContentPickKey == 1{
            fixedPhrases.append(PickItem(key: -1, value: ""))
            fixedPhrases.append(PickItem(key: 0, value: "「不具合」の定例文", valueName: fixedPhrasesText2))
        }else{
            fixedPhrases.append(PickItem(key: -1, value: ""))
        }
    }
    
    func setFixedPhrasesValue(){
        let fixedPhrase=fixedPhrases.first(where: {$0.key == fixedPhrasesKey})
       // description += fixedPhrase?.value ?? ""
       // fixedPhrasesValue = fixedPhrases?.value ?? ""
        description = fixedPhrase?.valueName ?? ""
    }
    
    func rest(){
        inquiryContentPickValue = ""
        description = ""
        reportId = ""
        inquiryContentMessage = ""
        reportIdMessage = ""
        descriptionMessage = ""
       // fixedPhrasesValue = ""
    }
    
    //記載後に活性
//    func sendDisabled() -> Bool{
//        if(inquiryContentPickValue == "" ){
//            return true
//        }
//       // if(inquiryContentPickKey == 0 ){
////            if(inquiryContentPickKey == 0 && reportId == "" ){
////            return true
////        }
//        if(description == ""){
//            return true
//        }
//        return false
//    }
    
    func sendMessage(dialogsDataModel: DialogsDataModel){
        //let body = SendMessageEmailBody(content: inquiryContentPickValue,title: description)
       // let body = SendMessageEmailBody(content: inquiryContentPickValue,title: reportId+description)
       let body = SendMessageEmailBody(content:description, reportId: reportId, title:inquiryContentPickValue)
        UrlUtils.postRequest(url:  UrlConstants.USER_SEND_REPORT_MESSAGE_MAIL, body: body, dialogsDataModel: dialogsDataModel)
            .then{
                DispatchQueue.main.async {
                    self.showSendedDialog = true
                    dialogsDataModel.mainViewNavigationTag = nil
                }
            }.catch{
               error in
                if let validationError = error as? ValidationError{
                    if let inquiryContentError = validationError.errors["title"] {
                        self.inquiryContentMessage = inquiryContentError
                    }
                    if let reportIdError = validationError.errors["reportId"]{
                        self.reportIdMessage = reportIdError
                    }
                    if let descriptionError = validationError.errors["content"]{
                        self.descriptionMessage = descriptionError
                    }
                }
            }
    }
}
