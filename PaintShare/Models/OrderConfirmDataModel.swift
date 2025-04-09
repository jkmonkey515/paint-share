//
//  OrderConfirmDataModel.swift
//  PaintShare
//
//  Created by Lee on 2022/6/30.
//

import SwiftUI

class OrderConfirmDataModel: ObservableObject {
    
    @Published var orderConfirmValue: String = ""
    
    @Published var paintNumber: String = ""{
        didSet{
            if paintNumber.isInt {
                paintCount = Int(paintNumber) ?? 0
            }
        }
    }
    
    @Published var paintCount: Int = 0
    
    @Published var payLock: Bool = false
    
    @Published var showPayNoti: Bool = false
    
    @Published var showConfirmNoti: Bool = false
    
    @Published var confirmNumber: String = "1"
    
    @Published var confirmNumberInteger: Int = 1
    
    @Published var confirmNumberDecimal: Int = 0
    
    @Published var showConfirmModal: Bool = false
    
    @Published var showConfirmPicker: Bool = false
    
    @Published var free: Bool = false

    @Published var navigationTag: Int? = nil
    
    @Published var getCardName: String = ""
    
    @Published var getLast4: String = ""
    
    @Published var getBrand: String = ""
    
    @Published var fromMenu:Bool = false
    
    func reset() {
        navigationTag = nil
        confirmNumber = "1.0"
        confirmNumberInteger = 1
        confirmNumberDecimal = 0
        paintNumber = ""
        paintCount = 0
    }
    
    func confirm(totalAmount: Int, number: String, paintId: Int, dialogsDataModel: DialogsDataModel){
        if !confirmNumber.isInt && !confirmNumber.isDouble{
            dialogsDataModel.showNumberOnlyDialog = true
            return
        }
        if totalAmount == 0{
            showPayNoti = true
            return
        }
        payLock = true
        let body = OrderConfirmBody(number: number, paintId: paintId)
        UrlUtils.postRequest(url:  UrlConstants.ORDER_SAVE_ORDER, body: body, type: OrderPaymentDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                orderPaymentDto in
                DispatchQueue.main.async {
                    self.payLock = false
                    /*
                    self.payTheOrder(totalAmount: totalAmount, orderId: orderDto!.id, dialogsDataModel: dialogsDataModel)
                     */
                    self.payLock = false
                    dialogsDataModel.orderPayResult = 1
                    if self.fromMenu == false{
                    dialogsDataModel.mainViewNavigationTag = 60
                    }else{
                        self.navigationTag = 3
                    }
                }
            }
    }
    
    func payTheOrder(totalAmount: Int, orderId: Int, dialogsDataModel: DialogsDataModel){
        payLock = true
        let body = OrderPaymentBody(orderId: orderId, totalAmount: totalAmount)
        UrlUtils.postRequest(url:  UrlConstants.PAYMENT_CREATE_ORDER_PAYMENT, body: body, type: OrderPaymentDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                orderPaymentDto in
                DispatchQueue.main.async {
                    self.payLock = false
                    dialogsDataModel.orderPayResult = 1
                    if self.fromMenu == false{
                    dialogsDataModel.mainViewNavigationTag = 60
                    }else{
                        self.navigationTag = 3
                    }
                }
            }
    }
    
    func free(dialogsDataModel: DialogsDataModel){
        let mytime = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        let now = format.string(from: mytime)
        let freeUseUntil = DateTimeUtils.timestampToStrFormat(timestamp: dialogsDataModel.freeUseUntil)
        if(now.compare(freeUseUntil) == .orderedDescending){
            free = false
        }else{
            free = true
        }
        print(dialogsDataModel.subscriptionDto?.status)
    }
    
    func getCardList(dialogsDataModel: DialogsDataModel){
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
                        self.getLast4 = cardInformation![0].last4
                        
                        self.navigationTag = 2
                    }else{
                        self.navigationTag = 1
                    }
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
                        self.getLast4 = cardInformation![0].last4
                    }
                }
            }
    }
}
