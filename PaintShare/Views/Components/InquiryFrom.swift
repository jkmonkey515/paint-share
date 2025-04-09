//
//  InquiryFrom.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/15.
//

import SwiftUI

struct InquiryFrom: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var dialogsDataModel:DialogsDataModel
    
    var body: some View {

        ZStack {
            VStack(spacing:0){
                    CommonHeader(title: "問い合わせ", showBackButton:(inquiryFromDataModel.showInquiryContentPick != false || inquiryFromDataModel.showFixedPhrasesPick != false) ? false : true,showHamburgerButton: false, onBackClick: {
                      presentationMode.wrappedValue.dismiss()
                    })
                    
                    ZStack{
                        Color(hex: "#F1F1F1")
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack{
                            HStack{
                                CommonSelectField(label: "", placeholder: "問い合わせ内容（必須）", onClick: {
                                    inquiryFromDataModel.inquiryContentPickKey = -1
                                    inquiryFromDataModel.showInquiryContentPick = true
                                },value: $inquiryFromDataModel.inquiryContentPickValue,validationMessage: inquiryFromDataModel.inquiryContentMessage)
                                    .padding(.leading)
                            }
                            .frame(height: 50)
                            .background(Color.white)
                            .padding(.top,50)
                            
                            if(  inquiryFromDataModel.inquiryContentPickValue != "" && inquiryFromDataModel.inquiryContentPickKey == 0 ){
                                HStack{
                                    CommonTextField(label: "報告をしたいユーザーID・グループID・取引ID", placeholder: "",value: $inquiryFromDataModel.reportId, validationMessage: inquiryFromDataModel.reportIdMessage)
                                        .padding(.leading)
                                        .frame(height: 80)
                                        .background(Color.white)
                                }
                                .padding(.top,25)
                            }
                            
                            HStack{
                                MultilineTextField(label:" 報告内容自由記載エリア", placeholder: "本文(500文字以内)：", value: $inquiryFromDataModel.description, validationMessage: inquiryFromDataModel.descriptionMessage)
                                    .padding(.leading)
                            }
                            .frame(height: 200)
                            .background(Color.white)
                            //  .padding(.top,25)
                            .padding(.top,inquiryFromDataModel.inquiryContentPickKey == 0 ? 25:50)
                            .padding(.leading,0)
                            
                            HStack{
                                CommonSelectField(label:" 定型文を使う", placeholder: "",onClick: {
                                    if inquiryFromDataModel.description == "" {
                                        inquiryFromDataModel.fixedPhrasesKey = -1
                                        inquiryFromDataModel.showFixedPhrasesPick = true
                                    }else{
                                        inquiryFromDataModel.showCoverNoti = true
                                    }
                                }, value: $inquiryFromDataModel.fixedPhrasesValue)
                                    .frame(width: 180)
                                    .padding(.leading)
                                    .disabled(inquiryFromDataModel.inquiryContentPickKey == 2 || inquiryFromDataModel.inquiryContentPickKey == 3 ? true : false)
                                
                                Spacer()
                            }
                            .padding(.top,10)
                            
                            Spacer()

                            Text("ご入力いただいた内容は今後のサービス改善の参考にさせていただきます。内容に関しては事務局で全て確認していますが、返信は行っておりません。")
                                .font(.regular12)
                                .foregroundColor(Color(hex: "#8E8E8E"))
                                .frame(width: UIScreen.main.bounds.size.width - 40)
                                .padding(.bottom, 20)
                            
//                            CommonButton(text: "送信", width:  UIScreen.main.bounds.size.width - 40, height: 37,disabled:inquiryFromDataModel.sendDisabled(), onClick: {
                                
                                CommonButton(text: "送信", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                inquiryFromDataModel.sendMessage(dialogsDataModel: dialogsDataModel)
                                
                                })
                                .padding(.bottom, 60)
                        }
                        
                        //問い合わせ内容 pick
                        if inquiryFromDataModel.showInquiryContentPick{
                            VStack{
                                CommonPicker(selection:$inquiryFromDataModel.inquiryContentPickKey,pickList: inquiryFromDataModel.inquiryContent,onCancel:{
                                    inquiryFromDataModel.showInquiryContentPick = false
                                },onCompleted: {
                                    inquiryFromDataModel.setInquiryContentPickValue()
                                    inquiryFromDataModel.showInquiryContentPick = false
                                })
                                if inquiryFromDataModel.addBottom {
                                    Spacer(minLength: 80)
                                }
                            }
                        }
                        
                        //定型文 pick
                        if inquiryFromDataModel.showFixedPhrasesPick{
                            VStack{
                                CommonPicker(selection:$inquiryFromDataModel.fixedPhrasesKey,pickList: inquiryFromDataModel.fixedPhrases,onCancel:{
                                    inquiryFromDataModel.showFixedPhrasesPick = false
                                },onCompleted: {
                                    inquiryFromDataModel.setFixedPhrasesValue()
                                    inquiryFromDataModel.showFixedPhrasesPick = false
                                })
                                if inquiryFromDataModel.addBottom {
                                    Spacer(minLength: 80)
                                }
                            }
                        }
                        
                    }
                    
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            
            .modal(isPresented: $inquiryFromDataModel.showCoverNoti) {
                ConfirmModal(showModal: $inquiryFromDataModel.showCoverNoti, text: "上書きしても\nよろしいですか？", onConfirm: {
                    inquiryFromDataModel.description = ""
                })
            }
            
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}


