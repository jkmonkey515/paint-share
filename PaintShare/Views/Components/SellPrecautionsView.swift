//
//  SellPrecautionsView.swift
//  PaintShare
//
//  Created by Lee on 2022/6/15.
//

import SwiftUI

struct SellPrecautionsView: View {
    @EnvironmentObject var sellPrecautionsDataModel:SellPrecautionsDataModel
    @State private var currentPage = 0
        
    var body: some View {
        
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            //---------Image------------
            VStack{
                PageView([
                    AnyView(Precaution(text: "在庫の「重量」や「使用期限日」を\n正確に入力してください", image: "sell-1")),
                    AnyView(Precaution(text: "注文が発生した場合\n「明確な納期」を購入予定者に\n連絡してください", image: "sell-3")),
                    AnyView(Precaution(text: "取引後は購入者より評価とアンケート\nがフィードバックされます", image: "sell-2")),
                    AnyView(Precaution(text: "その他、利用規約や投稿ガイドライン\nを遵守してご利用ください", image: "sell-4", textSecond: "一定基準以上の悪質な出品報告があった場合、\n販売利用の停止処置を行う可能性もございます")),
                   // AnyView(Precaution(text: "その他、利用規約や投稿ガイドラインを遵守してご利用ください", image: "sell-4", textSecond: "一定基準以上の悪質な出品報告があった場合、 販売利用の停止処置を行う可能性もございます")),
                ], currentPage:  $currentPage
                )
            }
            .frame(height: UIScreen.main.bounds.size.height-150)
            .allowsHitTesting(false)
            
            //---------Circle------------
            VStack{
                Spacer()
                HStack(alignment: .center, spacing: 25){
                    Circle()
                        .fill(Color(hex: currentPage == 0 ? "#56B8C4" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(hex: currentPage == 1 ? "#56B8C4" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(hex: currentPage == 2 ? "#56B8C4" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(hex: currentPage == 3 ? "#56B8C4" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                }
                .frame(width: 97, height: 17)
                .padding(.bottom,115)
                
            }
            
            //---------Button------------
            VStack{
                Spacer()
                ZStack(alignment: .center){
                    
                    //---------[次へ]------------
                    GeneralButton(onClick: {
                        if(currentPage == 3){
                            sellPrecautionsDataModel.show = false
                        }else{
                            self.currentPage = currentPage+1}
                    }, label: {
                        if(currentPage == 3){
                            Text("始める")
                                .font(.regular14)
                                .foregroundColor(.white)
                                .frame(width: 66, height: 30)
                        }else{
                            Text("次へ")
                                .font(.regular14)
                                .foregroundColor(.white)
                                .frame(width: 66, height: 30)
                        }
                    })
                        .background(Color(hex: "#1DB78B"))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius:6, x: 0, y: 3)
                    
                    //---------[Skip]------------
                    if(currentPage != 3){
                        HStack{
                            Spacer()
                            GeneralButton(onClick: {
                                sellPrecautionsDataModel.show = false
                            }, label: {
                                Text("Skip")
                                    .font(.regular16)
                                    .foregroundColor(Color(hex:"#1DB78B"))
                            })
                        }
                        .padding(.trailing,35)
                    }//if
                }
            }
            .padding(.bottom,60)
            
            //
            VStack{
                Spacer()
                HStack{
                    Image(systemName: sellPrecautionsDataModel.checked == true
                          ? "checkmark.square.fill"
                          : "square")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(Color(hex: "B2B2B2" ))
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if sellPrecautionsDataModel.checked == true {
                                sellPrecautionsDataModel.checked = false
                            }else{
                                sellPrecautionsDataModel.checked = true
                            }
                        }
                    Text("次回以降の表示を行わない。")
                        .font(.regular14)
                        .foregroundColor(.mainText)
                }
                .padding(.bottom,150)
                .padding(.horizontal, 40)
            }
        }
    }
}

struct Precaution:View{
    @EnvironmentObject var sellPrecautionsDataModel:SellPrecautionsDataModel
    var text: String
    var image: String
    var textSecond: String = ""
    var body: some View{
        VStack{
            Text("注意事項")
                .font(.bold27)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 15)
            Image(uiImage: UIImage(named: image)!)
                .resizable()
                .scaledToFill()
                .frame(width: 279, height: 281)
                .clipped()
                .padding(.top, 15)
            Text(text)
                .font(.bold20)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 15)
                .frame(height: 90)
            Text(textSecond)
                .font(.regular11)
                .foregroundColor(.subText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
                .padding(.top, -15)
                .padding(.bottom, -11)

            Spacer()
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
