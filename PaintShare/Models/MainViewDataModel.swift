//
//  MainViewDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/28/21.
//

import SwiftUI
import RevenueCat

class MainViewDataModel: ObservableObject {
    
    var dialogsDataModel: DialogsDataModel?
    
    @Published var loggedInUserId: Int? = nil
    
    @Published var loggedInUserGroup: GroupDto? = nil
    
    @Published var selectedTab: Int = 0 {
        didSet {
            if (selectedTab != 3 && tabDisabled) {
                selectedTab = 3
                showAccountNotFinishedDialog = true
            }
            if (selectedTab == 2 && !tabDisabled) {
                getOwnedAndJoinGroupList(dialogsDataModel: dialogsDataModel!)
            }
            if (selectedTab == 4 && !tabDisabled) {
                getOwnedAndJoinGroupList(dialogsDataModel: dialogsDataModel!)
            }
        }
    }
    
    @Published var tabDisabled: Bool = false
    
    @Published var showAccountNotFinishedDialog: Bool = false
    
    @Published var showNoGroupDialog: Bool = false
    
    @Published var showNoGroupDialogMessage: String = ""
    
    // 共通エラーメッセージ
    @Published var showErrorDialog: Bool = false
    
    @Published var errorMsg: String = ""
    
    @Published var groupApproveStatusPermit: Bool = false
    
    func reset() {
        loggedInUserId = nil
        loggedInUserGroup = nil
        selectedTab = 0
        tabDisabled = false
        showAccountNotFinishedDialog = false
        showErrorDialog = false
        errorMsg = ""
        showNoGroupDialog = false
    }
    
    func getLoggedInUserGroup(dialogsDataModel: DialogsDataModel) {
        UrlUtils.getRequest(url: UrlConstants.GROUP_GET_LOGGED_IN_USER_GROUP, type: GroupDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                groupDto in
                DispatchQueue.main.async {
                    self.loggedInUserGroup = groupDto
                    debugPrintLog(message:"等待开始")
                    if self.loggedInUserGroup?.groupApproveStatus == 1{
                        self.groupApproveStatusPermit = true
                    }else{
                        self.groupApproveStatusPermit = false
                    }
                }
            }
    }
    
    func getLoggedInUserUnreadMessage(dialogsDataModel: DialogsDataModel,hamburgerMenuDataModel:HamburgerMenuDataModel) {
        UrlUtils.getRequest(url: UrlConstants.GROUP_GET_LOGGED_IN_USER_GROUP, type: GroupDto.self, dialogsDataModel: dialogsDataModel)
            .then {
                groupDto in
                DispatchQueue.main.async {
                    self.loggedInUserGroup = groupDto
                    if self.loggedInUserGroup?.groupApproveStatus == 1{
                        hamburgerMenuDataModel.getOwnerUnreadMessage(dialogsDataModel: dialogsDataModel)
                       
                    }else{
                      return
                    }
                }
            }
    }
    
    func checkSubscriptionStatus(dialogsDataModel: DialogsDataModel)
    {
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            // access latest customerInfo
            if customerInfo?.entitlements["MonthlySubscription"]?.isActive == true {
              // user has access to "your_entitlement_id"
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
            
            } else {
                let body = SubscriptionStatusBody(status: "canceled")
                
                UrlUtils.postRequest(url: UrlConstants.PAYMENT_TOGGLE_SUBSCRIPTION, body: body, type: SubscriptionDto.self, dialogsDataModel: dialogsDataModel)
                        .then {
                            subscriptionDto in
                            dialogsDataModel.subscriptionDto = subscriptionDto
                        }.catch {
                            error in
                            debugPrintLog(message:error)
                        }
            }
        }
    }
    
    func getOwnedAndJoinGroupList(dialogsDataModel: DialogsDataModel){
        // 所属グループ
        UrlUtils.getRequest(url: UrlConstants.PAINT_GET_GROUP_LIST, type: [GroupDto].self, dialogsDataModel: dialogsDataModel)
            .then {
                groupDtoList in
                DispatchQueue.main.async {
                    if (groupDtoList?.count == 0 && !self.tabDisabled){
                        self.showNoGroupDialog = true
                        self.showNoGroupDialogMessage = self.selectedTab == 2 ? "所属グループが無いため在庫登録はできません" : "グループを検索して参加するか、自分のグループを作成してください"
                        self.selectedTab = 0
                    } else {
                        self.showNoGroupDialog = false
                    }
                }
            }
    }
    
}
