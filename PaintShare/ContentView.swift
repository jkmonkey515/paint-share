//
//  ContentView.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var directionsDataModel:DirectionsDataModel
    
    @EnvironmentObject var locationDataModel:LocationDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var tradingLocationDataModel:TradingLocationDataModel
    
    @EnvironmentObject var warehouseInfoChangeDataModel:WarehouseInfoChangeDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel:GroupInfoChangeDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    @EnvironmentObject var hamburgerMenuDataModel:HamburgerMenuDataModel
    
    @EnvironmentObject var inquiryManagementDataModel:InquiryManagementDataModel
    
    @EnvironmentObject var inquiryUserDataModel:InquiryUserDataModel
    
    @EnvironmentObject var inquiryListDataModel:InquiryListDataModel
    
    
    var body: some View {
        NavigationView{
        ZStack{
            
            Login()
            
            DirectionsView()
                .opacity(directionsDataModel.show ? 1.0 : 0.0)
        }
        .onAppear(perform: {
            let defaults = UserDefaults.standard
            let isNotFirstTime = defaults.bool(forKey: Constants.IS_NOT_FIRST_TIME_KEY)
            
            if(!isNotFirstTime){
                directionsDataModel.show = true
            }
            defaults.set(true, forKey: Constants.IS_NOT_FIRST_TIME_KEY)
            mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
            //defaults.set(false, forKey: Constants.IS_NOT_SKIP_PRECAUTIONS)
            
//            locationDataModel.initData(dialogsDataModel: dialogsDataModel)
//            tradingLocationDataModel.initLocationData(dialogsDataModel: dialogsDataModel)
//            warehouseInfoChangeDataModel.initData(dialogsDataModel: dialogsDataModel)
//            groupInfoChangeDataModel.initAdressData(dialogsDataModel: dialogsDataModel)
        })
        .onAppCameToForeground {
            if (mainViewDataModel.loggedInUserGroup != nil) {
            inquiryManagementDataModel.getChatroomDistinctList(dialogsDataModel: dialogsDataModel)
            inquiryUserDataModel.getOwnerChatroomList(dialogsDataModel: dialogsDataModel)
            }
            inquiryListDataModel.getLoginUserParticipateChatroomList(dialogsDataModel: dialogsDataModel)
            dialogsDataModel.getUnreadMessageCounts()
            AppBadgeNumber.getUnreadMessageCounts()
            mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
        }
        .onAppWentToBackground {
            
            dialogsDataModel.getUnreadMessageCounts()
            AppBadgeNumber.getUnreadMessageCounts()
            mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
        }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
