//
//  OrderWishView.swift
//  PaintShare
//
//  Created by Lee on 2022/9/9.
//

import SwiftUI

struct OrderWishView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
    
    @EnvironmentObject var orderWishDataModel: OrderWishDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
        
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var from: Int = 0
    
    var fromMenu: Bool = false
    
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: "注文確認", showBackButton: true,showHamburgerButton: false, onBackClick: {
                inventoryInquiryDataModel.wishNumber = "1"
                orderWishDataModel.reset()
                self.presentationMode.wrappedValue.dismiss()
            })
            //.padding(.bottom, 30)
            
            ScrollView{
                CommonButton(text: "くださいを送る", color: Double(inventoryInquiryDataModel.wishNumber) != 0 ? Color(hex: "#1DB78B") : Color(hex: "#E0E0E0"), width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    if Double(inventoryInquiryDataModel.wishNumber) != 0 {
                        dialogsDataModel.orderPayResult = 2
                        if fromMenu == false{
                        dialogsDataModel.mainViewNavigationTag = 60
                        }else{
                            orderWishDataModel.navigationTag = 1
                        }
                    }
                })
                .padding(.top, 15)
                
                Group{
                    Text("数量の変更は画面下部で行えます")
                        .font(Font.custom("NotoSansCJKjp-Regular", size: 15))
                        .foregroundColor(Color(hex: "#1E94FA"))
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                    
                    HStack{
                        Text("商品情報")
                            .font(.bold16)
                            .foregroundColor(Color(hex: "#46747E"))
                        Spacer()
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, -10)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.clear)
                            .frame(width: UIScreen.main.bounds.size.width - 34, height: 800)
                        VStack{
                            ImageView(withURL: inventoryInquiryDataModel.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + inventoryInquiryDataModel.materialImgKey!, onClick: {
                                img in
                            }).frame(width: 130, height: 130)
                                .clipped()
                            VStack(spacing: 21){
                                CommonTextField(label: "グループ", placeholder: "",value: $inventoryInquiryDataModel.groupValue,disabled: true)
                                if (inventoryInquiryDataModel.identityType == 2) {
                                    CommonTextField(label: "倉庫", placeholder: "",value: $inventoryInquiryDataModel.adressValue,disabled: true)
                                }
                                CommonTextField(label: "メーカー", placeholder: "",value: $inventoryInquiryDataModel.makerValue,disabled: true)
                                CommonTextField(label: "商品名", placeholder: "", value: $inventoryInquiryDataModel.goodsNameValue, disabled: true)
                                CommonTextField(label: "用途区分", placeholder: "", value: $inventoryInquiryDataModel.useCategoryValue, disabled: true)
                                if (inventoryInquiryDataModel.colorFlag)
                                {
                                    CommonTextField(label: "色", placeholder: "", value: $inventoryInquiryDataModel.otherColorName, disabled: true)
                                }
                                else
                                {
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
                                            .foregroundColor(Color(hex: inventoryInquiryDataModel.colorCode))
                                            .shadow(color: Color(.black).opacity(0.16), radius: 6, x: 0, y: 3)
                                        VStack(alignment: .leading,spacing: 3){
                                            Spacer()
                                            Text(inventoryInquiryDataModel.colorMakerName != "該当なし" ? inventoryInquiryDataModel.colorMakerName : "")
                                                .font(.regular12)
                                                .foregroundColor(.mainText)
                                            Text(inventoryInquiryDataModel.colorNumber)
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
                            }
                            .padding(.horizontal, 21 + 21)
                            VStack(spacing: 21){
                                CommonTextField(label: "在庫数量（缶）", placeholder: "", value: $inventoryInquiryDataModel.amount, disabled: true)
                            
                                CommonTextField(label: "価格（円）", placeholder: "", value: $inventoryInquiryDataModel.priceValue, disabled: true, commabled: true)
                                
                                CommonTextField(label: "使用期限日", placeholder: "", value: $inventoryInquiryDataModel.expireDateStr, disabled: true)
                                
                                CommonTextField(label: "ロット番号", placeholder: "", value: $inventoryInquiryDataModel.lotNumber, disabled: true)
                                
                                ZStack{
                                    CommonTextField(label: "数量", placeholder: "", required: true, font: .bold16, color: Color(hex: "#46747E"), value: $inventoryInquiryDataModel.wishNumber, disabled: true)
                                    HStack{
                                        Spacer()
                                        CommonButton(text: "数量変更", width: 94, height: 28, onClick: {
                                            if Float(inventoryInquiryDataModel.amount) ?? 0 > 1 {
                                                inventoryInquiryDataModel.showWishModal = true
                                            }
                                        })
                                    }
                                }
                            }
                            .padding(.horizontal, 21 + 21)
                            .padding(.top, 21)
                        }
                    }
                    .padding(.bottom, 30)
                }
                
                CommonButton(text: "くださいを送る", color: Double(inventoryInquiryDataModel.wishNumber) != 0 ? Color(hex: "#1DB78B") : Color(hex: "#E0E0E0"), width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    if Double(inventoryInquiryDataModel.wishNumber) != 0 {
                        dialogsDataModel.orderPayResult = 2
                        if fromMenu == false{
                        dialogsDataModel.mainViewNavigationTag = 60
                        }else{
                            orderWishDataModel.navigationTag = 1
                        }
                    }
                })
                Spacer(minLength: 80)
                
                NavigationLink(
                    destination: OrderPaymentResultsView(), tag: 1, selection: $orderWishDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
            }
            Spacer()
        }
        
            if from == 2{
                InventoryWheelInputs()
                MainViewModals()
                if (dialogsDataModel.showLoading) {
                    ProgressView()
                }
            }}
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            
        }
    }

}
