//
//  InputCreditCardInformationDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/04.
//

import SwiftUI
import Stripe
import nanopb
import CoreML
import RevenueCat
//import StripeCardScan

class InputCreditCardInformationDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var confirmNavigationTag: Int? = nil
    
    @Published var fromMenu: Bool=false
    
    @Published var cardName: String = ""{
        didSet {
            cardNameMessage = ""
        }
    }
    
    @Published var cardNumber: String = ""{
        didSet {
            cardNumberMessage = ""
        }
    }
    
    @Published var cardValidityYear: String = ""
    {
        didSet {
           // cardValidityYearMessage = ""
            cardValidityMessage = ""
        }
    }
    
    @Published var cardValidityMonth: String = ""
    {
        didSet {
         //   cardValidityMonthMessage = ""
            cardValidityMessage = ""
        }
    }
    
    @Published var securityCode: String = ""{
        didSet {
            securityCodeMessage = ""
        }
    }
    
    @Published var cardNameMessage: String = ""
    
    @Published var cardNumberMessage: String = ""
    
   // @Published var cardValidityYearMessage: String = ""
    
   // @Published var cardValidityMonthMessage: String = ""
    
    @Published var cardValidityMessage: String = ""
    
    @Published var securityCodeMessage: String = ""
    
    @Published var tooltipDialog: Bool = false
    
    @Published var tooltipTitle: String = ""
    
    @Published var tooltipDescription: String = ""
    
    @Published var showCreateCardDialog: Bool = false
    
    @Published var showDeleteCardDialog: Bool = false
    
    @Published var showCardRegisterError: Bool = false
    
    @Published var showErrorDialog:Bool = false
    
    @Published var isBindCustomer: Bool = false
    
    @Published var getCardName: String = ""
    
    @Published var getLast4: String = ""
    
    @Published var getBrand: String = ""
    
    @Published var showSaveCardStatus: Bool = false
    
    @Published var stripeErrorMessage: String = ""
    //        "number":
    //Japan (JP)    4000003920000003    Visa
    //Japan (JP)    3530111333300000    JCB
    //United States (US)    4242424242424242    Visa
    //JCB (US)   c    Any 3 digits    Any future date
    //        "exp_month": 8,
    //        "exp_year": 2023,
    //        "cvc": "314",
    //get token
    
    func reset(){
        confirmNavigationTag = nil
        navigationTag = nil
        cardName = ""
        cardNumber = ""
        cardValidityYear = ""
        cardValidityMonth = ""
        securityCode = ""
        tooltipDialog = false
        tooltipTitle = ""
        tooltipDescription = ""
        showDeleteCardDialog = false
        getBrand = ""
        getCardName = ""
        getLast4 = ""
        cardNameMessage = ""
        cardNumberMessage = ""
    //    cardValidityYearMessage = ""
    //    cardValidityMonthMessage = ""
        securityCodeMessage = ""
        cardValidityMessage = ""
    }
    
    
    
    //bind customer
    func checkCustomer(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.PAYMENT_BIND_CUSTOMER, body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then{
                
            }
            .always {
                
            }
    }
    
    func createCard(dialogsDataModel: DialogsDataModel,orderConfirmDataModel:OrderConfirmDataModel,paymentResultsDataModel:PaymentResultsDataModel,chargeDataModel:ChargeDataModel){
        //get token
        var param = STPCardParams()
        
        param.number=cardNumber.filter{$0 != " "}
        param.name=cardName
        param.cvc=securityCode
        param.expYear=UInt(cardValidityYear)!
        param.expMonth=UInt(cardValidityMonth)!
        
        self.showSaveCardStatus = true
        Stripe.STPAPIClient.shared.createToken(withCard: param){
            token,error in
            debugPrintLog(message:token)
            debugPrintLog(message:error)
            
            if(error != nil){
                DispatchQueue.main.async {
//                    paymentResultsDataModel.tag = 0
//                    self.showSaveCardStatus=false
//                        self.confirmNavigationTag = 1
                    self.showCardRegisterError = true
                    /*
                    if self.fromMenu != false{
                        dialogsDataModel.mainViewNavigationTag = nil
                        self.navigationTag = nil
                    }
                    orderConfirmDataModel.navigationTag = nil
                    self.navigationTag = nil
                    */
                    self.showSaveCardStatus = false
                     
                    
               }
            }else{
                self.saveCard(token: token!.tokenId,dialogsDataModel: dialogsDataModel,orderConfirmDataModel: orderConfirmDataModel,paymentResultsDataModel:paymentResultsDataModel,chargeDataModel:chargeDataModel)
            }
        }
    }
    
    //post token
    func saveCard(token:String,dialogsDataModel: DialogsDataModel,orderConfirmDataModel:OrderConfirmDataModel,paymentResultsDataModel:PaymentResultsDataModel,chargeDataModel:ChargeDataModel){
        let body=CreateCardBody(token: token)
        UrlUtils.postRequest(url: UrlConstants.PAYMENT_SAVE_CARD_NEW, body: body, type: CardCheckStatusResponse.self, dialogsDataModel: dialogsDataModel)
            .then{
                cardCheckStatusResponse in
                DispatchQueue.main.async {

                    if cardCheckStatusResponse!.status == true {
                        self.showCreateCardDialog = true
                        if self.fromMenu != false{
                            dialogsDataModel.mainViewNavigationTag = nil
                            self.navigationTag = nil
                        }
                        orderConfirmDataModel.navigationTag = nil
                        self.navigationTag = nil
                    }
                    else {
                        self.showCardRegisterError = true
                        if self.fromMenu != false{
                            dialogsDataModel.mainViewNavigationTag = nil
                            self.navigationTag = nil
                        }
                        orderConfirmDataModel.navigationTag = nil
                        self.navigationTag = nil
                    }
                }
            }
            .always {
                self.showSaveCardStatus=false
            }
    }
    
    
    func editCard(dialogsDataModel: DialogsDataModel,orderConfirmDataModel:OrderConfirmDataModel,paymentResultsDataModel:PaymentResultsDataModel,chargeDataModel:ChargeDataModel){
        //get token
        var param = STPCardParams()
        
        param.number=cardNumber.filter{$0 != " "}
        param.name=cardName
        param.cvc=securityCode
        param.expYear=UInt(cardValidityYear)!
        param.expMonth=UInt(cardValidityMonth)!
        
        self.showSaveCardStatus = true
        
        Stripe.STPAPIClient.shared.createToken(withCard: param){
            token,error in
            debugPrintLog(message:token)
            debugPrintLog(message:error?.localizedDescription)
            
            if(error != nil){
                DispatchQueue.main.async {
                    self.showSaveCardStatus = false
                    self.showErrorDialog = true
                    self.stripeErrorMessage = error!.localizedDescription
                }
            }else{
                        self.saveCard(token: token!.tokenId,dialogsDataModel: dialogsDataModel,orderConfirmDataModel:orderConfirmDataModel,paymentResultsDataModel:paymentResultsDataModel,chargeDataModel:chargeDataModel)
            }
        }
    }
    
    func getCardList(dialogsDataModel: DialogsDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel){
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//            // access latest customerInfo
//            if customerInfo?.entitlements["MonthlySubscription"]?.isActive == true {
//              // user has access to "your_entitlement_id"
//                let body = SubscriptionStatusBody(status: "Active")
//                
//                UrlUtils.postRequest(url: UrlConstants.PAYMENT_TOGGLE_SUBSCRIPTION, body: body, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
//                        .then {
//                            subscriptionDto in
//                            dialogsDataModel.subscriptionDto = subscriptionDto
//                        }.catch {
//                            error in
//                            debugPrintLog(message:error)
//                        }
        if ( dialogsDataModel.subscriptionDto?.status != "active" || dialogsDataModel.subscriptionDto?.status != "suspend")
        {
                UrlUtils.getRequest(url: UrlConstants.PAYMENT_GET_CARD_LIST, type:[CardResponse].self, dialogsDataModel: dialogsDataModel)
                    .then{
                        cardInformation in
                        DispatchQueue.main.async {
                            
                            if(cardInformation == nil){
                                return
                            }
                            if(cardInformation!.count > 0){
                                self.getBrand = cardInformation![0].brand
                                self.getCardName = cardInformation![0].name ?? ""
                                self.getLast4 = "**** **** **** " + cardInformation![0].last4
                                
                               if self.fromMenu == true{
                                dialogsDataModel.mainViewNavigationTag = 22
                              }
                            }else{
                                if self.fromMenu == true {
                                    self.cardName = ""
                                    self.cardNumber = ""
                                    self.cardValidityYear = ""
                                    self.cardValidityMonth = ""
                                    self.securityCode = ""
                                    self.navigationTag = nil
                                    self.confirmNavigationTag = nil
                                    dialogsDataModel.mainViewNavigationTag = 17
                                }
                            }
                        }
                    }
                
            } else {
                if self.fromMenu == true{
                    dialogsDataModel.showChargeView = true
                    hamburgerMenuDataModel.show = false
                    
//                    let body = SubscriptionStatusBody(status: "Cancel")
//                    
//                    UrlUtils.postRequest(url: UrlConstants.PAYMENT_TOGGLE_SUBSCRIPTION, body: body, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
//                            .then {
//                                subscriptionDto in
//                                dialogsDataModel.subscriptionDto = subscriptionDto
//                            }.catch {
//                                error in
//                                debugPrintLog(message:error)
//                            }
                }
            }
        
        
    }
    
    func getCardNumber(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.PAYMENT_GET_CARD_LIST, type:[CardResponse].self, dialogsDataModel: dialogsDataModel)
            .then{
                cardInformation in
                DispatchQueue.main.async {
                    
                    if(cardInformation == nil){
                        return
                    }
                    if(cardInformation!.count > 0){
                        self.getBrand = cardInformation![0].brand
                        self.getCardName = cardInformation![0].name ?? ""
                        self.getLast4 = "**** **** **** " + cardInformation![0].last4
                    }
                }
            }
    }

    //check
    func checkCardInfo(){
        var valid = true
        //-------------------------------------------
        if(cardName == "" ){
            self.cardNameMessage = "必須入力項目です"
            valid = false
        }
        //半角・英大文字、姓名の間に半角スペース
        else if(!halfWidthAndBigEng(content: cardName)){
            self.cardNameMessage = "必半角の大文字英字で姓名の間にスペースを入れて入力をお願いします"
            valid = false
        }
        
        //-------------------------------------------
        if(cardNumber == "" ){
            self.cardNumberMessage = "必須入力項目です"
            valid = false
        }
        
        else if(!halfWidthNumbers(content: cardNumber.filter{$0 != " "})){
             self.cardNumberMessage = "半角数字のみで入力をお願いします"
            valid = false
        }
        
        else if(cardNumber.filter{$0 != " "}.count > 16){
            self.cardNumberMessage = "16文字以内で入力をお願いします"
            valid = false
        }

        //-------------------------------------------
       
        if(cardValidityMonth == "" ){
           // self.cardValidityMonthMessage = "M必須入力項目です"
            self.cardValidityMessage = "必須入力項目です"
            valid = false
        }
        
        else if(!validityMonth(content: cardValidityMonth)){
         //   self.cardValidityMonthMessage = "月の有効期限をご確認下さい"
            self.cardValidityMessage = "有効期限をご確認下さい"
            valid = false
        }
        else if(cardValidityYear == "" ){
          //  self.cardValidityYearMessage = "Y必須入力項目です"
            self.cardValidityMessage = "必須入力項目です"
            valid = false
        }

        else if(!validityYearNumbers(content: cardValidityYear)){
          //  self.cardValidityYearMessage = "年の有効期限をご確認下さい"
            self.cardValidityMessage = "有効期限をご確認下さい"
            valid = false
        }
        else if(!validityYear (content: cardValidityYear )){
          //  self.cardValidityYearMessage = "年の有効期限をご確認下さい"
            self.cardValidityMessage = "有効期限をご確認下さい"
            valid = false
        }
        //-------------------------------------------
        if(securityCode == "" ){
            self.securityCodeMessage = "必須入力項目です"
            valid = false
        }
        
        else if(!halfWidthNumbers(content: securityCode)){
            self.securityCodeMessage = "半角数字のみで入力をお願いします"
            valid = false
        }
        
        else if(!checkSecurityCode(content: securityCode)){
            self.securityCodeMessage = "3桁または4桁の文字で入力をお願いします"
            valid = false
        }
        
        if valid
        {
            self.navigationTag = 1
            
        }
    }
    
    
    
        func halfWidthAndBigEng(content:String)->Bool{
            let pattern = "^[A-Za-z ]+ [A-Za-z ]+$"
            let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
            let results = regex?.matches(in: content, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: content.count))
            return results!.count > 0
        }

    func halfWidthNumbers(content:String)->Bool{
        let pattern = "^[0-9]*$"
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: content, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: content.count))
        return results!.count > 0
    }

    func validityMonth(content:String)->Bool{
        let pattern = "^0[1-9]|1[0-2]$"
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: content, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: content.count))
        return results!.count > 0
    }
    
    func validityYearNumbers(content:String)->Bool{
        let pattern = "^[0-9]{2}$"
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: content, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: content.count))
        return results!.count > 0
    }
    
    func checkSecurityCode(content:String)->Bool{
        let pattern = "^[0-9]{3,4}$"
        let regex = try?NSRegularExpression(pattern:pattern,options:.init(rawValue: 0))
        let results = regex?.matches(in: content, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: content.count))
        return results!.count > 0
    }
    
    func validityYear(content:String)->Bool{
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()
        //let year = calendar.component(.year, from: now)
        let madifiedDate=Calendar.current.date(byAdding: .year, value: 21, to: now) ?? now

        let format = DateFormatter()
        format.dateFormat = "yyyy"
        
        let year = format.string(from: madifiedDate)
        let nowYear = format.string(from: now)
        
        let content = "20\(content) "
              
        if(content < nowYear){
           return false
        }
        return content.compare(year) == .orderedAscending
    }
        
}

