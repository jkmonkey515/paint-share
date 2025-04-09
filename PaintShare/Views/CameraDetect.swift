//
//  CameraDetect.swift
//  PaintShare
//
//  Created by Lee on 2022/5/24.
//

import SwiftUI
import StripeUICore

struct CameraDetect: View {
    
    @State var navigationTag: Int? = nil
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var cameraDetectDataModel: CameraDetectDataModel
    
    @EnvironmentObject var inventoryDataModel: InventoryDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @State private var shouldPresentImagePicker = false
    
    @State private var shouldPresentCamera = false
    
    @State private var queueName = ["選択", "登録", "検索", "登録", "検索","画像解析"]
    
    @State private var type = 0
    
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: queueName[cameraDetectDataModel.changeQueue])
            ScrollView {
                if (cameraDetectDataModel.changeQueue == 0) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height - 300)
                            .padding(.top, 40)
                        VStack(alignment: .center, spacing: 50){
                            Image(uiImage: UIImage(named: "app-icon")!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipped()
                            VStack{
                                Text("撮影で在庫の登録または")
                                .font(.medium16)
                                .foregroundColor(Color(hex: "#46747E"))
                                .frame(width: UIScreen.main.bounds.size.width - 140)
                                Text("検索を行えます")
                                .font(.medium16)
                                .foregroundColor(Color(hex: "#46747E"))
                                .frame(width: UIScreen.main.bounds.size.width - 140)
                            }.padding(.top, -20)
                            CommonButton(text: "在庫を登録する", width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                if inventoryDataModel.groupPickList.count == 1 && inventoryDataModel.adressPickList.count == 1 && inventoryDataModel.groupValue != "" && inventoryDataModel.adressValue != "" {
                                    cameraDetectDataModel.changeQueue = 5
                                    cameraDetectDataModel.showCameraNoti = true
                                }else{
                                    cameraDetectDataModel.changeQueue = 1
                                }
                                type = 1
                            })
                            CommonButton(text: "在庫を検索する", color: Color(hex: "#5686C4"), width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                if inventoryDataModel.groupPickList.count == 1 {
                                    cameraDetectDataModel.changeQueue = 2
                                }else{
                                    cameraDetectDataModel.changeQueue = 2
                                }
                                type = 2
                            })
                            .padding(.bottom, 30)
                        }
                    }
                    
                } else if (cameraDetectDataModel.changeQueue == 1) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height - 300)
                            .padding(.top, 40)
                        VStack(alignment: .center, spacing: 30){
                            CommonSelectField(label: "登録先グループ", placeholder: "", required: true, onClick: {
                                inventoryDataModel.showPicker = true
                                inventoryDataModel.pickListId = 3
                                inventoryDataModel.setPackList(pickListId: 3)
                            }, value: $inventoryDataModel.groupValue,validationMessage: inventoryDataModel.groupValue == "" ? "グループを選択してください" : "")
                            .padding(.top, 70)
                            .frame(width: UIScreen.main.bounds.size.width - 140)
                            CommonSelectField(label: "倉庫", placeholder: "", required: true, onClick: {
                                inventoryDataModel.showPicker = true
                                inventoryDataModel.pickListId = 4
                                inventoryDataModel.setPackList(pickListId: 4)
                            }, value: $inventoryDataModel.adressValue, validationMessage: inventoryDataModel.adressValue == "" ? "倉庫を選択してください" : "")
                            .frame(width: UIScreen.main.bounds.size.width - 140)
                            Spacer()
                            CommonButton(text: "次のステップ", color: (inventoryDataModel.groupValue == "" || inventoryDataModel.adressValue == "") ? Color(hex:"#E0E0E0") : Color.primary, width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                if inventoryDataModel.groupValue == "" || inventoryDataModel.adressValue == "" {
                                    return
                                }
                                cameraDetectDataModel.changeQueue = 5
                                cameraDetectDataModel.showCameraNoti = true
                            })
                            CommonButton(text: "戻る", color: Color.caution, width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                cameraDetectDataModel.changeQueue = 0
                            })
                            .padding(.bottom, 30)
                        }
                    }
                } else if (cameraDetectDataModel.changeQueue == 2) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height - 300)
                            .padding(.top, 40)
                        VStack(alignment: .center, spacing: 30){
                            CommonSelectField(label: "検索対象グループ", placeholder: "", required: true, onClick: {
                                inventoryDataModel.showPicker = true
                                inventoryDataModel.pickListId = 3
                                inventoryDataModel.setPackList(pickListId: 3)
                            }, value: $inventoryDataModel.groupValue,validationMessage: inventoryDataModel.groupValue == "" ? "グループを選択してください" : "")
                            .padding(.top, 70)
                            .frame(width: UIScreen.main.bounds.size.width - 140)
                            Spacer()
                            CommonButton(text: "次のステップ", color: inventoryDataModel.groupValue == "" ? Color(hex: "#E0E0E0") : Color.primary, width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                if inventoryDataModel.groupValue == ""{
                                    return
                                }
                                cameraDetectDataModel.changeQueue = 5
                                cameraDetectDataModel.showCameraNoti = true
                            })
                            CommonButton(text: "戻る", color: Color.caution, width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                cameraDetectDataModel.changeQueue = 0
                            })
                            .padding(.bottom, 30)
                        }
                    }
                } else if (cameraDetectDataModel.changeQueue == 3) {
                    VStack(alignment: .center, spacing: 0){
                        Image(uiImage: cameraDetectDataModel.profilePicture!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipped()
                            .padding(.top, 30)
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "#E9FCFF"))
                                .frame(width: 340, height: 63)
                            VStack{
                                Text("以下の結果が出ました")
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#46747E"))
                                Text("当てはまるものをご選択ください")
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#46747E"))
                            }
                        }.padding(.top, 30)
                        /*
                        HStack{
                            Text("解析結果：")
                                .font(.bold20)
                                .foregroundColor(Color(hex: "#46747E"))
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.size.width - 45)
                        .padding(.top, 30)
                         */
                        Group{
                            if cameraDetectDataModel.makerListItems.count != 0 {
                                HStack{
                                    Text("メーカー")
                                        .font(.bold16)
                                        .foregroundColor(Color(hex: "#46747E"))
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.size.width - 45)
                                .padding(.top, 30)
                                ForEach(0 ..< cameraDetectDataModel.makerListItems.count, id: \.self) {
                                    i in
                                    CameraDetectItem(type:1, num:i, cameraItem: cameraDetectDataModel.makerListItems[i] as! String)
                                        .underlineListItem()
                                        .frame(width: UIScreen.main.bounds.size.width - 45)
                                }
                            }
                            if cameraDetectDataModel.nameListItems.count != 0 {
                                HStack{
                                    Text("商品名")
                                        .font(.bold16)
                                        .foregroundColor(Color(hex: "#46747E"))
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.size.width - 45)
                                .padding(.top, 30)
                                ForEach(0 ..< cameraDetectDataModel.nameListItems.count, id: \.self) {
                                    i in
                                    CameraDetectItem(type:2, num:i, cameraItem: cameraDetectDataModel.nameListItems[i] as! String)
                                        .underlineListItem()
                                        .frame(width: UIScreen.main.bounds.size.width - 45)
                                }
                            }
                            if cameraDetectDataModel.useListItems.count != 0{
                                HStack{
                                    Text("用途区分")
                                        .font(.bold16)
                                        .foregroundColor(Color(hex: "#46747E"))
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.size.width - 45)
                                .padding(.top, 30)
                                ForEach(0 ..< cameraDetectDataModel.useListItems.count, id: \.self) {
                                    i in
                                    CameraDetectItem(type:3, num:i,cameraItem: cameraDetectDataModel.useListItems[i] as! String)
                                        .underlineListItem()
                                        .frame(width: UIScreen.main.bounds.size.width - 45)
                                }
                            }
                            if cameraDetectDataModel.colorListItems.count != 0{
                                HStack{
                                    Text("色")
                                        .font(.bold16)
                                        .foregroundColor(Color(hex: "#46747E"))
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.size.width - 45)
                                .padding(.top, 30)
                                ForEach(0 ..< cameraDetectDataModel.colorListItems.count, id: \.self) {
                                    i in
                                    CameraDetectItem(type:4, num:i,cameraItem: cameraDetectDataModel.colorListItems[i] as! String)
                                        .underlineListItem()
                                        .frame(width: UIScreen.main.bounds.size.width - 45)
                                }
                            }
                        }
                        Group{
                            CommonButton(text: "在庫登録へ", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                inventoryDataModel.logo = cameraDetectDataModel.profilePicture
                                cameraDetectDataModel.navigationTag = 1
                            })
                            .padding(.top, 30)
                            CommonButton(text: "戻る", color: Color.caution, width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                cameraDetectDataModel.changeQueue = 5
                            })
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                            
                            NavigationLink(
                                destination: Inventory(from: 1), tag: 1, selection: $cameraDetectDataModel.navigationTag) {
                                    EmptyView()
                                }.isDetailLink(false)
                        }
                    }
                } else if (cameraDetectDataModel.changeQueue == 4) {
                    VStack(alignment: .center, spacing: 0){
                        Image(uiImage: cameraDetectDataModel.profilePicture!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 130, height: 130)
                            .clipped()
                            .padding(.top, 30)
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "#E9FCFF"))
                                .frame(width: 340, height: 63)
                            VStack{
                                Text("以下の結果が出ました")
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#46747E"))
                                Text("当てはまるものをご選択ください")
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#46747E"))
                            }
                        }.padding(.top, 30)
                        HStack{
                            Text("検索結果：\(cameraDetectDataModel.cameraListItems.count)件")
                                .font(.bold20)
                                .foregroundColor(Color(hex: "#46747E"))
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.size.width - 45)
                        .padding(.top, 30)
                        ForEach(cameraDetectDataModel.cameraListItems) {
                            item in
                            CameraSearchItem(cameraListItem: item)
                                .underlineListItem()
                                .frame(width: UIScreen.main.bounds.size.width - 45)
                                .onTapGesture {
                                    inventoryInquiryDataModel.initData(id: item.id, dialogsDataModel: dialogsDataModel)
                                    cameraDetectDataModel.navigationTag = 2
                                }
                        }
                        NavigationLink(
                            destination: InventoryInquiry(from:2), tag: 2, selection: $cameraDetectDataModel.navigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        NavigationLink(destination: EmptyView()) {
                            EmptyView()
                        }
                        Group{
                            CommonButton(text: "戻る", color: Color.caution, width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                cameraDetectDataModel.changeQueue = 5
                            })
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                        }
                    }
                } else if (cameraDetectDataModel.changeQueue == 5) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height - 300)
                            .padding(.top, 40)
                        VStack(spacing: 30){
                            Image(uiImage: cameraDetectDataModel.profilePicture!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.size.width - 160, height: UIScreen.main.bounds.size.width - 160)
                                .clipped()
                                .padding(.top, 70)
                            Spacer()
                            CommonButton(text: cameraDetectDataModel.profilePicture == Constants.imageHolderUIImage! ? "撮影する" : "変更する", width: UIScreen.main.bounds.size.width - 140, height: 37, picture: "camera", isHavePicture: true, onClick: {
                                cameraDetectDataModel.shouldPresentActionScheet = true
                            })
                            CommonButton(text: "この画像を解析", color: cameraDetectDataModel.profilePicture == Constants.imageHolderUIImage! ? Color(hex: "#E0E0E0") : Color(hex: "#56A3C4"), width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                if cameraDetectDataModel.profilePicture != Constants.imageHolderUIImage {
                                    if type == 1 {
                                        cameraDetectDataModel.makerListItems.removeAll()
                                        cameraDetectDataModel.useListItems.removeAll()
                                        cameraDetectDataModel.colorListItems.removeAll()
                                        cameraDetectDataModel.nameListItems.removeAll()
                                        cameraDetectDataModel.getListData(id: inventoryDataModel.groupKey == -1 ? 0 : inventoryDataModel.groupKey, type: type,dialogsDataModel: dialogsDataModel)
                                    }else if type == 2{
                                        cameraDetectDataModel.getListData(id: inventoryDataModel.groupKey == -1 ? 0 : inventoryDataModel.groupKey, type: type,dialogsDataModel: dialogsDataModel)
                                    }
                                }
                            })
                            CommonButton(text: "戻る", color: Color.caution, width: UIScreen.main.bounds.size.width - 140, height: 37, onClick: {
                                cameraDetectDataModel.profilePicture = Constants.imageHolderUIImage
                                cameraDetectDataModel.changeQueue = 0
                            })
                            .padding(.bottom, 30)
                        }
                    }
                }
            Spacer()
            }
        }
        VStack{
            if cameraDetectDataModel.shut == true {
                Text("解析中...")
                    .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height - 300)
                    .foregroundColor(Color.white)
                    .font(.bold40)
                    .background(Color(hex: "707070").opacity(0.30))
            }else{
                        
            }
        }
        }
        .sheet(isPresented: $shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $cameraDetectDataModel.profilePicture, from: 1, sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
        }
        .actionSheet(isPresented: $cameraDetectDataModel.shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("選択してください"), buttons: [ActionSheet.Button.default(Text("カメラ"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("写真ライブラリ"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
        .onAppear {
            inventoryDataModel.initData(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
        }
        .onDisappear {
            //cameraDetectDataModel.changeQueue = 0
            //cameraDetectDataModel.reset()
        }
    }
}

