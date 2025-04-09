//
//  MainView.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var agreementDataModel: AgreementDataModel
    
    @EnvironmentObject var approvalWaitlistDataModel: ApprovalWaitlistDataModel
    
    @EnvironmentObject var hamburgerMenuDataModel: HamburgerMenuDataModel
    
    @EnvironmentObject var warehouseInfoChangeDataModel: WarehouseInfoChangeDataModel
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var inventorySellSetDataModel: InventorySellSetDataModel
    
    @EnvironmentObject var orderRegardDataModel: OrderRegardDataModel
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var creditCardManagementDataModel: CreditCardManagementDataModel
    
    @EnvironmentObject var chargeDataModel: ChargeDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel: InputCreditCardInformationDataModel
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var tradingLocationDataModel: TradingLocationDataModel
    
    @EnvironmentObject var locationDataModel: LocationDataModel
    
    @EnvironmentObject var photographViewDataModel: PhotographViewDataModel
    
    @EnvironmentObject var doUpdataDataModel: DoUpdataDataModel
    
    @State private var tabs = ["グループ", "在庫検索", "在庫登録", "アカウント", "撮影する"]
    
    var body: some View {
        
        ZStack{
            
            VStack (spacing: 0){
                
                if (mainViewDataModel.selectedTab == 0) {
                    GroupManagement()
                } else if (mainViewDataModel.selectedTab == 1) {
                    InventoryAll()
                } else if (mainViewDataModel.selectedTab == 4) {
                    CameraDetect()
                } else if (mainViewDataModel.selectedTab == 2) {
                    Inventory()
                } else if (mainViewDataModel.selectedTab == 3) {
                    AccountManagement()
                } else {
                    
                }
                HStack (spacing: 0){
                    BottomTab(image: "people", label: tabs[0], tag: 0, selectedTag: $mainViewDataModel.selectedTab)
                        .frame(maxWidth: .infinity)
                    BottomTab(image: "magnifiying-glass", label: tabs[1], tag: 1, selectedTag: $mainViewDataModel.selectedTab)
                        .frame(maxWidth: .infinity)
                    BottomTab(image: "camera", label: tabs[4], tag: 4, selectedTag: $mainViewDataModel.selectedTab, numberMark: approvalWaitlistDataModel.resultCount)
                        .frame(maxWidth: .infinity)
                    BottomTab(image: "paint-bucket", label: tabs[2], tag: 2, selectedTag: $mainViewDataModel.selectedTab)
                        .frame(maxWidth: .infinity)
                    BottomTab(image: "account", label: tabs[3], tag: 3, selectedTag: $mainViewDataModel.selectedTab, numberMark: approvalWaitlistDataModel.resultCount)
                        .frame(maxWidth: .infinity)
                }.overlay(
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 0.8)
                        .shadow(color: Color(hex: "000000").opacity(0.16), radius: 1, x: 0.0, y: -10),
                    alignment: .top)
                
                Group{
                    
                    Group{
                        NavigationLink(
                            destination: Introduction(), tag: 1, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        //---------------HamburgerMenu---------------
                        
                        NavigationLink(
                            destination: GroupSearch(isRelatedSearch: false, from: 1), tag: 31, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: GroupSearch(isRelatedSearch: true, from: 2), tag: 32, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: GroupInfoChange(from: 1), tag: 33, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: ApprovalWaitlist(from: 1), tag: 34, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: GroupInfoChange(from: 2), tag: 35, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        NavigationLink(
                            destination: Inventory(from: 1), tag: 36, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: InventoryAll(from: 1), tag: 37, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        //在庫承認リスト、ワークフロー管理 link.
                        NavigationLink(
                            destination: InventoryApproval(), tag: 5, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: InventoryApprovalChange(), tag: 6, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                    }
                    Group{
                        NavigationLink(
                            destination: MemberManagement(), tag: 1, selection: $groupInfoChangeDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                        //---------------倉庫管理 link---------------
                        NavigationLink(
                           destination: WarehouseManagement(), tag: 23, selection: $dialogsDataModel.mainViewNavigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                        
                        NavigationLink(
                           destination: WarehouseManagement(), tag: 3, selection: $groupInfoChangeDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                        //---------------お問い合わせ管理 一覧 link---------------
                        NavigationLink(
                            destination: InquiryManagementView(), tag: 18, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------問い合わせ一覧 link---------------
//                        NavigationLink(
//                            destination: InquiryListView(), tag: 9, selection: $dialogsDataModel.mainViewNavigationTag) {
//                                EmptyView()
//                            }.isDetailLink(false)
                        
                        NavigationLink(
                            destination: InquiryManagement(), tag: 9, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------お気に入り link---------------
                        NavigationLink(
                            destination: FavoriteView(), tag: 11, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------閲覧履歴 link---------------
                        NavigationLink(
                            destination: BrowsingHistoryView(), tag: 12, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------オーダー履歴一覧 link---------------
                        NavigationLink(
                            destination: OrderHistoryView(), tag: 13, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(
                            destination: OrderListView(), tag: 14, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------問い合わせフォーム link---------------
                        NavigationLink(
                            destination: InquiryFrom(), tag: 10, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //--------------------------------------------
                    }
                    Group{
                        //---------------chat link from InventoryInquiry---------------
                        NavigationLink(
                            destination: ChatView(), tag:40, selection: $dialogsDataModel.mainViewNavigationTag){
                                EmptyView()
                            }.isDetailLink(false)
                        
                        NavigationLink(
                            destination: AccountManagement(from: 1), tag: 38, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        //---------------支払い情報 link---------------
                        //カード情報の入力
                        NavigationLink(
                            destination: InputCreditCardInformationView(), tag: 17, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)

                        //カード情報
                        NavigationLink(
                            destination: CreditCardManagementView(), tag: 22, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
               
                        //---------------画像認識利用状況管理 link---------------
                        NavigationLink(
                            destination: PhotographView(), tag: 28, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)

                        NavigationLink(
                            destination: ManagerView(), tag: 29, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------charge link---------------
                        //test 
//                                            NavigationLink(
//                                                destination:ChargeView(), tag: 25, selection: $dialogsDataModel.mainViewNavigationTag) {
//                                                    EmptyView()
//                                                }.isDetailLink(false)
                        //課金解約
//                                            NavigationLink(
//                                                destination:ChargeCancellationView(), tag: 1, selection: $accountManagementDataModel.navigationTag) {
//                                                    EmptyView()
//                                                }.isDetailLink(false)
                        NavigationLink(
                            destination: PaymentResultsView(), tag: 50, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        NavigationLink(
                            destination: ChargeCancellationResultsView(), tag: 51, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        //---------------------------------------------
                        
                        NavigationLink(
                            destination: OrderPaymentResultsView(), tag: 60, selection: $dialogsDataModel.mainViewNavigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                    }
                }
            }
            InventoryWheelInputs()
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
            
            // open hamburgerMenu
            if hamburgerMenuDataModel.show{
                HamburgerMenuView()
            }
            //
            
            
            
//            if warehouseInfoChangeDataModel.showPrefPick{
//                VStack{
//                    CommonPicker(selection:$warehouseInfoChangeDataModel.prefKey,pickList: warehouseInfoChangeDataModel.prefs,onCancel:{
//                        warehouseInfoChangeDataModel.showPrefPick = false
//                    },onCompleted: {
//                        warehouseInfoChangeDataModel.setPrefValue()
//                        warehouseInfoChangeDataModel.showPrefPick = false
//                    })
//                    if warehouseInfoChangeDataModel.addBottom {
//                        Spacer(minLength: 80)
//                    }
//                }
//            }
            if groupInfoChangeDataModel.showPrefPick{
                VStack{
                    CommonPicker(selection:$groupInfoChangeDataModel.prefKey,pickList: groupInfoChangeDataModel.prefs,onCancel:{
                        groupInfoChangeDataModel.showPrefPick = false
                    },onCompleted: {
                        groupInfoChangeDataModel.setPrefValue()
                        groupInfoChangeDataModel.showPrefPick = false
                    })
                    if groupInfoChangeDataModel.addBottom {
                        Spacer(minLength: 80)
                    }
                }
            }
            if inventorySellSetDataModel.showPicker{
                CommonPicker(selection:$inventorySellSetDataModel.selection,pickList: inventorySellSetDataModel.pickList,onCancel:{
                    inventorySellSetDataModel.showPicker = false
                },onCompleted: {
                    inventorySellSetDataModel.showPicker = false
                    inventorySellSetDataModel.setPickValue(pickId: inventorySellSetDataModel.selection)
                })
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            doUpdataDataModel.doUpdate(dialogsDataModel: dialogsDataModel)
            if(inputCreditCardInformationDataModel.isBindCustomer == false){
                inputCreditCardInformationDataModel.checkCustomer(dialogsDataModel: dialogsDataModel)
                inputCreditCardInformationDataModel.isBindCustomer = true
            }
            accountManagementDataModel.getSubscriptionInformation(dialogsDataModel: dialogsDataModel)
            accountManagementDataModel.getUserInfo(dialogsDataModel: dialogsDataModel)
            debugPrintLog(message:"main on appear")
            dialogsDataModel.getUnreadMessageCounts()
            locationDataModel.initData(dialogsDataModel: dialogsDataModel)
            tradingLocationDataModel.initLocationData(dialogsDataModel: dialogsDataModel)
            warehouseInfoChangeDataModel.initData(dialogsDataModel: dialogsDataModel)
            groupInfoChangeDataModel.initAdressData(dialogsDataModel: dialogsDataModel)
            inventoryInquiryDataModel.userId = mainViewDataModel.loggedInUserId ?? 0
            photographViewDataModel.getCount(dialogsDataModel: dialogsDataModel)
            
            //---reset coming back from PaymentResultView---
            inputCreditCardInformationDataModel.navigationTag = nil
            inputCreditCardInformationDataModel.confirmNavigationTag = nil
            //----------------------------------------------
//            mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
        })
    }
}

