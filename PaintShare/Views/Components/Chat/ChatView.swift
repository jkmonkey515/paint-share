//
//  ChatView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/21.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    @EnvironmentObject var rankFormDataModel: RankFormDataModel
    
    @EnvironmentObject var locationHelper:LocationManager
    
    @EnvironmentObject var mapSearchDataModel:MapSearchDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel:GroupDetailInfoDataModel
    
    @EnvironmentObject var inventoryInquiryDataModel: InventoryInquiryDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    @EnvironmentObject var browsingHistoryDataModel:BrowsingHistoryDataModel
    
    @EnvironmentObject var favoriteDataModel:FavoriteDataModel
    
    @EnvironmentObject var orderConfirmDataModel: OrderConfirmDataModel
    
    @EnvironmentObject var orderWishDataModel: OrderWishDataModel
    
    @Namespace var chatBottomID
    
    let timer = Timer.publish(every: 3.0, on:.main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                CommonHeader(title:chatDataModel.getHeaderName(loginUserId: mainViewDataModel.loggedInUserId ?? -1 ), showBackButton: true, showHamburgerButton: false,showReportButton:true,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                
                HStack(spacing: 10) {
                    
//                    Image(uiImage: chatDataModel.logo!)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 68, height: 68)
//                        .clipped()
                    
                    ZStack {
                        ImageView(withURL: chatDataModel.imgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + chatDataModel.imgKey!, onClick: {
                            img in
                        }).frame(width:68,height:68)
                            .clipped()
                       // ReceptionLabel()
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text(chatDataModel.inventoryDto?.ownedBy.groupName ?? "")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            
                            Text(chatDataModel.inventoryDto?.goodsNameName ?? "")
                                .font(.medium16)
                                .foregroundColor(.mainText)
                            
                            Text(chatDataModel.inventoryDto?.price != nil ? String(chatDataModel.inventoryDto!.price!) + "円": " ")
                                .font(.regular13)
                                .foregroundColor(.mainText)
                        }
                    }
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 10)
                .padding(.trailing, 16)
                .padding(.top,15)
                
                Rectangle()
                    .fill(Color(hex: "#F1F1F1"))
                    .frame(height: 3)
                    .padding(.top,12)
                
                ScrollViewReader { value in
                    ScrollView {
                        //timer
                        LazyVStack(spacing:0) {
                            ForEach(chatDataModel.msgs,id: \.self){
                                chatMessage in
                                HStack{
                                    ChatMessageItem(message:chatMessage)
                                    
                                }.id(chatMessage.id)
                            }
                            .padding(.top,18)
                            Text("").id(chatBottomID)
                        }
                        .onChange(of: chatDataModel.msgs){ _ in
                            if chatDataModel.msgs.count > 0 {
                                value.scrollTo(chatDataModel.msgs.last?.id)
                            }
                        }
                        Spacer()
                    }
                }
                .onReceive(timer, perform: { _ in
                    chatDataModel.getChatMessageList(dialogsDataModel: dialogsDataModel)
                    AppBadgeNumber.getUnreadMessageCounts()
                    if (chatDataModel.navigationTag != nil){
                        timer.upstream.connect().cancel()
                    }
                })
                if(chatDataModel.chatroomDto == nil){
                    
                }else if( mainViewDataModel.loggedInUserId != chatDataModel.chatroomDto!.paint.ownedBy.groupOwner.id && groupDetailInfoDataModel.groupSearchItem.statusInGroup == 3 && chatDataModel.deliveryStatu == 2){
                    ZStack{
                        Color(hex: "#E9FCFF")
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing:8){
                            Text("取引が完了しました")
                                .font(.medium16)
                                .foregroundColor(Color(hex: "#707070"))
                            CommonButton(text: chatDataModel.reviewDto == nil ? "出品者を評価する" : "評価を変更する", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                            //    CommonButton(text:"出品者を評価する" , width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                                if (chatDataModel.reviewDto != nil) {
                                    rankFormDataModel.comment = chatDataModel.reviewDto!.content
                                    rankFormDataModel.selectedRank = chatDataModel.reviewDto!.score
                                    rankFormDataModel.selectWeightNumber = chatDataModel.reviewDto!.questionOne
                                    rankFormDataModel.selectDateNumber = chatDataModel.reviewDto!.questionTwo
                                } else {
                                    rankFormDataModel.comment = ""
                                    rankFormDataModel.selectedRank = nil
                                    rankFormDataModel.selectWeightNumber = nil
                                    rankFormDataModel.selectDateNumber = nil
                                }
                                rankFormDataModel.groupName = chatDataModel.chatroomDto!.paint.ownedBy.groupName
                                rankFormDataModel.groupId = chatDataModel.chatroomDto!.paint.ownedBy.id
                                chatDataModel.navigationTag = 2
                            })
                            
                        }
                    }
                    .frame(height:90)
                }
                MessageInputView()
                
                NavigationLink(
                    destination: InquiryFrom(), tag: 1, selection: $chatDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                //RankForm
                NavigationLink(
                    destination: RankForm(), tag: 2, selection: $chatDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
                
            }
            if (chatDataModel.subwindowTag == 1){
                ZStack {
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width:340,height: 420)
                        .cornerRadius(8)
                    
                    VStack{
                        Image(uiImage: chatDataModel.chatImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 310, height: 300)
                            .cornerRadius(5)
                            .clipped()
                            .padding(.top,15)
                        
                        Text("こちらの画像を送信しますか？")
                            .font(.medium16)
                            .foregroundColor(Color(hex: "#545353"))
                        HStack{
                            Spacer()
                            CommonButton(text: "キャンセル",   width: 100, height: 30, onClick: {
                                chatDataModel.subwindowTag = nil
                            })
                            CommonButton(text: "OK",   width: 100, height: 30, onClick: {
                                chatDataModel.sendImage(mainViewDataModel: mainViewDataModel,dialogsDataModel: dialogsDataModel)
                                chatDataModel.subwindowTag = nil
                            }).padding(.leading,30)
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width:340,height: 420)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                
            }else if(chatDataModel.subwindowTag == 2){
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width:340,height: 420)
                        .cornerRadius(8)
                    
                    VStack{
                        VStack(spacing:3){
                            ZStack{
                                TextField("Search...", text: $mapSearchDataModel.searchPhrase, onCommit: {
                                    locationHelper.search(mapSearchDataModel.searchPhrase)
                                })
                                    .foregroundColor(Color(hex: "#707070"))
                                    .frame(width: 308, height: 43)
                                    .background(Color(hex: "#E9FCFF"))
                                    .cornerRadius(5)
                            }
                            .frame(width: 310, height: 45)
                            .background(Color(hex: "#56B8C4"))
                            .cornerRadius(5)
                            
                            ZStack {
                                MapView(centerCoordinate: $locationHelper.centerCoordinate)
                                    .frame(width: 310, height: 250)
                                VStack{
                                    HStack{
                                        Spacer()
                                        Image(systemName: "paperplane.circle.fill")
                                            .renderingMode(.template)
                                            .resizable()
                                            .foregroundColor(Color(hex: "56B8C4"))
                                            .frame(width: 25, height: 25)
                                            .padding(.bottom, 170)
                                            .padding(.trailing, 10)
                                            .onTapGesture {
                                                locationHelper.locationManager.startUpdatingLocation()
                                                locationHelper.didUpdateLocationsComplete = { sender in
                                                    if let loc = sender {
                                                        locationHelper.didUpdateLocationsComplete = nil
                                                        locationHelper.centerCoordinate = loc
                                                    }
                                                }
                                            }
                                    }
                                    .padding(.bottom,40)
                                }
                            }
                            .frame(width: 310, height: 250)
                            .cornerRadius(5)
                        }
                        .padding(.top,15)
                        
                        Text("こちらの位置で送信しますか？")
                            .font(.medium16)
                            .foregroundColor(Color(hex: "#545353"))
                        HStack{
                            Spacer()
                            CommonButton(text: "キャンセル",   width: 100, height: 30, onClick: {
                                mapSearchDataModel.searchPhrase = ""
                                chatDataModel.subwindowTag = nil
                            })
                            CommonButton(text: "OK",   width: 100, height: 30, onClick: {
                                chatDataModel.sendAddressMapLink(mainViewDataModel:  mainViewDataModel,lat: locationHelper.centerCoordinate.coordinate.latitude,lng: locationHelper.centerCoordinate.coordinate.longitude, dialogsDataModel: dialogsDataModel)
                                chatDataModel.subwindowTag = nil
                            }).padding(.leading,30)
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width:340,height: 420)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                
            }
            
            MainViewModals()
            if (dialogsDataModel.showLoading) {
                ProgressView()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        //          .edgesIgnoringSafeArea(.bottom)
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(isPresented: $chatDataModel.shouldPresentImagePicker, onDismiss: {}) {
            ImagePicker(image: $chatDataModel.chatImage, sourceType: chatDataModel.shouldPresentCamera ? .camera : .photoLibrary)
        }
        .onAppear(perform:{
            chatDataModel.initPaintData(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
            chatDataModel.getChatMessageList(dialogsDataModel: dialogsDataModel)
            chatDataModel.getReviewDto(dialogsDataModel: dialogsDataModel)
            chatDataModel.loadImg(mainViewDataModel:  mainViewDataModel,dialogsDataModel: dialogsDataModel)
            chatDataModel.getOrderDeliveryStatus(groupId: chatDataModel.groupId, userId: mainViewDataModel.loggedInUserId!, paintId: chatDataModel.paintId, dialogsDataModel: dialogsDataModel)
            AppBadgeNumber.getUnreadMessageCounts()

        } )

    }
}
