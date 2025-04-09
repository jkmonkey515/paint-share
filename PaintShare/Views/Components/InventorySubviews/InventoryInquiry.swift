//
//  InventoryInquiry.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/10.
//

import SwiftUI

struct InventoryInquiry: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var inventoryEditDataModel: InventoryEditDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    @EnvironmentObject var chatDataModel: ChatDataModel
    
    @EnvironmentObject var favoriteDataModel: FavoriteDataModel
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
     
    @EnvironmentObject var orderWishDataModel: OrderWishDataModel
    
    @EnvironmentObject var orderPaymentResultsDataModel:OrderPaymentResultsDataModel
    
    var from: Int = 0
    
    var fromMenu:Bool = false
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
        
    var body: some View {
        ZStack{
        VStack{
            CommonHeader(title: "在庫照会", showBackButton: true, showHamburgerButton: false, onBackClick: {
                inventorySearchDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            ScrollView{
                if ( inventoryInquiryDataModel.isRelated == false && !inventoryInquiryDataModel.editPromise && inventoryInquiryDataModel.identityType == 2 ){
                    ZStack{
                        RoundedRectangle(cornerRadius:8)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 63)
                        
                        VStack(spacing:0){
                            Text("画面一番下のボタンから所有者へ")
                                .font(.regular16)
                            .foregroundColor(Color(hex: "#46747E"))
                            Text("リクエストできます")
                                .font(.regular16)
                            .foregroundColor(Color(hex: "#46747E"))
                        }
                        
                    }.padding(.top, 24)
                }else if ( !inventoryInquiryDataModel.editPromise && inventoryInquiryDataModel.identityType == 2 ){
                    ZStack{
                        RoundedRectangle(cornerRadius:8)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 37)
                        Text("画面一番下のボタンから購入ができます")
                            .font(.regular16)
                            .foregroundColor(Color(hex: "#46747E"))
                    }.padding(.top, 24)
                }else if (!inventoryInquiryDataModel.editPromise){
                    ZStack{
                        RoundedRectangle(cornerRadius:8)
                            .fill(Color(hex: "#E9FCFF"))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 63)
                        
                        VStack(spacing:0){
                            Text("画面一番下のボタンから所有者へ")
                                .font(.regular16)
                            .foregroundColor(Color(hex: "#46747E"))
                            Text("リクエストできます")
                                .font(.regular16)
                            .foregroundColor(Color(hex: "#46747E"))
                        }
                        
                    }.padding(.top, 24)
                }
                
                    ZStack{
                        ImageView(withURL: inventoryInquiryDataModel.materialImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + inventoryInquiryDataModel.materialImgKey!, onClick: {
                            img in
                            dialogsDataModel.largeImage = img
                            dialogsDataModel.showLargeImage=true
                        }).frame(width: 130, height: 130)
                            .clipped()
                            .padding(.top, 28)
                      
                        
                        if (!inventoryInquiryDataModel.editPromise){
                           if (inventoryInquiryDataModel.identityType == 2) {
                        HStack{
                            Spacer()
                            Text("通報する")
                                .font(.regular14)
                                .foregroundColor(Color(hex:"#56B8C4"))
                                .padding(.trailing,23)
                                .padding(.bottom, 90)
                                .onTapGesture {
                                    inventoryInquiryDataModel.navigationTag = 3
                                    inquiryFromDataModel.rest()
                                }
                        }
                           }
                            if (inventoryInquiryDataModel.identityType == 1 || inventoryInquiryDataModel.identityType == 2) {
                        //----------　お気に入り　----------
                       HStack {
                           Spacer()
                        Image(systemName: favoriteDataModel.isFavorite ? "star" : "star.fill")
                            .foregroundColor(favoriteDataModel.isFavorite ? Color(hex:"#E0E0E0") : .yellow )
                            .font(.system(size: 30))
                            .padding(.trailing,23)
                            .padding(.top, 130)
                            .onTapGesture {
                                favoriteDataModel.reset()
                                favoriteDataModel.paintId = inventoryInquiryDataModel.id
                                favoriteDataModel.savePaintLike(dialogsDataModel: dialogsDataModel)
                               
                            }
                       
                    }
                        //--------------------------------
                           }
                    }
                        
                    }
 
                 
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
                    else {
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
                .padding(.horizontal, 21)
                VStack(spacing: 21){
                    ZStack{
                        CommonTextField(label: "在庫数量（缶）", placeholder: "", value: $inventoryInquiryDataModel.amount, disabled: true)
                        if (inventoryInquiryDataModel.editPromise) {
                            HStack{
                                Spacer()
                                CommonButton(text: "数量変更", width: 94, height: 28, onClick: {
                                    inventoryInquiryDataModel.showAmountModal = true
                                })
                            }
                        }
                    }
                    if (inventoryInquiryDataModel.identityType == 2) {
                        CommonTextField(label: "商品価格（円）", placeholder: "", value: $inventoryInquiryDataModel.priceValue, disabled: true, commabled: true)
                    }
                    CommonTextField(label: "使用期限日", placeholder: "", value: $inventoryInquiryDataModel.expireDateStr, disabled: true)
                    CommonTextField(label: "ロット番号", placeholder: "", value: $inventoryInquiryDataModel.lotNumber, disabled: true)
                    if (inventoryInquiryDataModel.identityType == 2) {
                        MultilineTextField(label: "商品説明", placeholder: "", height: 285, value: $inventoryInquiryDataModel.specification, disabled: true, validationMessage: "")
                    }
                    VStack{
                        HStack{
                            Text("公開設定")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Spacer()
                        }
                        Text(inventoryInquiryDataModel.inventoryPublicStr)
                            .font(.bold16)
                            .foregroundColor(inventoryInquiryDataModel.inventoryPublic ? .primary : .mainText)
                    }
                    HStack{
                        Spacer()
                        Text("在庫No：")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Text(inventoryInquiryDataModel.inventoryNumber)
                            .font(.medium16)
                            .foregroundColor(.mainText)
                    }
                }
                .padding(.horizontal, 21)
                .padding(.top, 21)
                //edit
                if (inventoryInquiryDataModel.isRelated == false) {
                    HStack(alignment: .top, spacing: 5){
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color(hex: "#F16161"))
                            .frame(width: 18, height: 18)
                            .padding(.top, 3.5)
                        Text("商品を購入したい場合、出品者からフレンド申請を許可してもらってください")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#F16161"))
                            .lineLimit(2)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 21)
                    
                    CommonButton(text: "フレンド申請をする", color: Color(hex: "#FEE049"), textColor: Color(hex: "#545353"), width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        requestFormDataModel.isFromRelatedSearch = false
                        requestFormDataModel.isJoin = false
                        requestFormDataModel.groupSearchItem = GroupSearchItem(id: inventoryInquiryDataModel.shareGroup!.id, groupDto: inventoryInquiryDataModel.shareGroup!, rank0Count: 0, rank1Count: 0, rank2Count: 0, statusInGroup: nil, statusInGroupDisplayName: nil, ownedByLoggedinUser: false)
                        groupSearchDataModel.navigationTag = 30
                    })
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                } else if (inventoryInquiryDataModel.editPromise){
                    CommonButton(text: "編集する", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        inventoryEditDataModel.initData(id: inventoryInquiryDataModel.id, dialogsDataModel: dialogsDataModel)
                        inventoryEditDataModel.navigationTag = nil
                        inventoryInquiryDataModel.navigationTag = 1
                    })
                        .padding(.top, 50)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                } else {
                    //saleFlag
                    if (inventoryInquiryDataModel.identityType == 1) {
                        CommonButton(text: "この在庫をください", color: Float(inventoryInquiryDataModel.amount) != 0 ? Color(hex: "#1DB78B") : Color(hex: "#E0E0E0"), width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                            if Float(inventoryInquiryDataModel.amount) != 0 {
                                inventoryInquiryDataModel.wishNumber = Float(inventoryInquiryDataModel.amount) ?? 0 >= 1 ? "1" : inventoryInquiryDataModel.amount
                                inventoryInquiryDataModel.navigationTag = 20
                            }
                        })
                            .padding(.top, 50)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 21)
                    } else if (inventoryInquiryDataModel.identityType == 2) {
                        HStack{
                            //
                            CommonButton(text: "問い合わせ", color: Color(hex: "#56B8C4"), radius: 37/2, width: UIScreen.main.bounds.size.width/2 - 40, height: 37, picture: "message", isHavePicture: true, onClick: {
                                chatDataModel.reset()
                                chatDataModel.fromMenu = fromMenu
                                chatDataModel.getExistingChatroom(mainViewDataModel: mainViewDataModel,paintId:inventoryInquiryDataModel.id,dialogsDataModel: dialogsDataModel, chatDataModel:chatDataModel, inventoryInquiryDataModel: inventoryInquiryDataModel,orderConfirmDataModel:nil,orderWish: false)
                                inventoryInquiryDataModel.groupId = chatDataModel.groupId
                                chatDataModel.imgKey=inventoryInquiryDataModel.materialImgKey
                            })
                            Spacer()
                            CommonButton(text: "購入", color: Float(inventoryInquiryDataModel.amount) != 0 ? Color(hex: "#FEE049") : Color(hex: "#E0E0E0"), width: UIScreen.main.bounds.size.width/2 - 40, height: 37, onClick: {
                                /*
                                if (dialogsDataModel.freeUseUntil != 1 && (dialogsDataModel.subscriptionDto == nil ||  dialogsDataModel.subscriptionDto?.status == nil)){
                                    let mytime = Date()
                                    let format = DateFormatter()
                                    format.dateFormat = "yyyy年MM月dd日"
                                    let now = format.string(from: mytime)
                                    let freeUseUntil = DateTimeUtils.timestampToStrFormat(timestamp: dialogsDataModel.freeUseUntil)
                                    if(now.compare(freeUseUntil) == .orderedDescending && dialogsDataModel.subscriptionDto == nil || dialogsDataModel.subscriptionDto?.status == nil ){
                                        dialogsDataModel.showChargeView = true
                                        return
                                    }
                                }else{
                                    inventoryInquiryDataModel.navigationTag = 10
                                }
                                 */
                                if Float(inventoryInquiryDataModel.amount) != 0 {
                                    orderConfirmDataModel.confirmNumber = Float(inventoryInquiryDataModel.amount) ?? 0 >= 1 ? "1" : inventoryInquiryDataModel.amount
                                    inventoryInquiryDataModel.navigationTag = 10
                                }
                            })
                        }
                        .padding(.top, 50)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                    }
                }
                CommonButton(text: "戻る", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                    inventorySearchDataModel.navigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
                    .padding(.bottom, 30)
                    .padding(.horizontal, 21)
                
                if (inventoryInquiryDataModel.editPromise){
                    Text("在庫を削除する")
                        .font(.regular18)
                        .foregroundColor(.primary)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                        .onTapGesture {
                            inventoryInquiryDataModel.showDeletePaintDialog = true
                        }
                }
                
                Group{
                NavigationLink(
                    destination: inventoryEdit(from:from), tag: 1, selection: $inventoryInquiryDataModel.navigationTag) {

                        EmptyView()
                    }.isDetailLink(false)
            
                /*

                if (inventoryInquiryDataModel.editPromise) {
                    CommonButton(text: "編集する", width: UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        inventoryEditDataModel.initData(id: inventoryInquiryDataModel.id, dialogsDataModel: dialogsDataModel)
                        inventoryEditDataModel.navigationTag = nil
                        inventoryInquiryDataModel.navigationTag = 1
                    })
                        .padding(.top, 50)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                    CommonButton(text: "キャンセル", color: Color.caution, width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        inventorySearchDataModel.navigationTag = nil
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        .padding(.bottom, 30)
                        .padding(.horizontal, 21)
                }
                */

                NavigationLink(
                    destination: InquiryFrom(), tag: 3, selection: $inventoryInquiryDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                    NavigationLink(
                        destination: ChatView(), tag: 4, selection: $inventoryInquiryDataModel.navigationTag ){
                            EmptyView()
                        }.isDetailLink(false)

                NavigationLink(
                    destination: OrderConfirmView(from:from,fromMenu:fromMenu), tag: 10, selection: $inventoryInquiryDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                NavigationLink(
                    destination: OrderWishView(from:from,fromMenu:fromMenu), tag: 20, selection: $inventoryInquiryDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                NavigationLink(
                    destination: RequestForm(from:from).onDisappear(perform: {
                    }), tag: 30, selection: $groupSearchDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                }
                Spacer(minLength: 80)
            }
            Spacer()
        }
            if from == 1 || from == 2{
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
        .onAppear(perform: {
            orderConfirmDataModel.reset()
            orderWishDataModel.reset()
            favoriteDataModel.getLikePaint(paintId: inventoryInquiryDataModel.id, dialogsDataModel: dialogsDataModel)
        })
    }
}
