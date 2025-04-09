//
//  ManagerView.swift
//  PaintShare
//
//  Created by Lee on 2022/12/23.
//

import SwiftUI

struct ManagerView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var managerViewDataModel: ManagerViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: "振込先口座情報", showBackButton: true, showHamburgerButton:false, onBackClick: {
                self.presentationMode.wrappedValue.dismiss()
            })
            ScrollView {
                VStack{
                    Group{
                    Text("売上金のお振込み先口座をご登録ください")
                        .font(.bold15)
                        .foregroundColor(Color(hex: "#46747E"))
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    
                    Text("ご入力内容はお間違いの無い様お願いいたします。\n入力内容に誤りがあった場合、お振込みができなくなる可能性があります。")
                        .font(.bold13)
                        .foregroundColor(Color(hex: "##545353"))
                        .padding(.horizontal, 21)
                        //.padding(.top, 0)
                        .padding(.bottom, 15)
                    }
                    Group{
                    CircleTextField(label: "銀行名", placeholder: "みずほ銀行", required: true, value: $managerViewDataModel.bankName,validationMessage: managerViewDataModel.bankNameMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    CircleTextField(label: "銀行コード", placeholder: "0123456789", required: true, value: $managerViewDataModel.bankCode,validationMessage: managerViewDataModel.bankCodeMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    CircleTextField(label: "支店名", placeholder: "東京支店", required: true, value: $managerViewDataModel.branchName,validationMessage: managerViewDataModel.branchNameMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    CircleTextField(label: "支店コード", placeholder: "0123456789", required: true, value: $managerViewDataModel.branchCode,validationMessage: managerViewDataModel.branchCodeMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                        
                        HStack{
                            CommonSelectField(label:"預金種目", placeholder: "普通預金",required: true,font:.regular13, onClick: {
                                //managerViewDataModel.depositTypeKey = -1
                                managerViewDataModel.showDepositTypePick = true
                            }, value: $managerViewDataModel.depositType,validationMessage: managerViewDataModel.depositTypeCodeMessage)
                                .frame(width: UIScreen.main.bounds.size.width/2 )
                                //.padding(.leading)
                            
                            Spacer()
                            
                    //CircleTextField(label: "預金種目", placeholder: "普通預金", required: true, value: $managerViewDataModel.depositType,validationMessage: managerViewDataModel.depositTypeMessage)
                        }
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)//
                    CircleTextField(label: "口座番号", placeholder: "12345678910", required: true, value: $managerViewDataModel.accountNo,validationMessage: managerViewDataModel.accountNoMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    CircleTextField(label: "口座名義", placeholder: "ヤマダ　タロウ", required: true, value: $managerViewDataModel.accountName,validationMessage: managerViewDataModel.accountNameMessage)
                        .padding(.horizontal, 21)
                        .padding(.bottom, 10)
                    }
                    
                    CommonButton(text: "登録する", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        //managerViewDataModel.showSavedManagerInfoDialog = true
                       // managerViewDataModel.showSavedDialog = true
                        managerViewDataModel.validManagerInfo(dialogsDataModel: dialogsDataModel)
                    })
                    .padding(.top, 38)
                    .padding(.bottom, 38)
                    CommonButton(text: "戻る", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
//                        if(managerViewDataModel.fromOrderListView == true){
//                            dialogsDataModel.mainViewNavigationTag = 14
//                            managerViewDataModel.fromOrderListView == false
//                        }else{
                        presentationMode.wrappedValue.dismiss()
                       // }
                    })
                    .padding(.bottom, 180)
                    
                    Spacer()
                }
            }
        }
            //定型文 pick
            if managerViewDataModel.showDepositTypePick{
                VStack{
                    CommonPicker(selection:$managerViewDataModel.depositTypeKey,pickList: managerViewDataModel.depositTypeList,onCancel:{
                        managerViewDataModel.showDepositTypePick = false
                    },onCompleted: {
                        managerViewDataModel.setPickValue(pickId: managerViewDataModel.depositTypeKey)
                        managerViewDataModel.showDepositTypePick = false
                    })
                    if managerViewDataModel.addBottom {
                        Spacer(minLength: 80)
                    }
                }
            }
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
    }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
