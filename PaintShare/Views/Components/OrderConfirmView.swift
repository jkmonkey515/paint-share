//
//  OrderConfirmView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/24.
//

import SwiftUI

struct OrderConfirmView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
    
    @EnvironmentObject var inputCreditCardInformationDataModel:InputCreditCardInformationDataModel
    
    @EnvironmentObject var creditCardManagementDataModel:CreditCardManagementDataModel
        
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var from: Int = 0
    
    var fromMenu: Bool = false
    
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: "注文確認", showBackButton: true,showHamburgerButton: false, onBackClick: {
                orderConfirmDataModel.reset()
                self.presentationMode.wrappedValue.dismiss()
            })
            //.padding(.bottom, 30)
            
            ScrollView{
                CommonButton(text: "注文を確定する", color: Double(orderConfirmDataModel.confirmNumber) != 0 ? Color.primary : Color(hex: "#E0E0E0"), width:  UIScreen.main.bounds.size.width - 40, height: 37, disabled: dialogsDataModel.subscriptionDto?.status == "canceled" || orderConfirmDataModel.getLast4 == "" , onClick: {
                    if Double(orderConfirmDataModel.confirmNumber) != 0 {
                        if orderConfirmDataModel.payLock == false {
                            orderConfirmDataModel.fromMenu = fromMenu
                            orderConfirmDataModel.showConfirmNoti = true
                        }
                    }
                })
                .padding(.top, 15)
                
                Group{
                    if dialogsDataModel.subscriptionDto?.status == "canceled" {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(hex: "#FFFDF3"))
                            .frame(width: UIScreen.main.bounds.size.width - 34, height: 130)
                            .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                        
                        VStack(alignment: .center, spacing: 5){
                            HStack{
                                Image("notice")
                                Text("注意")
                                    .font(.bold16)
                                    .foregroundColor(Color(hex: "#F16161"))
                            }
                            VStack{
                                Text("現在サブスクリプションが未契約のためご購入はできません。 ご購入にはPaint Linksのサブスクリプション契約が必要となります。サブス")
                                HStack(spacing: 0.0){
                                    Text("クリプション契約のお申込みは")
                                    GeneralButton(onClick: {
                                        dialogsDataModel.showChargeView = true
                                        creditCardManagementDataModel.reset()
                                        inputCreditCardInformationDataModel.reset()
                                        //orderConfirmDataModel.navigationTag = 1
                                        orderConfirmDataModel.fromMenu = fromMenu
                                       // inputCreditCardInformationDataModel.fromMenu=false
                                    }, label: {
                                        Text("こちら")
                                            .font(.regular14)
                                            .foregroundColor(.primary)
                                    })
                                    Text("から。")
                                    Spacer()
                                }
                            }
                            .font(.bold14)
                            .foregroundColor(Color(hex: "#F16161"))
                            .frame(maxWidth: 300)
                        }
                        .padding(.horizontal, 21 + 21)
                        
                        HStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: "#F16161"))
                                .frame(width: 6, height: 130)
                            Spacer()
                        }
                        .padding(.horizontal, 19)
                    }
                    .padding(.top, 20)
                    }
                    else if  orderConfirmDataModel.getLast4 == "" {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: "#FFFDF3"))
                                .frame(width: UIScreen.main.bounds.size.width - 34, height: 130)
                                .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                            
                            VStack(alignment: .center, spacing: 5){
                                HStack{
                                    Image("notice")
                                    Text("注意")
                                        .font(.bold16)
                                        .foregroundColor(Color(hex: "#F16161"))
                                }
                                VStack{
                                    Text("クレジットカードが未登録のためご購入できません。ご購入にはクレジットカードの登録が必要となります。クレジットカードの登録は")
                                    HStack(spacing: 0.0){
                                        Text("")
                                        GeneralButton(onClick: {
                                            creditCardManagementDataModel.reset()
                                            inputCreditCardInformationDataModel.reset()
                                            //inputCreditCardInformationDataModel.fromMenu=fromMenu
                                            inputCreditCardInformationDataModel.fromMenu=false
                                            orderConfirmDataModel.fromMenu = fromMenu
                                            orderConfirmDataModel.getCardList(dialogsDataModel: dialogsDataModel)
                                        }, label: {
                                            Text("こちら")
                                                .font(.regular14)
                                                .foregroundColor(.primary)
                                        })
                                        Text("から。")
                                        Spacer()
                                    }
                                }
                                .font(.bold14)
                                .foregroundColor(Color(hex: "#F16161"))
                                .frame(maxWidth: 300)
                            }
                            .padding(.horizontal, 21 + 21)
                            
                            HStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(hex: "#F16161"))
                                    .frame(width: 6, height: 130)
                                Spacer()
                            }
                            .padding(.horizontal, 19)
                        }
                        .padding(.top, 20)
                    }
                    Group{
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex: "#F5F5F5"))
                                .frame(width: UIScreen.main.bounds.size.width - 34, height: 90)
                            VStack{
                                VStack(spacing: 5){
                                    HStack{
                                        Text("商品の小計:")
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                        Spacer()
                                        Text(String(format:"￥%.0f",(Float(inventoryInquiryDataModel.priceValue.filter{$0 != ","}) ?? 0)*(Float(orderConfirmDataModel.confirmNumber) ?? 0)))
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                    }
                                    HStack{
                                        Text("合計:")
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                        Spacer()
                                        Text(String(format:"￥%.0f",(Float(inventoryInquiryDataModel.priceValue.filter{$0 != ","}) ?? 0)*(Float(orderConfirmDataModel.confirmNumber) ?? 0)))
                                            .font(.regular14)
                                            .foregroundColor(Color(hex: "#707070"))
                                    }
                                    HStack{
                                        Text("ご請求額:")
                                            .font(.bold20)
                                            .foregroundColor(Color(hex: "#707070"))
                                        Spacer()
                                        Text(String(format:"￥%.0f",(Float(inventoryInquiryDataModel.priceValue.filter{$0 != ","}) ?? 0)*(Float(orderConfirmDataModel.confirmNumber) ?? 0)))
                                            .font(.bold20)
                                            .foregroundColor(Color(hex: "#F16161"))
                                    }
                                }
                                .padding(.horizontal, 21 + 21)
                            
                            }
                        }
                    }.padding(.top, 19)
                    
                    Text("数量の変更は画面下部で行えます")
                        .font(Font.custom("NotoSansCJKjp-Regular", size: 15))
                        .foregroundColor(Color(hex: "#1E94FA"))
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                    
                    HStack{
                        Text("商品情報")
                            .font(.medium16)
                            .foregroundColor(Color(hex: "#46747E"))
                        Spacer()
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, -10)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(hex: "#F5F5F5"))
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
                                if (inventoryInquiryDataModel.colorFlag){
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
                                CommonTextField(label: "重量（㎏）", placeholder: "", value: $inventoryInquiryDataModel.weightValue, disabled: true)
                            
                                CommonTextField(label: "価格（円）", placeholder: "", value: $inventoryInquiryDataModel.priceValue, disabled: true, commabled: true)
                            }
                            .padding(.horizontal, 21 + 21)
                            .padding(.top, 21)
                        }
                    }
                    .padding(.bottom, 30)
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(hex: "#F5F5F5"))
                        .frame(width: UIScreen.main.bounds.size.width - 34, height: 59)
                    ZStack{
                        CommonTextField(label: "数量", placeholder: "", required: true, font: .medium16, color: Color(hex: "#46747E"), value: $orderConfirmDataModel.confirmNumber, disabled: true)
                        HStack{
                            Spacer()
                            CommonButton(text: "数量変更", width: 94, height: 28, onClick: {
                                if Float(inventoryInquiryDataModel.amount) ?? 0 > 1 {
                                    orderConfirmDataModel.showConfirmModal = true
                                }
                            })
                        }
                    }.padding(.horizontal, 21 + 21)
                }
                .padding(.bottom, 30)
                
                /*
                Group{
                    HStack{
                        Text("受け渡し方法")
                            .font(.bold16)
                            .foregroundColor(Color(hex: "#46747E"))
                        Spacer()
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, -10)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(hex: "#F5F5F5"))
                            .frame(width: UIScreen.main.bounds.size.width - 34, height: 168)
                        VStack{
                            VStack(spacing: 21){
                                
                            }
                            .padding(.horizontal, 21 + 21)
                           
                        }
                    }
                    .padding(.bottom, 30)
                }
                */
                Group{
                    HStack{
                        Text("支払い情報")
                            .font(.medium16)
                            .foregroundColor(Color(hex: "#46747E"))
                        Spacer()
                    }
                    .padding(.horizontal, 21)
                    .padding(.bottom, -10)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(hex: "#F5F5F5"))
                            .frame(width: UIScreen.main.bounds.size.width - 34, height: 86)
                        VStack{
                            VStack(spacing: 0){
                                HStack{
                                    Text("支払い方法")
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: "#707070"))
                                    Spacer()
                                }
                                HStack{
                                    
                                    Text( orderConfirmDataModel.getLast4 == "" ? "カード情報が未入力です" : "\(orderConfirmDataModel.getBrand) 下4桁    \(orderConfirmDataModel.getLast4)")
                                        .font(.regular14)
                                        .foregroundColor(Color(hex: orderConfirmDataModel.getLast4 == "" ? "#FF0000" : "#707070"))
                                    Spacer()
                                    GeneralButton(onClick: {
                                        creditCardManagementDataModel.reset()
                                        inputCreditCardInformationDataModel.reset()
                                        //inputCreditCardInformationDataModel.fromMenu=fromMenu
                                        inputCreditCardInformationDataModel.fromMenu=false
                                        orderConfirmDataModel.fromMenu = fromMenu
                                        orderConfirmDataModel.getCardList(dialogsDataModel: dialogsDataModel)
                                    }, label: {
                                            Image("ionic-ios-arrow-down")
                                                .resizable()
                                                .frame(width: 16.38, height: 9.37, alignment: .center)
                                                .rotationEffect(.degrees(-90))
                                                .offset(x:-4, y:-5)
                                    })
                                }
                            }
                            .padding(.horizontal, 21 + 21)
                           
                        }
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 30)
                }
                
                CommonButton(text: "注文を確定する", color: Double(orderConfirmDataModel.confirmNumber) != 0 ? Color.primary : Color(hex: "#E0E0E0"), width:  UIScreen.main.bounds.size.width - 40, height: 37,disabled: dialogsDataModel.subscriptionDto?.status == "canceled" || orderConfirmDataModel.getLast4 == "", onClick: {
                    if Double(orderConfirmDataModel.confirmNumber) != 0 {
                        if orderConfirmDataModel.payLock == false {
                            orderConfirmDataModel.fromMenu = fromMenu
                            orderConfirmDataModel.showConfirmNoti = true
                        }
                    }
                })
                Spacer(minLength: 80)
                Group{
                //カード情報の入力
                NavigationLink(
                    destination: InputCreditCardInformationView(), tag: 1, selection: $orderConfirmDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                //カード情報
                NavigationLink(
                    destination: CreditCardManagementView(), tag: 2, selection: $orderConfirmDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                NavigationLink(
                    destination: OrderPaymentResultsView(), tag: 3, selection: $orderConfirmDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)

                NavigationLink(
                    destination: PaymentResultsView(), tag: 4, selection: $orderConfirmDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                }
            }
            Spacer()
        }
            
            if from == 2{
                InventoryWheelInputs()
                MainViewModals()
                if (dialogsDataModel.showLoading) {
                    ProgressView()
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            mainViewDataModel.checkSubscriptionStatus(dialogsDataModel: dialogsDataModel)
            orderConfirmDataModel.free(dialogsDataModel: dialogsDataModel)
            orderConfirmDataModel.getCardNumber(dialogsDataModel: dialogsDataModel)
        }
    }
}
