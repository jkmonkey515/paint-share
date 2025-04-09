//
//  InventoryAll.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

struct InventoryAll: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
    
    @State var showSearchPanel = false
    
    var from: Int = 0
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack(spacing: 1) {
                    if from == 1{
                        CommonHeader(title: "在庫検索",showBackButton: true, onBackClick: {
                            dialogsDataModel.mainViewNavigationTag = nil
                            self.presentationMode.wrappedValue.dismiss()
                        },showSearch: false, onSearchClick: {
                            showSearchPanel = true
                            inventorySearchDataModel.clear();
                        })
                    }else{
                        CommonHeader(title: "在庫検索",showSearch: false, onSearchClick: {
                            showSearchPanel = true
                            inventorySearchDataModel.clear();
                        })
                    }
                    NavigationLink(
                        destination: InventoryInquiry(), tag: 2, selection: $inventorySearchDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                    .frame(width: 0, height: 0)
                    HStack(spacing: 20) {
                        HStack {
                            Image("magnifiying-glass")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "c2c2c2"))
                                .padding(.leading, 10)
                            TextField("Search...", text: $inventorySearchDataModel.searchPhrase, onCommit: {
                                inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                            })
                            .autocapitalization(.none)
                            .font(.regular12)
                            .foregroundColor(.mainText)
                            Image(systemName: "xmark.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "c1c1c1"))
                                .padding(.trailing, 10)
                                .onTapGesture(perform: {
                                    inventorySearchDataModel.searchPhrase = ""
                                    inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                                })
                        }
                        .frame(height: 30)
                        .background(Color(hex: "f3f3f3"))
                        .cornerRadius(4)
                        HStack(spacing: 0){
                            Text("検索設定")
                                .font(.regular14)
                                .foregroundColor(.mainText)
                                .onTapGesture(perform: {
                                    inventorySearchDataModel.searchPhrase = ""
                                    showSearchPanel = true
                                    inventorySearchDataModel.clear();
                                })
                            Image("ionic-ios-arrow-down")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 10, height: 6)
                                .rotationEffect(.degrees(-90))
                                .foregroundColor(.mainText)
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 20)
                    .frame(height: 50)
                    .background(Color(hex: "FAFAFA"))
                    RefreshableScrollView(onRefresh: { done in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                            done()
                        }
                    }) {
                        LazyVStack(spacing: 0) {
                            ForEach(inventorySearchDataModel.displayInventoryItems, id: \.id) { inventoryItem in
                                if inventoryItem.groupSearchLabel != nil {
                                    HStack{
                                        Text("\(inventoryItem.groupSearchLabel!.name)（\(inventoryItem.groupSearchLabel!.amount)）")
                                            .font(.regular14)
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                        Spacer()
                                    }
                                    .frame(height: 25)
                                    .background(Color.primary)
                                }
                                if inventoryItem.makerSearchLabel != nil {
                                    HStack{
                                        Text("\(inventoryItem.makerSearchLabel!.name)（\(inventoryItem.makerSearchLabel!.amount)）")
                                            .font(.regular14)
                                            .foregroundColor(.mainText)
                                            .padding(.leading, 10)
                                        Spacer()
                                    }
                                    .frame(height: 25)
                                    .background(Color(hex: "FDFEDF"))
                                }
                                InventoryListItem(inventorySearchItem: inventoryItem)
                                    .onTapGesture(perform: {
                                        inventoryInquiryDataModel.initData(id: inventoryItem.id, dialogsDataModel: dialogsDataModel)
                                        inventorySearchDataModel.navigationTag = 2
                                        browsingHistoryDataModel.reset()
                                        browsingHistoryDataModel.paintId = inventoryInquiryDataModel.id
                                        browsingHistoryDataModel.savePaintBrowsingHistory(dialogsDataModel: dialogsDataModel)
                                        favoriteDataModel.reset()
                                    })
                                    .onDisappear(perform: {
                                        
                                    })
                            }
                            if inventorySearchDataModel.hasNext {
                                HStack {
                                    HStack(spacing:3) {
                                        Text("もっと見る")
                                            .font(.regular18)
                                            .foregroundColor(Color(hex:"#56B8C4"))
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(Color(hex:"#56B8C4"))
                                    }
                                            .frame(width: UIScreen.main.bounds.size.width - 40,height: 40)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color(hex:"#56B8C4"), lineWidth: 1)
                                            )
                                        .onTapGesture(perform: {
                                            inventorySearchDataModel.loadMore(dialogsDataModel: dialogsDataModel)
                                        })
                                }
                                .padding(.top,20)
                                .padding(.bottom, 80)
                            }
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            if showSearchPanel{
                VStack(spacing: 0){
                    CommonHeader(title: "検索条件設定",showClose: false,onCloseClick: {
                        showSearchPanel = false
                        inventorySearchDataModel.showPicker = false
                    })
                    ScrollView {
                    VStack(spacing: 21){
                        Group{
                            CommonSelectField(label: "関連グループ", placeholder: "", onClick: {
                                inventorySearchDataModel.showPicker = true
                                inventorySearchDataModel.pickListId = 3
                                inventorySearchDataModel.setPackList(pickListId: 3)
                            }, value: $inventorySearchDataModel.groupTypeValue)
                            HStack{
                                CommonCheckBox(checked: $inventorySearchDataModel.checked, width: 22, height: 22)
                                Text("関連グループ以外の在庫を含む")
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                                Spacer()
                            }
                            CommonSelectField(label: "メーカー", placeholder: "", onClick: {
                                inventorySearchDataModel.showPicker = true
                                inventorySearchDataModel.pickListId = 1
                                inventorySearchDataModel.setPackList(pickListId: 1)
                            }, value: $inventorySearchDataModel.makerValue)
                            CommonTextField(label: "商品名", placeholder: "", value: $inventorySearchDataModel.goodsName)
                            CommonSelectField(label: "用途区分", placeholder: "", onClick: {
                                inventorySearchDataModel.showPicker = true
                                inventorySearchDataModel.pickListId = 0
                                inventorySearchDataModel.setPackList(pickListId: 0)
                            }, value: $inventorySearchDataModel.useCategoryValue)
                            CommonSelectField(label: "使用期限", placeholder: "", onClick: {
                                inventorySearchDataModel.showPicker = true
                                inventorySearchDataModel.pickListId = 2
                                inventorySearchDataModel.setPackList(pickListId: 2)
                            }, value: $inventorySearchDataModel.expireDateTypeValue)
                        }
                        HStack{
                            Text("色の選択")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Spacer()
                            NavigationLink(destination: ColorSelect(standardId: $inventorySearchDataModel.standardId,standardName: $inventorySearchDataModel.standardName,colorNumberId: $inventorySearchDataModel.colorNumberId,colorCode: $inventorySearchDataModel.colorCode, colorNumber: $inventorySearchDataModel.colorNumber,isSearch: true), tag: 1, selection: $inventorySearchDataModel.navigationTag) {
                                EmptyView()}.isDetailLink(false)
                            
                            Image("ionic-ios-arrow-down")
                                .resizable()
                                .frame(width: 16.38, height: 9.37, alignment: .center)
                                .rotationEffect(.degrees(-90))
                        }
                        .padding(.trailing, 5)
                        .onTapGesture(perform: {
                            if (!inventorySearchDataModel.colorFlag)
                            {
                                inventorySearchDataModel.navigationTag = 1}})
                        HStack(alignment: .bottom, spacing: 20){
                            if inventorySearchDataModel.colorNumberId == -1{
                                Text("未選択")
                                    .font(.light16)
                                    .foregroundColor(.lightText)
                                    .frame(width: 100, height: 100)
                                    .border(Color(hex: "#707070"), width: 0.5)
                            }else{
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color(hex: inventorySearchDataModel.colorCode))
                                    .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                                
                            }
                            VStack(alignment: .leading, spacing: 0){
                                Text("選択中の色")
                                    .font(.regular12)
                                    .foregroundColor(.mainText)
                                    .padding(.bottom, 2)
                                Text(inventorySearchDataModel.standardName != "該当なし" ? inventorySearchDataModel.standardName : "")
                                    .font(.medium16)
                                    .foregroundColor(.mainText)
                                    .lineSpacing(0)
                                    .padding(.bottom, -6)
                                Text(inventorySearchDataModel.colorNumber)
                                    .font(.medium16)
                                    .foregroundColor(.mainText)
                                    .lineSpacing(0)
                                Spacer()
                                CommonButton(text: "クリア",color: .secondary,width: 100, height: 28, disabled: inventorySearchDataModel.colorNumberId == -1, onClick: {
                                    inventorySearchDataModel.colorNumberId = -1
                                    inventorySearchDataModel.standardName = "_"
                                    inventorySearchDataModel.colorNumber = ""
                                })
                            }
                            Spacer()
                        }
                        .frame(height: 105)
//                        .padding(.bottom, 20)
//                        .underlineTextField()
                        .background(Color.white)
//                        .onTapGesture(perform: {
//                            inventorySearchDataModel.navigationTag = 1})
                        HStack {
                            CommonCheckBox(checked: $inventorySearchDataModel.colorFlag, width: 22, height: 22 )
                            Text("その他").font(.regular12).foregroundColor(.mainText)
                            if (inventorySearchDataModel.colorFlag){
                                TextField("", text: $inventorySearchDataModel.otherColorName)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .disableAutocorrection(true)
                                    .foregroundColor(.mainText)
                                    .font(.medium16)
                                    .padding(EdgeInsets(top:0, leading:10, bottom:0, trailing: 0))
                                    .underlineTextField()
                            }
                            else {
                                    Spacer()
                                }
                            }
                            .padding(.bottom, 10)
                            .underlineTextField()
                        GotoOtherViewSelectField(label: "地図から検索", placeholder: "", onClick: {
                            inventorySearchDataModel.navigationTag = 6
                        }, value: $inventorySearchDataModel.searchAdress)
                        NavigationLink(
                            destination: AreaSelection(usedBy: 3), tag: 6, selection:$inventorySearchDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        CommonButton(text: "検索", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick:{
                            showSearchPanel = false
                            inventorySearchDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
                            //inventorySearchDataModel.clear()
                        })
                        .padding(.top, 63)
                        .padding(.bottom, 30)
                        CommonButton(text: "クリア", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                            inventorySearchDataModel.clear()
                        })
                        Spacer(minLength: 100)
                    }
                    .padding(.top, 23)
                    .padding(.horizontal, 21)
                    }
                }.background(Color.white)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            debugPrintLog(message:"inventory appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            inventorySearchDataModel.initData(dialogsDataModel: dialogsDataModel)
        })
    }
}
