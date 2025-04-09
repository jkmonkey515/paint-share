//
//  ColorSelect.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/28.
//

import SwiftUI

struct ColorSelect: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var colorSelectDataModel: ColorSelectDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @State var showSelectPanel: Bool = false
    
    @State var searchText: Bool = false
    
    @Binding var standardId: Int
    
    @Binding var standardName: String
    
    @Binding var colorNumberId: Int
    
    @Binding var colorCode: String

    @Binding var colorNumber: String
    
    var isSearch: Bool = false
    
    var addBottom: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                CommonHeader(title: "色の選択", showBackButton: true, onBackClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                VStack{
                    CommonSelectField(label: "メーカー標準色／日塗工", placeholder: "", onClick: {
                        showSelectPanel = true
                    }, value: $colorSelectDataModel.makerValue)
                    HStack{
                        Spacer()
                        Text("※一致する色が見つからない場合、近い色をお選びください")
                            .font(.light10)
                            .foregroundColor(.mainText)
                    }
                    .padding(.top, -5)
                    HStack{
                        Text("色番号")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.top, 18)
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
                            TextField("Search...", text: $colorSelectDataModel.searchPhrase, onCommit: {
                                colorSelectDataModel.resetList(searchPhrase: colorSelectDataModel.searchPhrase)
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
                                    colorSelectDataModel.searchPhrase = ""
                                    colorSelectDataModel.resetList(searchPhrase: colorSelectDataModel.searchPhrase)
                                })
                        }
                        .frame(height: 30)
                        .background(Color(hex: "f3f3f3"))
                        .cornerRadius(4)
                    }
                    ScrollView(.vertical) {
                        ForEach(colorSelectDataModel.selColorNumberList, id: \.id) {
                            result in
                                ColorListItem(colorNumber: result.colorNumber, colorCode: result.colorCode)
                                    .onTapGesture(perform: {
                                        colorNumberId = result.id
                                        colorNumber = result.colorNumber
                                        colorCode = result.colorCode
                                        standardId = colorSelectDataModel.makerKey
                                        standardName = colorSelectDataModel.makerValue
                                        inventoryEditDataModel.navigationTag = nil
                                        self.presentationMode.wrappedValue.dismiss()
                                    })
                        }
                    }
                }
                .padding(.top, 23)
                .padding(.horizontal, 21)
                Spacer(minLength: 80)
            }
            if showSelectPanel{
                VStack{
                    CommonPicker(selection:$colorSelectDataModel.makerKey,pickList: colorSelectDataModel.makerPickList,onCancel:{
                        showSelectPanel = false
                    },onCompleted: {
                        colorSelectDataModel.setValue(pickId: colorSelectDataModel.makerKey)
                        colorSelectDataModel.setList(makerId: colorSelectDataModel.makerKey)
                        standardId = colorSelectDataModel.makerKey
                        standardName = colorSelectDataModel.makerValue
                        showSelectPanel = false
                    })
                    if addBottom {
                        Spacer(minLength: 80)
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            colorSelectDataModel.initData(dialogsDataModel: dialogsDataModel,isSearch: false)
        })
    }
}
