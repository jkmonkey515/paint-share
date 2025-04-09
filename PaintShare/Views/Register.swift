//
//  Register.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct Register: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var registerDataModel: RegisterDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mailHasSendDataModel: MailHasSendDataModel
    
    @EnvironmentObject var agreementDataModel: AgreementDataModel
    
    @EnvironmentObject var privacyPolicyDataModel: PrivacyPolicyDataModel
    
    var body: some View {
      
            ScrollView {
                ZStack{
                    VStack{
                        Image("register-header-img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 1.4)
                            .blur(radius: 2.0)
                            .offset(y:-(UIScreen.main.bounds.width - 190))
                        Spacer()
                        Image("register-footer-img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 1.2)
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                    VStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(Color(.white).opacity(0.6))
                                .frame(width: UIScreen.main.bounds.width - 30, height: 65)
                                .shadow(color: Color(.black).opacity(0.16), radius: 3, x: 0, y: 3)
                            Text("アカウントの作成")
                                .font(.bold27)
                                .foregroundColor(.mainText)
                        }
                        .padding(.top, 78)
                        VStack{
                            Text("メールアドレス（ログインID）、パスワードを")
                            Text("入力してアカウントを作成してください。")
                        }
                        .multilineTextAlignment(.center)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .padding(.top, 74.0)
                        VStack(spacing: 18){
                            CommonTextField(label: "メールアドレス（ログインID）", placeholder: "", required: true,font: .medium20, value: $registerDataModel.email, validationMessage: registerDataModel.emailMessage)
                            CommonSecureField(label: "パスワード", placeholder: "", required: true,font: .medium20, value: $registerDataModel.password, validationMessage: registerDataModel.passwordMessage)
                            CommonSecureField(label: "パスワード（確認）", placeholder: "",required: true, font: .medium20, value: $registerDataModel.passwordConfirm, validationMessage: registerDataModel.passwordConfirmMessage)
                        }
                        .padding(.horizontal, 55)
                        .padding(.top, 27)
                        HStack(spacing: 0.0){
                            Spacer()
                            CommonCheckBox(checked: $registerDataModel.checked)
                                .padding(.top)
                            
                            VStack(alignment:.leading){
                                HStack(alignment:.top,spacing: 0.0){
                                    
                            Text("本システムの")
                                .padding(.leading, 14)
                            Text("利用規約")
                                .foregroundColor(.primary)
                                .onTapGesture(perform: {
                                    agreementDataModel.fromRegister = 1
                                })
                            Text("・")
                            Text("プライバシーポリシー")
                                .foregroundColor(.primary)
                                .onTapGesture(perform: {
                                    privacyPolicyDataModel.fromRegister = 1
                                })
                            //Spacer()
                                }
                                HStack(alignment:.top,spacing: 0.0){
                            Text("に同意します。")
                                        .padding(.leading, 14)
                                }
                                Spacer()
                        }
                        .padding(.top, 25)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                            
                            Spacer()
                        }
                        if (!registerDataModel.checkedMessage.isEmpty) {
                            Text(registerDataModel.checkedMessage)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .font(.bold12)
                                .foregroundColor(.caution)
                        }
                        Group {
                            NavigationLink(
                                destination: MailHasSend(), tag: 1, selection: $registerDataModel.navigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                            NavigationLink(
                                destination: Agreement(), tag: 1, selection: $agreementDataModel.fromRegister) {
                                EmptyView()
                            }.isDetailLink(false)
                            NavigationLink(
                                destination: PrivacyPolicy(), tag: 1, selection: $privacyPolicyDataModel.fromRegister) {
                                EmptyView()
                            }.isDetailLink(false)
                            NavigationLink(destination: EmptyView()) {
                                EmptyView()
                            }
                        }
                        OvalButton(text: "アカウントを作成", onClick:
                                    {
                                        registerDataModel.register(dialogsDataModel: dialogsDataModel, mailHasSendDataModel: mailHasSendDataModel)
                                    })
                            .padding(.top, 40)
                        VStack{
                            Text("既にアカウントをお持ちの方は")
                            HStack(spacing: 0.0){
                                GeneralButton(onClick: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("こちら")
                                        .font(.regular14)
                                        .foregroundColor(.primary)
                                })
                                Text("からログインしてご利用ください")
                            }
                        }
                        .padding(.top, 35)
                        .padding(.bottom, 80)
                        .multilineTextAlignment(.center)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        Spacer()
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .modal(isPresented: $dialogsDataModel.showErrorDialog) {
                ErrorModal(showModal: $dialogsDataModel.showErrorDialog, text: dialogsDataModel.errorMsg, onConfirm: {})
            }
            .onAppear(perform: {
                registerDataModel.reset()
            })

    }
}
