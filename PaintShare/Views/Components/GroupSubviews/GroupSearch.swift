//
//  GroupSearch.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/9/21.
//

import SwiftUI

struct GroupSearch: View {
    
    var isRelatedSearch: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    var from: Int = 0
    
    var body: some View {
        VStack {
            if from == 1 {
                CommonHeader(title: "グループ検索", showBackButton: true, onBackClick: {
                    dialogsDataModel.mainViewNavigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
            }else if from == 2{
                CommonHeader(title: "関連グループ", showBackButton: true, onBackClick: {
                    dialogsDataModel.mainViewNavigationTag = nil
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            HStack(spacing: 20) {
                HStack {
                    Image("magnifiying-glass")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "c2c2c2"))
                        .padding(.leading, 10)
                    TextField("Search...", text:isRelatedSearch == false ? $groupSearchDataModel.searchPhrase:$groupSearchDataModel.searchPhraseAssociation, onCommit: {
                        isRelatedSearch == false ? groupSearchDataModel.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel) : groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    })
                    .autocapitalization(.none)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    Image(systemName: "xmark.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "c1c1c1"))
                        .padding(.trailing, 10)
                        .onTapGesture(perform: {
                            if isRelatedSearch == false {
                                groupSearchDataModel.searchPhrase = ""
                            }else{
                                groupSearchDataModel.searchPhraseAssociation = ""
                            }
                        })
                }
                .frame(height: 30)
                .background(Color(hex: "f3f3f3"))
                .cornerRadius(4)
                
                Text("Cancel")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .onTapGesture(perform: {
                        if isRelatedSearch == false {
                        groupSearchDataModel.searchPhrase = ""
                        groupSearchDataModel.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                        }else{
                            groupSearchDataModel.searchPhraseAssociation = ""
                            groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                        }
                    })
            }
            .padding(.leading, 10)
            .padding(.trailing, 20)
            
            HStack {
                Text("結果 \(isRelatedSearch == false ? groupSearchDataModel.resultCount:groupSearchDataModel.resultCountAssociation) 件")
                    .font(.regular12)
                    .foregroundColor(.mainText)
                    .padding(.leading, 17)
                Spacer()
               if isRelatedSearch == false {
                HStack(spacing: 5) {
                    Text(" メンバーとフレンドの違い")
                        .font(.regular12)
                        .foregroundColor(.primary)
                    TooltipLabel()
                        .onTapGesture(perform: {
                            dialogsDataModel.tooltipTitle = "メンバーとフレンドの違い"
                            dialogsDataModel.tooltipDescription = "ボタンを押すとグループへの参加申請ができます。メンバーはグループのメンバーとして申請し、フレンドは在庫の参照のみの申請になります。"
                            dialogsDataModel.tooltipDialog = true
                        })
                }
                .padding(.trailing,19)
               }
            }
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isRelatedSearch == false ? groupSearchDataModel.searchFromZeroPageNotRelated( mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel) : groupSearchDataModel.searchFromZeroPageRelated( mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(isRelatedSearch == false ? groupSearchDataModel.groupSearchItems : groupSearchDataModel.groupSearchAssociationItems) {
                        result in
                        GroupListItem(groupSearchItem: result, onJoinRequestTap: {
                            requestFormDataModel.isFromRelatedSearch = isRelatedSearch
                            requestFormDataModel.isJoin = true
                            requestFormDataModel.groupSearchItem = result
                            groupSearchDataModel.navigationTag = 2
                        }, onShareRequestTap: {
                            requestFormDataModel.isFromRelatedSearch = isRelatedSearch
                            requestFormDataModel.isJoin = false
                            requestFormDataModel.groupSearchItem = result
                            groupSearchDataModel.navigationTag = 2
                        }, onCancelRequestTap: {
                            groupSearchDataModel.groupIdToExit = result.groupDto.id
                            groupSearchDataModel.groupExitConfirmMessage = "取下げてよろしいですか？"
                            groupSearchDataModel.showExitConfirmDialog = true
                        }, onExitRequestTap: {
                            groupSearchDataModel.groupIdToExit = result.groupDto.id
                            groupSearchDataModel.groupExitConfirmMessage = "脱退してよろしいですか？"
                            groupSearchDataModel.showExitConfirmDialog = true
                        })
                        .padding(.bottom, 10)
                        .padding(.top, 2)
                        .underlineListItem()
//                        .onAppear {
//                            groupSearchDataModel.loadMoreIfNeeded(currentItem: result, isRelatedSearch: isRelatedSearch, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
//                        }
                        .onTapGesture(perform: {
                            groupDetailInfoDataModel.reset()
                            groupDetailInfoDataModel.groupId = result.groupDto.id
                            groupDetailInfoDataModel.getGroupSearchDto(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                            groupSearchDataModel.navigationTag = 1
                        })
                    }
                    if (isRelatedSearch == false ? (groupSearchDataModel.resultCount > groupSearchDataModel.groupSearchItems.count) : (groupSearchDataModel.resultCountAssociation > groupSearchDataModel.groupSearchAssociationItems.count)) {
                        HStack {
                            HStack(spacing:3) {
                                Text("もっと見る")
                                    .font(.regular18)
                                    .foregroundColor(Color(hex:"#56B8C4"))
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(hex:"#56B8C4"))
                            }
                                    .frame(width: UIScreen.main.bounds.size.width - 40,height: 40)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color(hex:"#56B8C4"), lineWidth: 1)
                                    )
                                .onTapGesture(perform: {
                                    if isRelatedSearch == false{
                                    groupSearchDataModel.loadMoreNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                                }else{
                                    groupSearchDataModel.loadMoreRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                                }
                                })
                        }
                        .padding(.top,20)
                        .padding(.bottom, 40)
                    }
                }
                
            }.padding(.bottom, -15)
            NavigationLink(
                destination: RequestForm().onDisappear(perform: {
//                    groupSearchDataModel.searchFromZeroPage(isRelatedSearch: isRelatedSearch, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    if isRelatedSearch == false {
                    groupSearchDataModel.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    }else{
                        groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    }
                }), tag: 2, selection: $groupSearchDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            .frame(width: 0, height: 0)
            NavigationLink(
                destination: GroupDetailInfo().onDisappear(perform: {
//                    groupSearchDataModel.searchFromZeroPage(isRelatedSearch: isRelatedSearch, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    if isRelatedSearch == false {
                    groupSearchDataModel.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    }else{
                        groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                    }
                }), tag: 1, selection: $groupSearchDataModel.navigationTag) {
                EmptyView()
            }.isDetailLink(false)
            .frame(width: 0, height: 0)
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            debugPrintLog(message:"group search appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            groupSearchDataModel.searchPhrase = ""
            groupSearchDataModel.isRelatedSearch = isRelatedSearch
            //groupSearchDataModel.searchFromZeroPage(isRelatedSearch: isRelatedSearch, mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
            if isRelatedSearch == false {
                if groupSearchDataModel.showIntroduction == true {
                    groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
                }
                groupSearchDataModel.searchFromZeroPageNotRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
            }else{
                groupSearchDataModel.searchFromZeroPageRelated(mainViewDataModel: mainViewDataModel, dialogsDataModel: dialogsDataModel)
            }
        })
    }
}
