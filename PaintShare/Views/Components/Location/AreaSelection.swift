//
//  AreaSelection.swift
//  PaintShare
//
//  Created by Limeng Ruan on 5/27/22.
//

import SwiftUI
import MapKit

struct AreaSelection: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var mapSearchDataModel:MapSearchDataModel
    
    @EnvironmentObject var locationHelper:LocationManager
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inventorySellSetDataModel:InventorySellSetDataModel
    
    @EnvironmentObject var inventoryDataModel:InventoryDataModel
    
    @EnvironmentObject var inventoryEditDataModel:InventoryEditDataModel
    
    @EnvironmentObject var inventorySearchDataModel: InventorySearchDataModel
    
    public var usedBy: Int//在庫登錄: 1、在庫検索: 2、検索条件設定: 3、
    
    var body: some View {
        let defaults = UserDefaults.standard
        VStack(spacing:1){
            CommonHeader(title: "エリア選択", showBackButton: true, onBackClick: {
                presentationMode.wrappedValue.dismiss()
            })
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 37)
                    .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
                
                HStack(spacing:0){
                    GeneralButton(onClick: {
                        mapSearchDataModel.selectionSwitchTab = 0
                    }, label: {
                        Text("地図から")
                            .font(.regular14)
                            .foregroundColor(mapSearchDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4"))
                            .frame(width: 148,height: 25)
                        
                    })
                    .background(mapSearchDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)
                    .cornerRadius(5)
                    
                    GeneralButton(onClick: {
                        mapSearchDataModel.selectionSwitchTab = 1
                    }, label: {
                        Text("地域から")
                            .font(.regular14)
                            .foregroundColor(mapSearchDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)
                            .frame(width: 148,height: 25)
                        
                    })
                    .background(mapSearchDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4"))
                    .cornerRadius(5)
                    .padding(.leading,40)
                    
                }
            }
            if (mapSearchDataModel.selectionSwitchTab == 0) {
                HStack(spacing: 20) {
                    HStack {
                        Image("magnifiying-glass")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Color(hex: "c2c2c2"))
                            .padding(.leading, 10)
                        TextField("Search...", text: $mapSearchDataModel.searchPhrase, onCommit: { locationHelper.search(mapSearchDataModel.searchPhrase)
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
                                mapSearchDataModel.searchPhrase = ""
                            })
                    }
                    .frame(height: 30)
                    .background(Color(hex: "f3f3f3"))
                    .cornerRadius(4)
                    
                    Text("Cancel")
                        .font(.regular12)
                        .foregroundColor(.mainText)
                        .onTapGesture(perform: {
                            mapSearchDataModel.searchPhrase = ""
                        })
                }
                .padding(.leading, 10)
                .padding(.trailing, 20)
                .frame(height: 50)
                .background(Color(hex: "FAFAFA"))
                ZStack {
                    MapView(centerCoordinate: $locationHelper.centerCoordinate)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            Spacer()
                            Image(systemName: "paperplane.circle.fill")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundColor(Color(hex: "56B8C4"))
                                .frame(width: 25, height: 25)
                                .padding(.top, 20)
                                .padding(.trailing, 20)
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
                        Spacer()
                        HStack{
                            GeneralButton(onClick: {
//                                LocationManager.getAddress(location: locationHelper.centerCoordinate) { address in
//                                    debugPrintLog(message:"---------------------------\n \(address)")
//                                    let alert = UIAlertController.init(title: address, message: nil, preferredStyle: .actionSheet)
//
//                                    let action = UIAlertAction.init(title: "OK", style: .cancel)
//                                    alert.addAction(action)
//                                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
//                                }
                                if (usedBy == 1) {
                                    inventoryDataModel.getAddressByCoordinate(lat: defaults.double(forKey: Constants.CENTER_LAT), lng: defaults.double(forKey: Constants.CENTER_LNG), dialogsDataModel: dialogsDataModel)
                                    inventorySellSetDataModel.navigationTag = nil
                                }else if (usedBy == 2){
                                    inventoryEditDataModel.getAddressByCoordinate(lat: defaults.double(forKey: Constants.CENTER_LAT), lng: defaults.double(forKey: Constants.CENTER_LNG), dialogsDataModel: dialogsDataModel)
                                    inventorySellSetDataModel.navigationTag = nil
                                }else if (usedBy == 3){
                                    inventorySearchDataModel.getAddressByCoordinate(lat: defaults.double(forKey: Constants.CENTER_LAT), lng: defaults.double(forKey: Constants.CENTER_LNG), dialogsDataModel: dialogsDataModel)
                                    inventorySearchDataModel.navigationTag = nil
                                }
                            }, label: {
                                Text("決定")
                                    .font(.regular18)
                                    .foregroundColor(.white)
                                    .frame(width: 340,height: 37)
                                
                            })
                            .background(Color(hex: "56B8C4"))
                            .cornerRadius(5)
                            .shadow(color: Color(hex: "000000").opacity(0.16), radius: 3, x: 0.0, y: 3)
                        }
                        .padding(.bottom,40)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.bottom)
            } else if (mapSearchDataModel.selectionSwitchTab == 1) {
                AreaView(usedBy: usedBy)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            locationHelper.centerCoordinate = locationHelper.currentLocation ?? CLLocation()
        })
        .onDisappear {
            mapSearchDataModel.searchPhrase = ""
            debugPrintLog(message:locationHelper.currentLocation)
            debugPrintLog(message:locationHelper.centerCoordinate)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}
