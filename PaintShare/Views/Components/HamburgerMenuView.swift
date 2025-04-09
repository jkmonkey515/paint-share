//
//  AccordionMenuView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/25.
//

import SwiftUI

struct HamburgerMenuView: View {
    @State private var menu_group=[
        "グループ","グループ検索","関連グループ","グループ作成","グループ変更","メンバー承認待ち"]
    
    @State private var menu_inventory=["在庫管理","在庫登録","在庫検索","在庫承認待ち","ワークフロー管理"]
    
    @State private var menu_warehouse=["倉庫管理","倉庫一覧"]
    
    @State private var menu_resume=["やりとり履歴","お問い合わせ一覧","注文履歴","注文管理","お気に入り","閲覧履歴","お問い合わせ管理一覧"]
    
    @State private var menu_account=["アカウント管理","アカウント情報","支払い情報","画像認識利用状況管理","運営への問い合わせ","課金テスト","振込先口座登録情報"]
    
    @EnvironmentObject var hamburgerMenuDataModel: HamburgerMenuDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var inventoryApprovalDataModel:InventoryApprovalDataModel
    
    @EnvironmentObject var inventoryApprovalChangeDataModel:InventoryApprovalChangeDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var inquiryListDataModel:InquiryListDataModel
    
    @EnvironmentObject var inquiryManagementDataModel:InquiryManagementDataModel
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var favoriteDataModel: FavoriteDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var creditCardManagementDataModel:CreditCardManagementDataModel
    
    @EnvironmentObject var warehouseDataModel:WarehouseDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    @EnvironmentObject var orderListDataModel:OrderListDataModel
    
    @EnvironmentObject var managerViewDataModel:ManagerViewDataModel
    
    @EnvironmentObject var orderConfirmDataModel:OrderConfirmDataModel
    
    @EnvironmentObject var paymentResultsDataModel:PaymentResultsDataModel
    
    var tag = 0
    
    var body: some View {
        
        
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack{
                    CommonHeader(title:"メニュー",showHamburgerButton: false)
                    
                    HStack{
                        Spacer()
                        if dialogsDataModel.showOverPriceBtn == true {
                            GeneralButton(onClick: {
                                dialogsDataModel.mainViewNavigationTag = 28
                                hamburgerMenuDataModel.show = false
                            }, label: {
                                Image("over-price")
                            })
                            .padding(.bottom, 5)
                            .padding(.trailing, 5)
                        }
                        GeneralButton(onClick: {
                            hamburgerMenuDataModel.show = false
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.regular20)
                                .foregroundColor(Color(hex:"#56B8C4"))
                        })
                    }
                    .padding(.trailing,22)
                }
                
                List{
                    Group{//グループ
                        MenuTitle(title: menu_group[0],tag: 0)
                            .listRowBackground(Color(hex: "#A3E8F1"))
                        MenuTitle(title: menu_group[1],tag: 1)
                            .onTapGesture {
                                mainViewDataModel.selectedTab = 0
                                groupManagementDataModel.selectedTab = 0
                                hamburgerMenuDataModel.show = false
                            }
                        MenuTitle(title: menu_group[2],tag: 1)
                            .onTapGesture {
                                mainViewDataModel.selectedTab = 0
                                groupManagementDataModel.selectedTab = 1
                                hamburgerMenuDataModel.show = false
                            }
                        if mainViewDataModel.loggedInUserGroup != nil{
                            MenuTitle(title: menu_group[4],tag: 1)
                                .onTapGesture {
                                    mainViewDataModel.selectedTab = 0
                                    groupManagementDataModel.selectedTab = 2
                                    hamburgerMenuDataModel.show = false
                                }
                            MenuTitle(title: menu_group[5],tag: 1)
                                .onTapGesture {
                                    mainViewDataModel.selectedTab = 0
                                    groupManagementDataModel.selectedTab = 3
                                    hamburgerMenuDataModel.show = false
                                }
                        }else{
                            MenuTitle(title: menu_group[3],tag: 1)
                                .onTapGesture {
                                    mainViewDataModel.selectedTab = 0
                                    groupManagementDataModel.selectedTab = 4
                                    hamburgerMenuDataModel.show = false
                                }
                        }
                    }
                    Group{//在庫管理
                        MenuTitle(title: menu_inventory[0],tag: 0)
                            .listRowBackground(Color(hex: "#A3E8F1"))
                        MenuTitle(title: menu_inventory[1],tag: 1)
                            .onTapGesture {
                                mainViewDataModel.selectedTab = 2
                                hamburgerMenuDataModel.show = false
                            }
                        MenuTitle(title: menu_inventory[2],tag: 1)
                            .onTapGesture {
                                mainViewDataModel.selectedTab = 1
                                hamburgerMenuDataModel.show = false
                            }
                        if (mainViewDataModel.loggedInUserGroup != nil) {
                            MenuTitle(title: menu_inventory[3],tag: 1)
                                .onTapGesture {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                        dialogsDataModel.mainViewNavigationTag = 5
                                    }else{
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                }
                            MenuTitle(title: menu_inventory[4],tag: 1)
                                .onTapGesture {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                        dialogsDataModel.mainViewNavigationTag = 6
                                    }else{
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                }
                        }
                    }
                    Group{//倉庫管理
                        if (mainViewDataModel.loggedInUserGroup != nil) {
                            MenuTitle(title: menu_warehouse[0],tag: 0)
                                .listRowBackground(Color(hex: "#A3E8F1"))
                            MenuTitle(title: menu_warehouse[1],tag: 1)
                                .onTapGesture(perform: {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil {
                                        warehouseDataModel.groupId = mainViewDataModel.loggedInUserGroup!.id
                                        dialogsDataModel.mainViewNavigationTag = 23
                                    } else {
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                })
                        }
                    }
                    Group{//やりとり履歴
                        MenuTitle(title: menu_resume[0],tag: 0)
                            .listRowBackground(Color(hex: "#A3E8F1"))
                        //---------------owner only---------------
                        /*
                        if (mainViewDataModel.loggedInUserGroup != nil) {
                            MenuTitle(title: menu_resume[6],tag: 1)
                                .onTapGesture {
                                    inquiryManagementDataModel.getChatroomDistinctList(dialogsDataModel: dialogsDataModel)
                                    dialogsDataModel.mainViewNavigationTag = 18
                                    hamburgerMenuDataModel.show = false
                                    //rest()
                                }
                        }
                         */
                        //----------------------------------------
                        MenuTitle(title: menu_resume[1],tag: 1,numberMark:dialogsDataModel.UnreadMessage)
                                    //UIApplication.shared.applicationIconBadgeNumber)
                                  
                            .onTapGesture {
                                if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                if (mainViewDataModel.loggedInUserGroup != nil) {
                                    
                                    if hamburgerMenuDataModel.userUnreadMessage != 0{
                                        inquiryManagementDataModel.selectionSwitchTab = 1
                                        debugPrintLog(message:"1")
                                    inquiryListDataModel.getLoginUserParticipateChatroomList(dialogsDataModel: dialogsDataModel)
                                    }else{
                                    inquiryManagementDataModel.selectionSwitchTab = 0
                                    debugPrintLog(message:"0")
                                    inquiryManagementDataModel.getChatroomDistinctList(dialogsDataModel: dialogsDataModel)
                                    }
                                }else{
                                    inquiryManagementDataModel.selectionSwitchTab = 1
                                    debugPrintLog(message:"1")
                                inquiryListDataModel.getLoginUserParticipateChatroomList(dialogsDataModel: dialogsDataModel)
                                }
                                inquiryManagementDataModel.reset()
                                inquiryListDataModel.reset()
                                dialogsDataModel.mainViewNavigationTag = 9
                                }else{
                                    dialogsDataModel.showChargeView = true
                                }
                                hamburgerMenuDataModel.show = false
                                //dialogsDataModel.UnreadMessage = 0
                                hamburgerMenuDataModel.reset()
                            }
                        MenuTitle(title: menu_resume[2],tag: 1)
                            .onTapGesture {
                                if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                    dialogsDataModel.mainViewNavigationTag = 13
                                }else{
                                    dialogsDataModel.showChargeView = true
                                }
                                hamburgerMenuDataModel.show = false
                                //rest()
                            }
                        if (mainViewDataModel.loggedInUserGroup != nil) {
                            MenuTitle(title: menu_resume[3],tag: 1)
                                .onTapGesture {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                    dialogsDataModel.mainViewNavigationTag = 14
                                    }else{
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                }
                        }
                        MenuTitle(title: menu_resume[4],tag: 1)
                            .onTapGesture {
                                if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                favoriteDataModel.reset()
                                favoriteDataModel.getLikePaintList(dialogsDataModel: dialogsDataModel)
                                dialogsDataModel.mainViewNavigationTag = 11
                                }else{
                                    dialogsDataModel.showChargeView = true
                                }
                                hamburgerMenuDataModel.show = false
                            }
                        MenuTitle(title: menu_resume[5],tag: 1)
                            .onTapGesture {
                                if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                browsingHistoryDataModel.getBrowsingHistoryList(dialogsDataModel: dialogsDataModel)
                                dialogsDataModel.mainViewNavigationTag = 12
                                }else{
                                    dialogsDataModel.showChargeView = true
                                }
                                hamburgerMenuDataModel.show = false
                            }
                    }
                    Group{//アカウント管理
                        MenuTitle(title: menu_account[0],tag: 0)
                            .listRowBackground(Color(hex: "#A3E8F1"))
                        MenuTitle(title: menu_account[1],tag: 1)
                            .onTapGesture {
                                mainViewDataModel.selectedTab = 3
                                hamburgerMenuDataModel.show = false
                            }
                        MenuTitle(title: menu_account[2],tag: 1)
                            .onTapGesture {
                                creditCardManagementDataModel.reset()
                                inputCreditCardInformationDataModel.reset()
                                inputCreditCardInformationDataModel.fromMenu=true
                                inputCreditCardInformationDataModel.getCardList(dialogsDataModel: dialogsDataModel,hamburgerMenuDataModel: hamburgerMenuDataModel)
                                //hamburgerMenuDataModel.show = false
                            }
                        if (mainViewDataModel.loggedInUserGroup != nil) {
                            MenuTitle(title: menu_account[6],tag: 1)
                                .onTapGesture {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                    managerViewDataModel.reset()
                                    managerViewDataModel.setManagerInfo(dialogsDataModel: dialogsDataModel)
                                    dialogsDataModel.mainViewNavigationTag = 29
                                    }else{
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                }
                            MenuTitle(title: menu_account[3],tag: 1)
                                .onTapGesture {
                                    if hamburgerMenuDataModel.free == true || dialogsDataModel.subscriptionDto != nil{
                                    dialogsDataModel.mainViewNavigationTag = 28
                                    }else{
                                        dialogsDataModel.showChargeView = true
                                    }
                                    hamburgerMenuDataModel.show = false
                                }
                        }
                        MenuTitle(title: menu_account[4],tag: 1)
                            .onTapGesture {
                                dialogsDataModel.mainViewNavigationTag = 10
                                hamburgerMenuDataModel.show = false
                                inquiryFromDataModel.rest()
                            }
                        
//                        MenuTitle(title: menu_account[5],tag: 1)
//                            .onTapGesture {
//                                dialogsDataModel.mainViewNavigationTag = 60
//                                orderConfirmDataModel.navigationTag = 3
//
//                                dialogsDataModel.mainViewNavigationTag = 50
//                                paymentResultsDataModel.tag = 1
//                                paymentResultsDataModel.tag = 0
//                          }
                        
                    }
                }
                .listStyle(.plain)
                .padding(.bottom)
                
            }
        }
        .onAppear(perform: {
            dialogsDataModel.getUnreadMessageCounts()
            hamburgerMenuDataModel.checkSubscription(dialogsDataModel: dialogsDataModel)
            if (mainViewDataModel.loggedInUserGroup != nil) {
            hamburgerMenuDataModel.getOwnerUnreadMessage(dialogsDataModel: dialogsDataModel)
            }
            hamburgerMenuDataModel.getUserUnreadMessage(dialogsDataModel: dialogsDataModel)
            orderConfirmDataModel.fromMenu = false
        })
    }
}

struct MenuTitle: View{
    var title : String
    var tag: Int
    var numberMark: Int = 0
    
    var body: some View{
        HStack {
            Text(self.title)
                .font( tag == 0 ? .bold16 : .regular16)
                .foregroundColor(Color(hex:tag == 0 ? "#46747E" : "#545353"))
                .frame( height: 32)
                .padding(.leading,tag == 0 ? 0:9)
            Spacer()
            
            if (numberMark != 0) {
                            Circle()
                                .fill(Color(hex: "f16161"))
                                .frame(width: 20, height: 20)
                                .padding(.leading,25)
            }
        }
        .contentShape(Rectangle())
    }
}

