//
//  AccountManagement.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

struct AccountManagement: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var accountManagementDataModel: AccountManagementDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var chargeCancellationDataModel:ChargeCancellationDataModel
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    var from: Int = 0
    
    var body: some View {
        VStack {
            if from == 1{
                CommonHeader(title: "アカウント管理", showBackButton: true, onBackClick: {
                    dialogsDataModel.mainViewNavigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
            }else{
                CommonHeader(title: "アカウント管理")
            }
            ScrollView {
                VStack(spacing: 24) {
                    CommonTextField(label: "姓", placeholder: "", required: true, value: $accountManagementDataModel.lastName, validationMessage: accountManagementDataModel.lastNameMessage)
                    CommonTextField(label: "名", placeholder: "", required: true, value: $accountManagementDataModel.firstName, validationMessage: accountManagementDataModel.firstNameMessage)
                    CommonTextField(label: "電話番号", placeholder: "", required: true, value: $accountManagementDataModel.phone, validationMessage: accountManagementDataModel.phoneMessage)
                    MultilineTextField(label: "プロフィール", placeholder: "", height: 285, value: $accountManagementDataModel.profile, validationMessage: accountManagementDataModel.profileMessage)
                    HStack {
                        ImageEditor(title: "プロフィール画像", img: $accountManagementDataModel.profilePicture, showImagePicker: $shouldPresentActionScheet, imgHolder: Constants.profileHolderUIImage!, imageDeleteSubject: Constants.IMG_DEL_SUBJECT_ACC)
                        Spacer()
                    }

                    //required: xxxx=true? true :flase, showOptionalTag: xxxx=true? flase:true,
                    CommonTextField(label: "メールアドレス（ログインID）", placeholder: "", required: accountManagementDataModel.userBindtype == 2 ? false : true,value: $accountManagementDataModel.email ,showOptionalTag: accountManagementDataModel.userBindtype == 2 ? true:false, validationMessage: accountManagementDataModel.emailMessage, warningMessage: $accountManagementDataModel.email.wrappedValue.contains("@privaterelay.appleid.com") ? "※ このメールアドレスは一時的なものです。有効なアドレスに変更し、利用者への重要なメッセージなどを受け取れるようにしてください。" : "")
                    CommonSecureField(label: "パスワード", placeholder: "", showOptionalTag: true, font: .medium20, value: $accountManagementDataModel.password, validationMessage: accountManagementDataModel.passwordMessage)
                    CommonButton(text: "保存", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        accountManagementDataModel.updateUserInfoUploadImage(dialogsDataModel: dialogsDataModel, isFirstTime: mainViewDataModel.tabDisabled, mainViewDataModel: mainViewDataModel)
                    })
                    .padding(.top, 40)
                    .padding(.bottom, 16)
                    CommonButton(text: "ログアウト", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        accountManagementDataModel.showLogoutConfirmDialog = true
                    })
                    .padding(.bottom, 20)
                   
                    //課金解約
                    Group {
//                        if (dialogsDataModel.subscriptionDto?.status == "active"){
//                            HStack(spacing:0) {
//                                Text("解約希望の方は")
//                                    .font(.regular12)
//                                    .foregroundColor(Color(hex: "#8E8E8E"))
//
//                                Text("こちら")
//                                    .font(.regular12)
//                                    .foregroundColor(.primary)
//                                    .onTapGesture {
//
//                                        chargeCancellationDataModel.getSubscriptionEndtime(dialogsDataModel: dialogsDataModel)
//                                        dialogsDataModel.showChargeCancellationView = true
//                                    }
//                            }
//
//                        }else if(dialogsDataModel.subscriptionDto?.status == "suspend"){
//                            Text("ご契約期間満了日（\(DateTimeUtils.timestampToStrFormat(timestamp: dialogsDataModel.subscriptionDto!.endAt)) ）までご利用いただけます。")
//                                .font(.regular11)
//                                .foregroundColor(Color(hex: "#8E8E8E"))
//
//                        }
                        if (dialogsDataModel.showDeleteButton) {
                            HStack(spacing:0) {
                                Text("アカウント削除を希望の方は")
                                    .font(.regular12)
                                    .foregroundColor(Color(hex: "#8E8E8E"))
                                Text("こちら")
                                    .font(.regular12)
                                    .foregroundColor(.primary)
                                    .onTapGesture {
                                        dialogsDataModel.showConfirmAccountDeleteDialog = true
                                    }
                            }
                        }
                    }

                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom,140)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $accountManagementDataModel.profilePicture, sourceType: self.shouldPresentCamera ? .camera : .photoLibrary)
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
        .onAppear(perform: {
            debugPrintLog(message:"account appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            accountManagementDataModel.getUserInfo(dialogsDataModel: dialogsDataModel)
            accountManagementDataModel.getUserType(dialogsDataModel: dialogsDataModel)
            accountManagementDataModel.checkUserDeletable(dialogsDataModel: dialogsDataModel)
        })
    }
}
