//
//  ApproveWaitlist.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

struct ApprovalWaitlist: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var requestDetailInfoDataModel: RequestDetailInfoDataModel
    
    @EnvironmentObject var approvalWaitlistDataModel : ApprovalWaitlistDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var from: Int = 0
    
    var body: some View {
        VStack {
            if from == 1 {
                CommonHeader(title: "メンバー承認リスト", showBackButton: true, onBackClick: {
                    dialogsDataModel.mainViewNavigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            HStack {
                Text("リクエスト： \(approvalWaitlistDataModel.resultCount) 件")
                    .font(.regular14)
                    .foregroundColor(.mainText)
                    .padding(.leading, 17)
                Spacer()
            }
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    approvalWaitlistDataModel.listRequests(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(approvalWaitlistDataModel.waitList) {
                        result in
                        WaitItem(waitListItem: result)
                            .onTapGesture(perform: {
                                requestDetailInfoDataModel.waitListItem = result
                                approvalWaitlistDataModel.navigationTag = 1
                            })
                            .underlineListItem()
                    }
                }
            }
            NavigationLink(
                destination: RequestDetailInfo(), tag: 1, selection: $approvalWaitlistDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            .frame(width: 0, height: 0)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            debugPrintLog(message:"waitlist appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            approvalWaitlistDataModel.listRequests(dialogsDataModel: dialogsDataModel)
        })
    }
}
