//
//  Inventory.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/05.
//

import SwiftUI

struct Inventory: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inventorySellSetDataModel: InventorySellSetDataModel
    
    @EnvironmentObject var sellPrecautionsDataModel: SellPrecautionsDataModel
    
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
    @State var navigationTag: Int? = nil
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var from: Int = 0
    
    var body: some View {
        ZStack{
        VStack(spacing: 0){
            if from == 1{
                CommonHeader(title: "在庫登録", showBackButton: true, onBackClick: {
                    cameraDetectDataModel.navigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
            }else{
                CommonHeader(title: "在庫登録")
            }
            ScrollView(.vertical){
                VStack(spacing: 21){
                    CommonSelectField(label: "登録先グループ", placeholder: "", required: true, onClick: {
                        inventoryDataModel.showPicker = true
                        inventoryDataModel.pickListId = 3
                        inventoryDataModel.setPackList(pickListId: 3)
                    }, value: $inventoryDataModel.groupValue,validationMessage: inventoryDataModel.ownedByIdMessage)
                    .padding(.top, 23)
                    CommonSelectField(label: "倉庫", placeholder: "", required: true, onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.showPicker = true
                        inventoryDataModel.pickListId = 4
                        inventoryDataModel.setPackList(pickListId: 4)
                    }, value: $inventoryDataModel.adressValue, validationMessage: inventoryDataModel.adressIdMessage)
                    CommonSelectField(label: "メーカー", placeholder: "", required: true, onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.showPicker = true
                        inventoryDataModel.pickListId = 0
                        inventoryDataModel.setPackList(pickListId: 0)
                    }, value: $inventoryDataModel.makerValue, validationMessage: inventoryDataModel.makerIdMessage)
                    GotoOtherViewSelectField(label: "商品名", placeholder: "", required: true,  onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.navigationTag = 2
                    }, value: $inventoryDataModel.goodsNameValue, infoMessage: "※ 商品は手入力でも登録できます。", validationMessage: inventoryDataModel.goodsNameIdMessage, isDisable: false)
                    CommonSelectField(label: "用途区分", placeholder: "", showOptionalTag: true, onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.showPicker = true
                        inventoryDataModel.pickListId = 1
                        inventoryDataModel.setPackList(pickListId: 1)
                    }, value: $inventoryDataModel.useCategoryValue, validationMessage: inventoryDataModel.useCategoryIdMessage)
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
                        NavigationLink(destination: GoodsNameSelect(goodsName: $inventoryDataModel.goodsNameValue,goodsNameKey: $inventoryDataModel.goodsNameKey, makerId: $inventoryDataModel.makerkey), tag: 2, selection: $inventoryDataModel.navigationTag) {
                            EmptyView()}.isDetailLink(false)
                        NavigationLink(destination: ColorSelect(standardId: $inventoryDataModel.standardId,standardName: $inventoryDataModel.standardName,colorNumberId: $inventoryDataModel.colorNumberId,colorCode: $inventoryDataModel.colorCode, colorNumber: $inventoryDataModel.colorNumber), tag: 1, selection: $inventoryDataModel.navigationTag) {
                            EmptyView()}.isDetailLink(false)
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        Image("ionic-ios-arrow-down")
                            .resizable()
                            .frame(width: 16.38, height: 9.37, alignment: .center)
                            .rotationEffect(.degrees(-90))
                    }
                    .padding(.trailing, 5)
                    .onTapGesture(perform: {
                        if (!inventoryDataModel.colorFlag){
                            if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                                return
                            }
                            inventoryDataModel.navigationTag = 1
                        }
                    })
                    HStack(alignment: .bottom, spacing: 20){
                        if inventoryDataModel.colorNumberId == -1{
                            Text("未選択")
                                .font(.light16)
                                .foregroundColor(.lightText)
                                .frame(width: 100, height: 100)
                                .border(Color(hex: "#707070"), width: 0.5)
                        }else{
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(hex: inventoryDataModel.colorCode))
                                .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                            
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("選択中の色")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                                .padding(.bottom, 2)
                            Text(inventoryDataModel.standardName != "該当なし" ? inventoryDataModel.standardName : "")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .lineSpacing(0)
                                .padding(.bottom, -6)
                            Text(inventoryDataModel.colorNumber)
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .lineSpacing(0)
                            Spacer()
                            CommonButton(text: "クリア",color: .secondary,width: 100, height: 28, disabled: inventoryDataModel.colorNumberId == -1, onClick: {
                                inventoryDataModel.colorNumberId = -1
                                inventoryDataModel.standardName = "_"
                                inventoryDataModel.colorNumber = ""
                            })
                        }
                        Spacer()
                    }
                    .frame(height: 105)
                    .background(Color.white)
                    .onTapGesture(perform: {
//                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
//                            return
//                        }
//                        inventoryDataModel.navigationTag = 1
                        
                    })
                    HStack {
                        CommonCheckBox(checked: $inventoryDataModel.colorFlag, width: 22, height: 22 )
                        Text("その他").font(.regular12).foregroundColor(.mainText)
                        if (inventoryDataModel.colorFlag){
                            TextField("", text: $inventoryDataModel.otherColorName)
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
                        ImageEditor(title: "材料画像", img: $inventoryDataModel.logo, showImagePicker: $shouldPresentActionScheet, imageDeleteSubject: Constants.IMG_DEL_SUBJECT_PAINT_NEW)
                        Spacer()
                    }
                }
                .padding(.horizontal, 21)
                VStack(spacing: 21){
                    CommonSelectField(label: "在庫数量（缶）", placeholder: "", required: true, onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.showAmountPicker = true
                    }, value: $inventoryDataModel.amount, validationMessage: inventoryDataModel.amountMessage)
                    CommonSelectField(label: "使用期限日", placeholder: "", onClick: {
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        inventoryDataModel.showDatePicker = true
                    }, value: $inventoryDataModel.expireDateStr, additionalMessage: "※「使用期限日」は製造年月日から2年後を入力してください")
                    CommonTextField(label: "ロット番号", placeholder: "", value: $inventoryDataModel.lotNumber,validationMessage: inventoryDataModel.lotNumberMessage)
                    HStack(spacing: 15) {
                        Text("公開設定")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    Toggle(isOn: $inventoryDataModel.inventoryPublic, label: {
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
                        Toggle(isOn: $inventoryDataModel.sellPublic, label: {
                            
                        }).disabled(inventoryDataModel.priceValue == "" && inventoryDataModel.sellPublic == false ? true : false)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 21)
                .padding(.bottom, 20)
                
                
                if (inventoryDataModel.selectedSell == 0) {
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
                        if (!inventoryDataModel.checkWarehouseList(mainViewDataModel: mainViewDataModel)) {
                            return
                        }
                        
                        let defaults = UserDefaults.standard
                        let isSkip = defaults.bool(forKey: Constants.IS_NOT_SKIP_PRECAUTIONS)
                        if !isSkip {
                            sellPrecautionsDataModel.show = true
                        }
                        inventoryDataModel.selectedSell = 1
                    })
                } else if (inventoryDataModel.selectedSell == 1) {
                    InventorySellSet(usedBy: 1)
                    .onAppear {

                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 21)
                }
                
                CommonButton(text: "登録", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    if inventoryDataModel.sellPublic == true && Int(inventoryDataModel.priceValue.filter{$0 != ","}) ?? 0 < 100 {
                        dialogsDataModel.showPriceNoti = true
                    }else{
                        inventoryDataModel.showNewConfirmDialog = true
                    }
                })
                .padding(.top, 50)
                .padding(.bottom, 30)
                .padding(.horizontal, 21)
                CommonButton(text: "クリア", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    inventoryDataModel.reset()
                    inventoryDataModel.selectedSell = 0
                })
                .padding(.bottom, 30)
                .padding(.horizontal, 21)
                Spacer(minLength: 100)
            }
            Spacer(minLength: 80)
        }.padding(.bottom, -70)
        if sellPrecautionsDataModel.show == true{
            SellPrecautionsView()
        }
        if from == 1 {
            InventoryWheelInputs()
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $inventoryDataModel.logo, sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
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
        .modal(isPresented: $inventoryDataModel.showPleaseRegisterWarehouseDialog) {
            ConfirmModal(showModal: $inventoryDataModel.showPleaseRegisterWarehouseDialog, text: "倉庫がありません\n倉庫の登録をしてください", onConfirm: {
                // go to「倉庫管理」
                dialogsDataModel.mainViewNavigationTag = 23
            }, confirmText: "倉庫登録する")
        }
        .modal(isPresented: $inventoryDataModel.showAskGroupOwnerToRegisterWarehouseDialog) {
            ErrorModal(showModal: $inventoryDataModel.showAskGroupOwnerToRegisterWarehouseDialog, text: "倉庫がありません\nグループオーナーに倉庫の登録を\n依頼してください", onConfirm: {})
        }
        .onAppear(perform: {
            debugPrintLog(message:"inventory appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            inventoryDataModel.initData(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
        })
    }
}
