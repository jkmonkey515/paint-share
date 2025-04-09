//
//  GroupManagement.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct GroupManagement: View {
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    @State private var tabs = ["グループ検索", "関連グループ", "グループ変更", "承認待ち", "グループ作成"]
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var approvalWaitlistDataModel: ApprovalWaitlistDataModel
    
    var body: some View {
        NavigationView {
            VStack {
                CommonHeader(title: tabs[groupManagementDataModel.selectedTab])
                HStack {
                    TopTab(label: tabs[0], tag: 0, selectedTag: $groupManagementDataModel.selectedTab)
                        .frame(maxWidth: .infinity)
                    TopTab(label: tabs[1], tag: 1, selectedTag: $groupManagementDataModel.selectedTab)
                        .frame(maxWidth: .infinity)
                    if (mainViewDataModel.loggedInUserGroup != nil) {
                        TopTab(label: tabs[2], tag: 2, selectedTag: $groupManagementDataModel.selectedTab)
                            .frame(maxWidth: .infinity)
                        TopTab(label: tabs[3], tag: 3, selectedTag: $groupManagementDataModel.selectedTab, numberMark: approvalWaitlistDataModel.resultCount)
                            .frame(maxWidth: .infinity)
                    } else {
                        TopTab(label: tabs[4], tag: 4, selectedTag: $groupManagementDataModel.selectedTab)
                            .frame(maxWidth: .infinity)
                    }
                }
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.subText)
                        .padding(.bottom, 1.5),
                    alignment: .bottom)
                if (groupManagementDataModel.selectedTab == 0) {
                    GroupSearch(isRelatedSearch: false)
                } else if (groupManagementDataModel.selectedTab == 1) {
                    GroupSearch(isRelatedSearch: true)
                } else if (groupManagementDataModel.selectedTab == 2) {
                    GroupInfoChange()
                } else if (groupManagementDataModel.selectedTab == 3) {
                    ApprovalWaitlist()
                } else {
                    GroupInfoChange()
                }
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
