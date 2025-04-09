//
//  GroupInfoChange.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/14/21.
//

import SwiftUI

struct GroupInfoChange: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var groupInfoChangeDataModel: GroupInfoChangeDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var memberManagementDataModel: MemberManagementDataModel
    
    @EnvironmentObject var warehouseDataModel: WarehouseDataModel
    
    @EnvironmentObject var mapSearchDataModel: MapSearchDataModel
    
    @EnvironmentObject var warehouseInfoChangeDataModel: WarehouseInfoChangeDataModel
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var from: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if from == 1 {
                    CommonHeader(title: "グループ変更", showBackButton: true, onBackClick: {
                        dialogsDataModel.mainViewNavigationTag = nil
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }else if from == 2{
                    CommonHeader(title: "グループ作成", showBackButton: true, onBackClick: {
                        dialogsDataModel.mainViewNavigationTag = nil
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }
                Group {
                    CommonTextField(label: "グループ名", placeholder: "", required: true, value: $groupInfoChangeDataModel.groupName, validationMessage: groupInfoChangeDataModel.groupNameMessage)
                    CommonTextField(label: "グループオーナー", placeholder: "", required: true, value: $groupInfoChangeDataModel.groupOwnerName, disabled: true)
                    HStack {
                        Text("※アカウントの姓名が自動的に設定されます")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.top, -15)
                    CommonTextField(label: "電話番号", placeholder: "", required: true, value: $groupInfoChangeDataModel.phone, validationMessage: groupInfoChangeDataModel.phoneMessage)
                    MultilineTextField(label: "グループの説明", placeholder: "", required: true, value: $groupInfoChangeDataModel.description, validationMessage: groupInfoChangeDataModel.descriptionMessage)
                }
                HStack {
                    ImageEditor(title: "グループ画像", img: $groupInfoChangeDataModel.logo, showImagePicker: $shouldPresentActionScheet, imageDeleteSubject: Constants.IMG_DEL_SUBJECT_GRP)
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Group {
                    HStack(spacing:0){
                        CommonTextField(label: "郵便番号", placeholder: "",value: $groupInfoChangeDataModel.zipcode, showOptionalTag: true, validationMessage: groupInfoChangeDataModel.zipcodeMessage)
                            .frame(width: 150)
                            .padding(.leading,0)
                        
                        Text("地図から検索")//TradingLocationSelection
                            .font(.regular11)
                            .foregroundColor(.primary)
                            .padding(.top,-22)
                            .padding(.leading,-30)
                            .onTapGesture {
                                //mapSearchDataModel.searchPhrase = "\(groupInfoChangeDataModel.zipcode) \(groupInfoChangeDataModel.prefValue) \(groupInfoChangeDataModel.municipalitieName) \(groupInfoChangeDataModel.addressName)".trimmingCharacters(in: .whitespaces)
                                groupInfoChangeDataModel.needNotAppearRefresh = true
                                groupInfoChangeDataModel.navigationTag = 8
                            }
                        
                        NavigationLink(
                            destination: TradingLocationSelection(usedBy: 2), tag: 8, selection:$groupInfoChangeDataModel.navigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                        
                        Spacer()
                    }
                    //
                    HStack(spacing:0){
                        CommonSelectField(label: "都道府県", placeholder: "",onClick: {
                            groupInfoChangeDataModel.prefKey = -1
                            groupInfoChangeDataModel.showPrefPick = true
                        },value:$groupInfoChangeDataModel.prefValue)
                        .frame(width: 150)
                        .padding(.leading,0)
                        
                        OptionalLabel()
                            .padding(.top,-25)
                            .padding(.leading,-87)
                        
                        Spacer()
                    }
                    
                    CommonTextField(label: "市区町村", placeholder: "", value: $groupInfoChangeDataModel.municipalitieName, showOptionalTag: true, validationMessage:groupInfoChangeDataModel.municipalitieNameMessage )
                    CommonTextField(label: "番地", placeholder: "", value: $groupInfoChangeDataModel.addressName, showOptionalTag: true, validationMessage:groupInfoChangeDataModel.addressNameMessage)
                }
          
                HStack(spacing: 15) {
                    Text("公開設定")
                        .font(.regular12)
                        .foregroundColor(.mainText)
                    RequiredLabel()
                    Spacer()
                }
                Toggle(isOn: $groupInfoChangeDataModel.groupPublic, label: {
                    HStack(spacing: 15) {
                        Text("グループを公開する")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                        TooltipLabel()
                            .onTapGesture(perform: {
                                dialogsDataModel.tooltipTitle = "グループを公開する"
                                dialogsDataModel.tooltipDescription = "グループを公開すると当グループが本アプリの全てのユーザーから検索できるようになります。"
                                dialogsDataModel.tooltipDialog = true
                            })
                    }
                })
                Toggle(isOn: $groupInfoChangeDataModel.goodsPublic, label: {
                    HStack(spacing: 15) {
                        Text("共有可在庫を公開する")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                        TooltipLabel()
                            .onTapGesture(perform: {
                                dialogsDataModel.tooltipTitle = "共有可在庫を公開する"
                                dialogsDataModel.tooltipDescription = "こちらをONにしても全ての在庫が共有される訳ではありません。登録された在庫のうち公開設定されている在庫のみが共有されます。"
                                dialogsDataModel.tooltipDialog = true
                            })
                    }
                })
                .padding(.bottom, 30)
                Rectangle().frame(height: 2).foregroundColor(Color(hex: "e0e0e0"))
                if (mainViewDataModel.loggedInUserGroup != nil) {
                    HStack {
                        VStack {
                            Text("メンバー管理")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                                .padding(.leading, -20)
                            Text("（メンバー／フレンド）")
                                .font(.light10)
                                .foregroundColor(.mainText)
                        }
                        Spacer()
                        Text("\(groupInfoChangeDataModel.numberOfJoined)人／\(groupInfoChangeDataModel.numberOfShared)人")
                            .font(.medium20)
                            .foregroundColor(.mainText)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.subText)
                            .font(.bold20)
                    }
                    .padding(.bottom, 20)
                    .underlineTextField()
                    .onTapGesture(perform: {
                        memberManagementDataModel.groupId = mainViewDataModel.loggedInUserGroup!.id
                        groupInfoChangeDataModel.navigationTag = 1
                    })
                    HStack {
                        VStack {
                            Text("倉庫管理")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Text("（登録件数）")
                                .font(.light10)
                                .foregroundColor(.mainText)
                        }
                        Spacer()
                        Text("\(warehouseDataModel.count)件")
                            .font(.medium20)
                            .foregroundColor(.mainText)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.subText)
                            .font(.bold20)
                    }
                    .padding(.bottom, 20)
                    .underlineTextField()
                    .onTapGesture(perform: {
                        groupInfoChangeDataModel.navigationTag = 3
                    })
//                    NavigationLink(
//                       destination: WarehouseManagement(), tag: 3, selection: $groupInfoChangeDataModel.navigationTag) {
//                        EmptyView()
//                    }.isDetailLink(false)
                    
                }
                Group {
                    CommonButton(text: "保存", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        groupInfoChangeDataModel.saveGroupUploadImage(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel, groupManagementDataModel: groupManagementDataModel)
                    })
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    if (mainViewDataModel.loggedInUserGroup == nil) {
                        CommonButton(text: "クリア", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                            groupInfoChangeDataModel.groupName = ""
                            groupInfoChangeDataModel.phone = ""
                            groupInfoChangeDataModel.description = ""
                            groupInfoChangeDataModel.logo = Constants.imageHolderUIImage!
                            groupInfoChangeDataModel.groupPublic = false
                            groupInfoChangeDataModel.goodsPublic = false
                        })
                    } else {
                        CommonButton(text: "キャンセル", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                            //groupInfoChangeDataModel.setGroupInfo(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                            groupManagementDataModel.selectedTab = 0
                        })
                        HStack(spacing:0) {
                            Text("グループ削除を希望の方は")
                                .font(.regular12)
                                .foregroundColor(Color(hex: "#8E8E8E"))
                            Text("こちら")
                                .font(.regular12)
                                .foregroundColor(.primary)
                                .onTapGesture {
                                    dialogsDataModel.showConfirmGroupDeleteDialog = true
                                }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 140)
        }
        .sheet(isPresented: $shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $groupInfoChangeDataModel.logo, sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
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
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            debugPrintLog(message:"group change appear")
            
            if (mainViewDataModel.loggedInUserGroup != nil) {
                warehouseDataModel.groupId = mainViewDataModel.loggedInUserGroup!.id
                warehouseDataModel.searchFromZeroPage(dialogsDataModel: dialogsDataModel)
            }
            
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            if groupInfoChangeDataModel.needNotAppearRefresh == false {
                groupInfoChangeDataModel.setGroupInfo(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
            }else{
                groupInfoChangeDataModel.needNotAppearRefresh = false
            }
        })
    }
}
