//
//  PasswordReset.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/28/21.
//

import SwiftUI

struct PasswordReset: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var passwordResetDataModel: PasswordResetDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mailHasSendDataModel: MailHasSendDataModel
    
    var body: some View {
        
            VStack(spacing: 0) {
                Text("パスワード再設定")
                    .font(.bold27)
                    .foregroundColor(.secondary)
                    .padding(.top, 50)
                Text("ご登録のメールアドレス（ログインID）を\nご入力ください。\nご入力頂いたメールアドレスへ、\nパスワード再設定用のURLを送信します。")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .font(.regular14)
                    .foregroundColor(.mainText)
                    .padding(.top, 26)
                CommonTextField(label: "メールアドレス（ログインID）", placeholder: "", font: .medium20, color: .black, value: $passwordResetDataModel.email, validationMessage: passwordResetDataModel.emailMessage)
                    .padding(.top, 50)
                    .padding(.horizontal, 55)
                NavigationLink(
                    destination: MailHasSend(), tag: 1, selection: $passwordResetDataModel.navigationTag) {
                    EmptyView()
                }.isDetailLink(false)
                OvalButton(text: "送信", onClick:
                            {
                                passwordResetDataModel.sendResetRequest(dialogsDataModel: dialogsDataModel, mailHasSendDataModel: mailHasSendDataModel)
                            })
                    .padding(.top, 47)
                Image("paint-leaked")
                    .resizable()
                    .frame(width: 232, height: 168)
                    .padding(.top, 21)
                Text("ログインページへ戻る")
                    .font(.bold16)
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .onTapGesture(perform: {
                        presentationMode.wrappedValue.dismiss()
                    })
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
            .modal(isPresented: $dialogsDataModel.showErrorDialog) {
                ErrorModal(showModal: $dialogsDataModel.showErrorDialog, text: dialogsDataModel.errorMsg, onConfirm: {})
            }
            .onAppear(perform: {
                passwordResetDataModel.email = ""
            })
        
    }
}
