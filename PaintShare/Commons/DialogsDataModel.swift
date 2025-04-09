//
//  DialogsDataModel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/7/21.
//

import SwiftUI

class DialogsDataModel: ObservableObject {
    
    //　共通 401 の時にログアウトのため
    @Published var loginNavigationTag: Int? = nil
    
    @Published var mainViewNavigationTag: Int? = nil
    
    @Published var showLargeImage: Bool = false
    
    @Published var largeImage:UIImage? = Constants.imageHolderUIImage!
    
    @Published var showPaymentDialog: Bool = false
    
    @Published var showChargeView: Bool = false
    
    @Published var showChargeCancellationView: Bool = false
    
    @Published var showErrorDialog: Bool = false
    
    @Published var errorMsg: String = ""
    
    @Published var showSavedDialog: Bool = false
    
    @Published var showFirstTimeSavedDialog: Bool = false
    
    @Published var imageDeleteDialog: Bool = false
    
    @Published var subscriptionDto: SubscriptionDto?
    
    @Published var UnreadMessage: Int = 0

    @Published var orderPayResult: Int = 0
    
    @Published var showNumberOnlyDialog: Bool = false
    
    @Published var showPriceNoti: Bool = false
    
    @Published var showOverPriceBtn: Bool = false

    @Published var showDeleteButton: Bool = false
    
    @Published var showConfirmAccountDeleteDialog: Bool = false
    
    @Published var showConfirmGroupDeleteDialog: Bool = false
    
    @Published var showLoading: Bool = false
    
    var freeUseUntil: UInt64 = 1
    
    var imageDeleteSubject: String = ""
    
    func resetImage(accountManagementDataModel: AccountManagementDataModel, groupInfoChangeDataModel: GroupInfoChangeDataModel, inventoryDataModel: InventoryDataModel, inventoryEditDataModel: InventoryEditDataModel) {
        if imageDeleteSubject == Constants.IMG_DEL_SUBJECT_ACC {
            accountManagementDataModel.profilePicture = Constants.profileHolderUIImage!
        } else if imageDeleteSubject == Constants.IMG_DEL_SUBJECT_GRP {
            groupInfoChangeDataModel.logo = Constants.imageHolderUIImage!
        } else if imageDeleteSubject == Constants.IMG_DEL_SUBJECT_PAINT_NEW {
            inventoryDataModel.logo = Constants.imageHolderUIImage!
        } else if imageDeleteSubject == Constants.IMG_DEL_SUBJECT_PAINT_EDIT {
            inventoryEditDataModel.logo = Constants.imageHolderUIImage!
        }
    }
    
    @Published var tooltipDialog: Bool = false
    
    @Published var tooltipTitle: String = ""
    
    @Published var tooltipDescription: String = ""
    
    @Published var showEditDialog: Bool = false
    
    @Published var editDialogText = ""
    
    func dateJudge(_ string: String, format: String = "yyyy/MM/dd") -> Int {
        let now = Date()
        let feature = Date.parse(string)
        let time = (feature.timeIntervalSince1970 - now.timeIntervalSince1970)/86400
        
        if time < 0 {
            return 1
        }else if time >= 0 && time < 90 {
            return 2
        }else if time >= 90 {
            return 3
        }else{
            return 0
        }
    }
    
    func distancesFrom(_ startingDate: Date, to resultDate: Date) -> Int? {
        let gregorian = Calendar(identifier: .gregorian)
        let comps = (gregorian as NSCalendar).components(.month, from: startingDate, to: resultDate, options: .wrapComponents)
        return comps.month
    }
    
    func getUnreadMessageCounts(){
        UrlUtils.getRequest(url: UrlConstants.CHATROOM_MESSAGE_GET_UNREAD_COUNT, type: MenuNoticeResponse.self, dialogsDataModel: self)
            .then{
                menuNoticeDto in
                if menuNoticeDto != nil {
                self.UnreadMessage = menuNoticeDto?.unReadCount ?? 0
                }
            }
    }
}

public extension Date {

    static func parse(_ string: String, format: String = "yyyy/MM/dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format

        let date = dateFormatter.date(from: string)!
        return date
    }

    func dateString(_ format: String = "yyyy/MM/dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
