//
//  inventoryEdit.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/10.
//

import SwiftUI

struct inventoryEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel

    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var sellPrecautionsDataModel: SellPrecautionsDataModel
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var from: Int = 0
    
    var body: some View {
        ZStack{
        VStack(spacing: 0){
            CommonHeader(title: "在庫編集", showBackButton: true, showHamburgerButton: false,onBackClick: {
                inventoryInquiryDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            ScrollView(.vertical){
                VStack(spacing: 21){
                    CommonSelectField(label: "登録先グループ", placeholder: "", required: true, onClick: {
                        if from != 1{
                            /*
                            inventoryEditDataModel.showPicker = true
                            inventoryEditDataModel.pickListId = 3
                            inventoryEditDataModel.setPackList(pickListId: 3)
                             */
                        }
                    }, value: $inventoryEditDataModel.groupValue,validationMessage: inventoryEditDataModel.ownedByIdMessage)
                    CommonSelectField(label: "倉庫", placeholder: "", required: true, onClick: {
                        if from != 1{
                            inventoryEditDataModel.showPicker = true
                            inventoryEditDataModel.pickListId = 4
                            inventoryEditDataModel.setPackList(pickListId: 4)
                        }
                    }, value: $inventoryEditDataModel.adressValue, validationMessage: inventoryEditDataModel.adressIdMessage)
                    CommonSelectField(label: "メーカー", placeholder: "", required: true, onClick: {
                        if from != 1{
                            inventoryEditDataModel.showPicker = true
                            inventoryEditDataModel.pickListId = 0
                            inventoryEditDataModel.setPackList(pickListId: 0)
                        }
                    }, value: $inventoryEditDataModel.makerValue, validationMessage: inventoryEditDataModel.makerIdMessage)
                    GotoOtherViewSelectField(label: "商品名", placeholder: "", required: true, onClick: {
                        if from != 1{
                            inventoryEditDataModel.navigationTag = 3
                        }
                    }, value: $inventoryEditDataModel.goodsNameValue, validationMessage: inventoryEditDataModel.goodsNameIdMessage, isDisable: from != 1 ? false : true)
                    CommonSelectField(label: "用途区分", placeholder: "", showOptionalTag: true, onClick: {
                        if from != 1{
                            inventoryEditDataModel.showPicker = true
                            inventoryEditDataModel.pickListId = 1
                            inventoryEditDataModel.setPackList(pickListId: 1)
                        }
                    }, value: $inventoryEditDataModel.useCategoryValue, validationMessage: inventoryEditDataModel.useCategoryIdMessage)
                    HStack{
                        Text("色の選択")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.caution)
                                .frame(width: 44, height: 21)
                            Text("必須")
                                .font(.regular11)
                                .foregroundColor(.white)
                        }.padding(.leading, 10)
                        Spacer()
                        NavigationLink(destination: GoodsNameSelect(goodsName: $inventoryEditDataModel.goodsNameValue,goodsNameKey: $inventoryEditDataModel.goodsNameKey, makerId: $inventoryEditDataModel.makerkey), tag: 3, selection: $inventoryEditDataModel.navigationTag) {
                            EmptyView()}.isDetailLink(false)
                        NavigationLink(destination: ColorSelect(standardId: $inventoryEditDataModel.standardId,standardName: $inventoryEditDataModel.standardName,colorNumberId: $inventoryEditDataModel.colorNumberId,colorCode: $inventoryEditDataModel.colorCode, colorNumber: $inventoryEditDataModel.colorNumber, addBottom: true), tag: 1, selection: $inventoryEditDataModel.navigationTag) {
                            EmptyView()}.isDetailLink(false)
                        Image("ionic-ios-arrow-down")
                            .resizable()
                            .frame(width: 16.38, height: 9.37, alignment: .center)
                            .rotationEffect(.degrees(-90))
                    }
                    .padding(.trailing, 5)
                    .onTapGesture(perform: {
                        if (!inventoryEditDataModel.colorFlag) {
                            if from != 1{ inventoryEditDataModel.navigationTag = 1 }}})
                    
                    HStack(alignment: .bottom, spacing: 20){
                        if inventoryEditDataModel.colorNumberId == -1{
                            Text("未選択")
                                .font(.light16)
                                .foregroundColor(.lightText)
                                .frame(width: 100, height: 100)
                                .border(Color(hex: "#707070"), width: 0.5)
                        }else{
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(hex: inventoryEditDataModel.colorCode))
                                .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                            
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("選択中の色")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                                .padding(.bottom, 2)
                            Text(inventoryEditDataModel.standardName != "該当なし" ? inventoryEditDataModel.standardName : "")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .lineSpacing(0)
                                .padding(.bottom, -6)
                            Text(inventoryEditDataModel.colorNumber)
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .lineSpacing(0)
                            Spacer()
                            CommonButton(text: "クリア",color: .secondary,width: 100, height: 28, disabled: inventoryEditDataModel.colorNumberId == -1, onClick: {
                                if from != 1{
                                    inventoryEditDataModel.colorNumberId = -1
                                    inventoryEditDataModel.standardName = "_"
                                    inventoryEditDataModel.colorNumber = ""
                                }
                            })
                        }
                        Spacer()
                    }
                    .frame(height: 105)
//                    .padding(.bottom, 20)
//                    .underlineTextField()
                    .background(Color.white)
//                    .onTapGesture(perform: {
//                        if from != 1{ inventoryEditDataModel.navigationTag = 1 }})
                    HStack {
                        CommonCheckBox(checked: $inventoryEditDataModel.colorFlag, width: 22, height: 22 )
                        Text("その他").font(.regular12).foregroundColor(.mainText)
                        if (inventoryEditDataModel.colorFlag){
                            TextField("", text: $inventoryEditDataModel.otherColorName)
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
                    HStack {
                        ImageEditor(title: "材料画像", img: $inventoryEditDataModel.logo, showImagePicker: $shouldPresentActionScheet, imageDeleteSubject: Constants.IMG_DEL_SUBJECT_PAINT_EDIT, from: from)
                        Spacer()
                    }
                }
                .padding(.horizontal, 21)
                VStack(spacing: 21){
                    CommonSelectField(label: "在庫数量（缶）", placeholder: "", required: true, onClick: {
                        if from != 1{
                            inventoryEditDataModel.showAmountPicker = true
                        }
                    }, value: $inventoryEditDataModel.amount, validationMessage: inventoryEditDataModel.amountMessage)
                    CommonSelectField(label: "使用期限日", placeholder: "", onClick: {
                        if from != 1{
                            inventoryEditDataModel.showDatePicker = true
                        }
                    }, value: $inventoryEditDataModel.expireDateStr, additionalMessage: "※「使用期限日」は製造年月日から2年後を入力してください")
                    CommonTextField(label: "ロット番号", placeholder: "", value: $inventoryEditDataModel.lotNumber, disabled: from != 1 ? false : true, validationMessage: inventoryEditDataModel.lotNumberMessage)
                    HStack(spacing: 15) {
                        Text("公開設定")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    Toggle(isOn: $inventoryEditDataModel.inventoryPublic, label: {
                        HStack(spacing: 15) {
                            Text("フレンドへ共有")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                            TooltipLabel()
                                .onTapGesture(perform: {
                                    dialogsDataModel.tooltipTitle = "この在庫をフレンドへ共有"
                                    dialogsDataModel.tooltipDescription = "こちらをONにすると当該グループのフレンドへ共有されます。（フレンドではないユーザーには公開されません。）"
                                    dialogsDataModel.tooltipDialog = true
                                })
                        }
                    })
                    if (inventoryEditDataModel.selectedSell != 2) {
                        HStack(spacing: 15) {
                            Text("販売用として公開")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                            TooltipLabel()
                                .onTapGesture(perform: {
                                    dialogsDataModel.tooltipTitle = "販売用として公開"
                                    dialogsDataModel.tooltipDescription = "こちらをONにすると登録している在庫を全ユーザーに販売することができます。またONにするには販売用設定を行う必要があります。"
                                    dialogsDataModel.tooltipDialog = true
                                })
                            Spacer()
                            Toggle(isOn: $inventoryEditDataModel.sellPublic, label: {
                                
                            }).disabled(inventoryEditDataModel.priceValue == "" && inventoryEditDataModel.sellPublic == false ? true : false)
                        }
                    }
                    HStack{
                        Spacer()
                        Text("在庫No：")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text(inventoryEditDataModel.inventoryNumber)
                            .font(.medium16)
                            .foregroundColor(.mainText)
                    }
                }
                .padding(.horizontal, 21)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                
                if (inventoryEditDataModel.selectedSell == 0 && from != 1) {
                    HStack {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(hex: "#56B8C4"))
                        Text("販売用として登録する場合はこちら")
                            .font(.bold14)
                            .foregroundColor(.mainText)
                        Spacer()
                        Image("ionic-ios-arrow-down")
                            .resizable()
                            .frame(width: 16.38, height: 9.37, alignment: .center)
                            .rotationEffect(.degrees(-90))
                    }
                    .padding(.bottom, 20)
                    .underlineTextField()
                    .padding(.horizontal, 21)
                    .onTapGesture(perform: {
                        let defaults = UserDefaults.standard
                        let isSkip = defaults.bool(forKey: Constants.IS_NOT_SKIP_PRECAUTIONS)
                        if !isSkip {
                            sellPrecautionsDataModel.show = true
                        }
                        inventoryEditDataModel.selectedSell = 1
                    })
                } else if (inventoryEditDataModel.selectedSell == 1 || from == 1) {
                    InventorySellSet(usedBy: 2, from: from)
                    .onAppear {

                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 21)
                } else if (inventoryEditDataModel.selectedSell == 2 && from != 1) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 34, height: 194)
                        VStack{
                            HStack{
                                Text("この商品は販売用として設定済みの商品です")
                                    .font(.bold14)
                                    .foregroundColor(.secondary)
                                    .lineLimit(nil)
                                Spacer()
                            }.padding(.bottom, 10)
                            CommonTextField(label: "重量（㎏）", placeholder: "", value: $inventoryEditDataModel.weightValue)
                                .keyboardType(.decimalPad)
                            CommonTextField(label: "商品価格（円）", placeholder: "", value: $inventoryEditDataModel.priceValue, commabled: true)
                                .keyboardType(.decimalPad)
                            CommonButton(text: "編集", color: Color(hex: "#1DB78B"), width: 66, height: 28, onClick: {
                                inventoryEditDataModel.selectedSell = 1
                            })
                        }.padding(.horizontal, 21)
                    }
                }
                
                
                NavigationLink(
                    destination: InventoryAll(), tag: 2, selection: $inventoryEditDataModel.navigationTag) {
                    EmptyView()
                }.isDetailLink(false)
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                CommonButton(text: "更新", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    if inventoryEditDataModel.sellPublic == true && Int(inventoryEditDataModel.priceValue.filter{$0 != ","}) ?? 0 < 100 {
                        dialogsDataModel.showPriceNoti = true
                    }else{
                        inventoryEditDataModel.showEditConfirmDialog = true
                    }
                })
                .padding(.top, 50)
                .padding(.bottom, 30)
                .padding(.horizontal, 21)
                CommonButton(text: "キャンセル", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    inventoryEditDataModel.selectedSell = 0
                    inventoryInquiryDataModel.navigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
                .padding(.bottom, 30)
                .padding(.horizontal, 21)
                Spacer(minLength: 100)
            }
            .padding(.top, 23)
            //Spacer(minLength: 80)
        }
        if sellPrecautionsDataModel.show == true{
            SellPrecautionsView()
        }
        if from == 1 || from == 2{
            InventoryWheelInputs()
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $inventoryEditDataModel.logo, sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
        }
        .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("選択してください"), buttons: [ActionSheet.Button.default(Text("カメラ"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("写真ライブラリ"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
}
