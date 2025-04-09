//
//  ChargeDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/05.
//

import SwiftUI
import RevenueCat

class ChargeDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var stripePriceId: String = "price_1LShzTIUXzCkBLLFEv0InBWi"
    //price_1LShzTIUXzCkBLLFEv0InBWi
    
    @Published var subscriptionDto: SubscriptionDto?
    
    @Published var showSubStatus: Bool = false
    
    @Published var showDeviceErrorModal: Bool = false
    
    @Published var showPaymentErrorModal: Bool = false
    
    @Published var showOtherErrorModal: Bool = false
    
    
    func reset(){
        navigationTag = nil
    }
    
    func purchaseSubscription(dialogsDataModel: DialogsDataModel) {
        
//        Purchases.shared.getCustomerInfo { (customerInfo, error) in
//            // access latest customerInfo
//            print("------------------------------------------------")
//            if customerInfo?.entitlements["MonthlySubscription"]?.isActive == true {
//              // user has access to "your_entitlement_id"
//                print("---in app purchase success -----------")
//                print(customerInfo?.entitlements["MonthlySubscription"]?.expirationDate)
//                print(customerInfo?.entitlements["MonthlySubscription"]?.latestPurchaseDate)
//            }
//        }
        RevenueCat.Purchases.shared.getOfferings { (offerings, error) in
            if let packages = offerings?.offering(identifier: "MonthlySubscription")?.availablePackages {
                print("---------------------------------")
                print("--------package-count: ")
                print(packages.count)
                print(packages[0].storeProduct.price)
                self.showSubStatus = true
                RevenueCat.Purchases.shared.purchase(package: packages[0]) { (transaction, customerInfo, error, userCancelled) in
                    self.showSubStatus = false
                    if customerInfo?.entitlements["MonthlySubscription"]?.isActive == true {
                    // Unlock that great "pro" content
                        print("-----success-------")
                        dialogsDataModel.showChargeView = false
                        let body = SubscriptionStatusBody(status: "active")
                        
                        UrlUtils.postRequest(url: UrlConstants.PAYMENT_TOGGLE_SUBSCRIPTION, body: body, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
                                .then {
                                    subscriptionDto in
                                    dialogsDataModel.subscriptionDto = subscriptionDto
                                }.catch {
                                    error in
                                    debugPrintLog(message:error)
                                }
                        
                    }

                    if let error = error as? RevenueCat.ErrorCode {
                        print(error.errorCode)
                        print(error.errorUserInfo)

                        switch error {
                        case .purchaseNotAllowedError:
                            print("--------Purchases not allowed on this device.")
                            self.showDeviceErrorModal = true
                            break
                        case .purchaseInvalidError:
                            print("--------Purchase invalid, check payment source.")
                            self.showPaymentErrorModal = true
                            break
                        default:
                            self.showOtherErrorModal = true
                            break
                        }
                    } else {
                        // Error is a different type
                        print("---------Default Error --------")
                        self.showOtherErrorModal = true
                    }

                }
            }
        }
         
    }
    
    func checkAndCreateSubscription(paymentResultsDataModel:PaymentResultsDataModel,dialogsDataModel: DialogsDataModel,inputCreditCardInformationDataModel:InputCreditCardInformationDataModel,orderConfirmDataModel:OrderConfirmDataModel){
        UrlUtils.getRequest(url: UrlConstants.PAYMENT_GET_CARD_LIST, type:[CardResponse].self, dialogsDataModel: dialogsDataModel)
            .then{
                cardInformation in
                DispatchQueue.main.async {
                    
                    if(cardInformation == nil){
                        return
                    }
                    if(cardInformation!.count > 0){
                        self.createSubscription(paymentResultsDataModel:paymentResultsDataModel,dialogsDataModel: dialogsDataModel)
                    }else{
                        inputCreditCardInformationDataModel.cardName = ""
                        inputCreditCardInformationDataModel.cardNumber = ""
                        inputCreditCardInformationDataModel.cardValidityYear = ""
                        inputCreditCardInformationDataModel.cardValidityMonth = ""
                        inputCreditCardInformationDataModel.securityCode = ""
                        inputCreditCardInformationDataModel.navigationTag = nil
                        inputCreditCardInformationDataModel.confirmNavigationTag = nil
                        if orderConfirmDataModel.fromMenu == true{
                            inputCreditCardInformationDataModel.fromMenu=false
                            orderConfirmDataModel.navigationTag = 1
                        }else{
                            dialogsDataModel.mainViewNavigationTag = 17
                        }
                    }
                }
            }
    }
    
    func createSubscription( paymentResultsDataModel:PaymentResultsDataModel, dialogsDataModel: DialogsDataModel){
       // let body=SubscriptionPriceBody(stripePriceId:stripePriceId)
        self.showSubStatus = true
        UrlUtils.postRequest(url: UrlConstants.PAYMENT_CREAT_SUBSCRIPTION,body: EmptyBody(),type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                subscriptionDto in
                DispatchQueue.main.async {
                    self.showSubStatus = false
                    if (subscriptionDto!.status == "active"){
                        self.subscriptionDto = subscriptionDto
                        debugPrintLog(message:subscriptionDto?.stripeSubscriptionId ?? "-1")
                        paymentResultsDataModel.tag = 1
                        
                    }else{
                        paymentResultsDataModel.tag = 0
                    }
                    dialogsDataModel.mainViewNavigationTag = 50
                }
            }
            .always {
                
            }
    }
    
}
