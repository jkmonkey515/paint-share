//
//  WarehouseManagement.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/03.
//

import SwiftUI

struct WarehouseManagement: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var warehouseDataModel:WarehouseDataModel
    
    @EnvironmentObject var warehouseInfoChangeDataModel:WarehouseInfoChangeDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @State private var WarehouseMenu = ["倉庫管理","倉庫の削除"]
    
    var body: some View {
            VStack(spacing:0){
                CommonHeader(title: WarehouseMenu[warehouseDataModel.selectedWarehouseMenuTab], showBackButton: true, showHamburgerButton: false,onBackClick: {
                    presentationMode.wrappedValue.dismiss()
                })
                
                ZStack {
                    VStack(spacing:0){
                    HStack{
                        Text("登録件数: \(warehouseDataModel.count)件")
                            .font(.regular14)
                            .foregroundColor(Color(hex:"#545353"))
                        
                        Button(action:{
                            warehouseDataModel.navigationTag = 1
                            warehouseInfoChangeDataModel.reset()
                            warehouseInfoChangeDataModel.mode=0
                        }, label: {
                            Text("倉庫を追加")
                                .font(.regular18)
                                .foregroundColor(.white)
                                .frame(width: 215,height: 37)
                        })
                            .background(Color(hex: "56B8C4"))
                            .cornerRadius(8)
                            .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
                            .padding(.leading,30)
                    }
                    .frame(height: 76)
                    .padding(.leading,0)
                    
                    NavigationLink(
                        destination: WarehouseAdd(), tag: 1, selection: $warehouseDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                    
                    HStack {
                        Spacer()
                        Text(warehouseDataModel.selectedWarehouseMenuTab == 1 ? "倉庫一覧へ" :"倉庫の削除")
                            .font(.regular12)
                            .foregroundColor(.primary)
                            .padding(.trailing, 17)
                            .onTapGesture(perform: {
                                if(warehouseDataModel.selectedWarehouseMenuTab == 1){
                                    warehouseDataModel.selectedWarehouseMenuTab=0
                                    
                                }else{
                                    warehouseDataModel.selectedWarehouseMenuTab=1
                                }
                            })
                    }
                    
                    WarehouseListView()
                    
                    Spacer()
                    }
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
                warehouseInfoChangeDataModel.reset()
            })
            
    }
}
