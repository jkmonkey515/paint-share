//
//  ChargeCancellationDataModel.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/04.
//

import SwiftUI

class ChargeCancellationDataModel: ObservableObject {
    
    @Published var navigationTag: Int? = nil
    
    @Published var subscriptionDto: SubscriptionDto?
    
    @Published var endtime: UInt64 = 0
    
    @Published var showUnsubscribeDialog: Bool = false
    
    func reset(){
        navigationTag = nil
    }
    
    func getSubscriptionEndtime(dialogsDataModel: DialogsDataModel){
        UrlUtils.getRequest(url: UrlConstants.USER_GET_LOGGED_IN_USER_SUBSCRIPTION, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
            .then{
                subscriptionDto in
                DispatchQueue.main.async {
                    self.endtime = subscriptionDto!.endAt
                    debugPrintLog(message:subscriptionDto!.endAt)
                    debugPrintLog(message:subscriptionDto!.startAt)
                }
            }
    }
    
    func cancellingSubscriptions(dialogsDataModel: DialogsDataModel){
        UrlUtils.postRequest(url: UrlConstants.PAYMENT_CANCLE_SUBSCRIPTION, body: EmptyBody(), dialogsDataModel: dialogsDataModel)
            .then{
                
                dialogsDataModel.mainViewNavigationTag = 51
            }
            .always {
                
            }
    }
}
