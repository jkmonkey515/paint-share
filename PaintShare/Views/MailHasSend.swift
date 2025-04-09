//
//  MailHasSend.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/22.
//

import SwiftUI

struct MailHasSend: View {
    
    @EnvironmentObject var loginDataModel: LoginDataModel
    
    @EnvironmentObject var registerDataModel: RegisterDataModel
    
    @EnvironmentObject var passwordResetDataModel: PasswordResetDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mailHasSendDataModel: MailHasSendDataModel
    
    var body: some View {
        ScrollView {
            VStack{
                Image("paper-plane")
                    .renderingMode(.template)
                    .foregroundColor(.primary)
                    .padding(.top, 120)
                Text("メールを送信しました")
                    .font(.bold27)
                    .foregroundColor(.secondary)
                    .padding(.top, 45)
                VStack{
                    Text("ご入力頂いたメールアドレス")
                    Text("（\(mailHasSendDataModel.maskedEmail)）宛てに、")
                    Text("本人確認用のメールを送信いたしました。")
                    Text("メールをご確認の上、24時間以内に")
                        .padding(.top, 20)
                    Text("メール本文中のURLへアクセスいただくことで")
                    Text("本アプリのご利用が開始できます。")
                }
                .font(.regular14)
                .foregroundColor(.mainText)
                .padding(.top, 35)
                OvalButton(text: "閉じる", onClick:
                            {
                                dialogsDataModel.loginNavigationTag = nil
                                registerDataModel.navigationTag = nil
                                passwordResetDataModel.navigationTag = nil
                            })
                    .padding(.top, 48)
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onDisappear(perform: {
                mailHasSendDataModel.reset()
            })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
