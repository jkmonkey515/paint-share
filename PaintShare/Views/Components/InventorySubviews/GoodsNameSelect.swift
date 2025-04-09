//
//  GoodsNameSelect.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/07/06.
//

import SwiftUI


struct GoodsNameSelect: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var goodsNameSelectDataModel: GoodsNameSelectDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var addBottom: Bool = false
    
    @Binding var goodsName: String
    
    @Binding var goodsNameKey: Int
    
    @Binding var makerId: Int
    
    var body: some View {
        ZStack{
            VStack{
                CommonHeader(title: "商品選択", showBackButton: true, onBackClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                VStack{
                    HStack{
                        Text("商品名")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    .underlineTextField()
                    HStack(spacing: 20) {
                        HStack {
                            Image("magnifiying-glass")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(Color(hex: "c2c2c2"))
                                .padding(.leading, 10)
                            TextField("Search...", text: $goodsNameSelectDataModel.searchPhrase, onCommit: {
                                goodsNameSelectDataModel.resetList(searchPhrase: goodsNameSelectDataModel.searchPhrase)
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
                                    goodsNameSelectDataModel.searchPhrase = ""
                                    goodsNameSelectDataModel.resetList(searchPhrase: goodsNameSelectDataModel.searchPhrase)
                                })
                        }
                        .frame(height: 30)
                        .background(Color(hex: "f3f3f3"))
                        .cornerRadius(4)
                    }
                    ScrollView(.vertical) {
                        ForEach(goodsNameSelectDataModel.selGoodsNameList, id: \.id) {
                            result in
                            HStack{
                                Text(result.name)
                                    .font(.medium18)
                                    .foregroundColor(.mainText)
                                Spacer()
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 15)
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(hex: "F3F3F3")),
                                alignment: .bottom
                            )
                            .onTapGesture(perform: {
                                self.goodsName = result.name
                                self.goodsNameKey = result.id
                                inventoryEditDataModel.navigationTag = nil
                                self.presentationMode.wrappedValue.dismiss()
                            })
                        }
                    }
                }
                .padding(.horizontal, 21)
                Spacer(minLength: 80)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            goodsNameSelectDataModel.initData(dialogsDataModel: dialogsDataModel, makerId: makerId)
        })
    }
}

