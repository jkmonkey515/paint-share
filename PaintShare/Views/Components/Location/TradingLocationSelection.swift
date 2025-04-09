//
//  TradingLocationSelection.swift
//  PaintShare
//
//  Created by  Kaetsu Jo on 2022/06/01.
//

import SwiftUI
import MapKit

struct TradingLocationSelection: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    // 倉庫: 1、グループ: 2、
    public var usedBy: Int
    
    @EnvironmentObject var warehouseInfoChangeDataModel: WarehouseInfoChangeDataModel
    
    @Environment(\.presentationMode) var presentationModel: Binding<PresentationMode>
    
    @EnvironmentObject var tradingLocationDataModel:TradingLocationDataModel
    
    @EnvironmentObject var mapSearchDataModel:MapSearchDataModel
    
    @State private var selectionMenu = ["取引場所","都道府県","市区郡・町村"]
    
    @EnvironmentObject var locationHelper:LocationManager
    
    @EnvironmentObject var groupInfoChangeDataModel:GroupInfoChangeDataModel
    
    var body: some View {
        let defaults = UserDefaults.standard
        VStack(spacing:1){
            CommonHeader(title:selectionMenu[tradingLocationDataModel.selectedMenuTab]+"を選択", showBackButton: true, onBackClick: {
                presentationModel.wrappedValue.dismiss()
            })
            
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 37)
                    .shadow(color: Color(hex: "#000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
                
                HStack(spacing:0){
                    GeneralButton(onClick: {
                        mapSearchDataModel.selectionSwitchTab = 0
                    }, label: {
                        Text("地図から")
                            .font(.regular14)
                            .foregroundColor(mapSearchDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4")) //view_name.show? "56B8C4":"ffffff"
                            .frame(width: 148,height: 25)
                    })
                    .background(mapSearchDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)//view_name.show? "ffffff":"56B8C4"
                    .cornerRadius(5)
                    
                    GeneralButton(onClick: {
                        mapSearchDataModel.selectionSwitchTab = 1
                    }, label: {
                        Text("都道府県から")
                            .font(.regular14)
                            .foregroundColor(mapSearchDataModel.selectionSwitchTab == 0 ? Color(hex:"56B8C4") : Color.white)//view_name.show? "ffffff":"56B8C4"
                            .frame(width: 148,height: 25)
                    })
                    .background(mapSearchDataModel.selectionSwitchTab == 0 ? .white : Color(hex:"56B8C4"))// tview_name.show? "56B8C4":"ffffff"
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
                        TextField("Search...", text: $mapSearchDataModel.searchPhrase, onCommit: {
                            locationHelper.search(mapSearchDataModel.searchPhrase)
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
//
//                                    let alert = UIAlertController.init(title: address, message: nil, preferredStyle: .actionSheet)
//
//                                    let action = UIAlertAction.init(title: "OK", style: .cancel)
//                                    alert.addAction(action)
//                                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
//                                }
                                if (usedBy == 1) {
                                    warehouseInfoChangeDataModel.getAddressByCoordinate(lat: defaults.double(forKey: Constants.CENTER_LAT), lng: defaults.double(forKey: Constants.CENTER_LNG), dialogsDataModel: dialogsDataModel)
                                    warehouseInfoChangeDataModel.navigationTag = nil
                                }else if (usedBy == 2){
                                    groupInfoChangeDataModel.lat = defaults.double(forKey: Constants.CENTER_LAT)
                                    groupInfoChangeDataModel.lng = defaults.double(forKey: Constants.CENTER_LNG)
                                    groupInfoChangeDataModel.getAddressByCoordinate(lat: defaults.double(forKey: Constants.CENTER_LAT), lng: defaults.double(forKey: Constants.CENTER_LNG), dialogsDataModel: dialogsDataModel)
                                    groupInfoChangeDataModel.navigationTag = nil
                                }
                            }, label: {
                                Text("取引場所を設定")
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
                ZStack{
                    Color(hex: "#F1F1F1")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        List{
                            //都道府県を選択
                            HStack{
                                LocationMenuListTitle(title: selectionMenu[1],place:tradingLocationDataModel.selectionPrefecture?.name ?? "",tag: 1,selectedMenuTab: $tradingLocationDataModel.selectedMenuTab)
                            }
                            //市区郡・町村を選択
                            HStack{
                                LocationMenuListTitle(title: selectionMenu[2],place: tradingLocationDataModel.selectionCitiesName,tag: 2,selectedMenuTab: $tradingLocationDataModel.selectedMenuTab)
                            }
                        }
                        .listStyle(.plain)
                        .padding(.bottom)
                        
                        HStack{
                            GeneralButton(onClick: {
                                //
                                if (usedBy == 1) {
                                    warehouseInfoChangeDataModel.prefValue = tradingLocationDataModel.selectionPrefecture?.name ?? ""
                                    warehouseInfoChangeDataModel.municipalitieName = tradingLocationDataModel.selectionCitiesName
                                    warehouseInfoChangeDataModel.zipcode = ""
                                    warehouseInfoChangeDataModel.addressName = ""
                                    warehouseInfoChangeDataModel.navigationTag = nil
                                } else if (usedBy == 2) {
                                    groupInfoChangeDataModel.prefValue = tradingLocationDataModel.selectionPrefecture?.name ?? ""
                                    groupInfoChangeDataModel.municipalitieName = tradingLocationDataModel.selectionCitiesName
                                    groupInfoChangeDataModel.zipcode = ""
                                    groupInfoChangeDataModel.addressName = ""
                                    groupInfoChangeDataModel.navigationTag = nil
                                } else if (usedBy == 3) {

                                } else if (usedBy == 4) {

                                }
                            }, label: {
                                Text("取引場所を設定")
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
                    //head shadow
                    VStack {
                        Rectangle()
                            .fill(Color(hex: "#F1F1F1"))
                            .frame(height: 1)
                            .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 1)
                            .padding(.bottom)
                        Spacer()
                    }
                    
                    // Selection List
                    if (tradingLocationDataModel.selectedMenuTab == 1) {
                        TradingPrefectureView()
                    }
                    else if(tradingLocationDataModel.selectedMenuTab == 2) {
                        TradingCityView()
                        // EmptyView()
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            // right side selections
            tradingLocationDataModel.selectionPrefecture = nil
            tradingLocationDataModel.selectionCitiesName = ""
            
            // map
            locationHelper.centerCoordinate = locationHelper.currentLocation ?? CLLocation()
            if (mapSearchDataModel.searchPhrase.count > 0) {
                locationHelper.search(mapSearchDataModel.searchPhrase)
            }
        })
        .onDisappear {
            mapSearchDataModel.searchPhrase = ""
            debugPrintLog(message:locationHelper.currentLocation)
            debugPrintLog(message:locationHelper.centerCoordinate)
        }
    }
}
