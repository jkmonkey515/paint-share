//
//  OrderRegardView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/24.
//

import SwiftUI

struct OrderRegardView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var orderRegardDataModel: OrderRegardDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: "注文詳細", showBackButton: true, showHamburgerButton: false, onBackClick: {
                orderRegardDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            ScrollView{
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: "#E9FCFF"))
                        .frame(width: UIScreen.main.bounds.size.width - 34, height: 90)
                    VStack{
                        HStack{
                            CommonSelectField(label: "受け渡し予定日を登録する", labelFont: .medium16, labelTextColor: Color(hex: "#46747E"), placeholder: "選択する",onClick: {
                                orderRegardDataModel.showDatePicker = true
                            },value:$orderRegardDataModel.expireDateStr)
                                .frame(width: 200)
                                .padding(.leading,0)
                            Spacer()
                            LabelButton(text: "更新", color: Color(hex: "#1DB78B"), onClick: {
                                if orderRegardDataModel.paintWeight == "0" {
                                    orderRegardDataModel.showWeightNoti = true
                                }else{
                                    orderRegardDataModel.updateNotiType = 1
                                    orderRegardDataModel.showUpdataNoti = true
                                }
                            })
                        }.padding(.bottom, 10)
                    }.padding(.horizontal, 21 + 21)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: "#E9FCFF"))
                        .frame(width: UIScreen.main.bounds.size.width - 34, height: 90)
                    VStack{
                        HStack{
                            CommonSelectField(label: "受け渡し状況を更新する", labelFont: .medium16, labelTextColor: Color(hex: "#46747E"), placeholder: "選択する",onClick: {
                                orderRegardDataModel.showPicker = true
                                orderRegardDataModel.pickListId = 0
                                orderRegardDataModel.setPackList(pickListId: 0)
                            },value:$orderRegardDataModel.payValue)
                                .frame(width: 200)
                                .padding(.leading,0)
                            Spacer()
                            LabelButton(text: "更新", color: Color(hex: "#1DB78B"), onClick: {
                                if orderRegardDataModel.paintWeight == "0" {
                                    orderRegardDataModel.showWeightNoti = true
                                }else{
                                    orderRegardDataModel.updateNotiType = 2
                                    orderRegardDataModel.showUpdataNoti = true
                                }
                            })
                        }.padding(.bottom, 10)
                    }.padding(.horizontal, 21 + 21)
                }
                ImageView(withURL: orderRegardDataModel.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + orderRegardDataModel.materialImgKey!, onClick: {
                    img in
                }).frame(width: 130, height: 130)
                    .clipped()
                    .padding(.top, 32)
                VStack(spacing: 21){
                    CommonTextField(label: "グループ", placeholder: "",value: $orderRegardDataModel.groupName,disabled: true)
                    CommonTextField(label: "倉庫", placeholder: "",value: $orderRegardDataModel.warehouseName,disabled: true)
                    CommonTextField(label: "メーカー", placeholder: "",value: $orderRegardDataModel.makerName,disabled: true)
                    CommonTextField(label: "商品名", placeholder: "", value: $orderRegardDataModel.goodName, disabled: true)
                    CommonTextField(label: "用途区分", placeholder: "", value: $orderRegardDataModel.useCategoryValue, disabled: true)
                    HStack{
                        Text("色")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.trailing, 5)
                    HStack(alignment: .bottom, spacing: 20){
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color(hex: orderRegardDataModel.colorCode))
                            .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                        VStack(alignment: .leading,spacing: 3){
                            Spacer()
                            /*
                            Text(orderRegardDataModel.colorName != "該当なし" ? orderRegardDataModel.colorName : "")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                             */
                            Text(orderRegardDataModel.colorName)
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .padding(.bottom, 5)
                        }
                        Spacer()
                    }
                    .frame(height: 105)
                    .padding(.bottom, 20)
                    .underlineTextField()
                }
                .padding(.horizontal, 21)
                VStack(spacing: 21){
                    CommonTextField(label: "在庫数量（缶）", placeholder: "", value: $orderRegardDataModel.paintNum, disabled: true)
                    VStack(alignment: .leading, spacing: 10){
                        Text("重量（㎏）")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        HStack{
                            TextField("",text: $orderRegardDataModel.paintWeight)
                                .padding(.bottom, 2)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .font(.medium16)
                                .foregroundColor(.mainText)
                                .border(Color(hex: "#56B8C4"), width: 1)
                                .frame(width: 78, height: 30)
                                .keyboardType(.decimalPad)
                            Spacer()
                            CommonButton(text: "更新", width: 94, height: 28) {
                                //if orderRegardDataModel.paintWeight != "0" && orderRegardDataModel.paintWeight.isInt {
                                    orderRegardDataModel.regardWeight(dialogsDataModel: dialogsDataModel)
                                //}
                            }
                        }
                        HStack(spacing: 0){
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color(hex: "#56B8C4"))
                                .frame(width: 14, height: 14)
                                
                            Text("購入された総重量をご記入ください。")
                                .font(.regular12)
                                .foregroundColor(.subText)
                            Spacer()
                        }
                    }
                    CommonTextField(label: "商品価格（円）", placeholder: "", value: $orderRegardDataModel.paintPrice, disabled: true, commabled: true)
                    CommonTextField(label: "使用期限日", placeholder: "", value: $orderRegardDataModel.useDate, disabled: true)
                    CommonTextField(label: "ロット番号", placeholder: "", value: $orderRegardDataModel.lotNumber, disabled: true)
                    HStack{
                        Spacer()
                        Text("在庫No：")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text("")
                            .font(.medium16)
                            .foregroundColor(.mainText)
                    }
                }
                .padding(.horizontal, 21)
                .padding(.top, 21)
            
                Spacer(minLength: 80)
            }
            NavigationLink(
                destination: inventoryEdit(from: 1), tag: 10, selection: $inventoryEditDataModel.navigationTag) {

                    EmptyView()
                }.isDetailLink(false)
            Spacer()
        }
            if orderRegardDataModel.showPicker{
                CommonPicker(selection:$orderRegardDataModel.selection,pickList: orderRegardDataModel.pickList,onCancel:{
                    orderRegardDataModel.showPicker = false
                },onCompleted: {
                    orderRegardDataModel.showPicker = false
                    orderRegardDataModel.setPickValue(pickId: orderRegardDataModel.selection)
                })
            }
            if orderRegardDataModel.showDatePicker{
                CommonDatePick(currentDate: $orderRegardDataModel.expireDate,onCancel:{
                    orderRegardDataModel.showDatePicker = false
                },onCompleted: {
                    orderRegardDataModel.showDatePicker = false
                    orderRegardDataModel.expireDateStr = DateTimeUtils.dateToStr(date: orderRegardDataModel.expireDate)
                })
            }
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
        .modal(isPresented: $orderRegardDataModel.showWeightNoti) {
            ErrorModal(showModal: $orderRegardDataModel.showWeightNoti, text: "重量が未入力です 登録を行ってください", onConfirm: {
                orderRegardDataModel.showWeightNoti = false
                //※販売用設定画面へ遷移します
                /*
                inventoryEditDataModel.initData(id: orderRegardDataModel.paintId, dialogsDataModel: dialogsDataModel)
                inventoryEditDataModel.navigationTag = 10
                 */
            })
        }
        .modal(isPresented: $orderRegardDataModel.showUpdataNoti) {
            ConfirmModal(showModal: $orderRegardDataModel.showUpdataNoti, text: "購入者にステータス更新の 通知を送ります よろしいでしょうか？", onConfirm: {
                orderRegardDataModel.showUpdataNoti = false
                if orderRegardDataModel.updateNotiType == 1 {
                    orderRegardDataModel.regardDate(dialogsDataModel: dialogsDataModel)
                }else if orderRegardDataModel.updateNotiType == 2 {
                    orderRegardDataModel.regard(dialogsDataModel: dialogsDataModel)
                }
                orderRegardDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .modal(isPresented: $orderRegardDataModel.showWeightErrorNoti) {
            ErrorModal(showModal: $orderRegardDataModel.showWeightErrorNoti, text: orderRegardDataModel.weightMessage, onConfirm: {
                orderRegardDataModel.showWeightErrorNoti = false
            })
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
