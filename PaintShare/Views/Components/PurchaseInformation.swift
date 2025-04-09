//
//  PurchaseInformation.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/24.
//

import SwiftUI

struct PurchaseInformation: View {
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0) {
                Text("購入情報")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#46747E"))
                Spacer()
            }
            
            HStack(spacing:0) {
                VStack {
                    HStack {
                        Text("お届け先")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("お届け日:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    
                }
                .frame(width: 80)
                .padding(.leading,10)
                
                VStack {
                    HStack {
                        Text("山田太郎,123-0022,埼玉県 北本市石...")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("2022年3月9日")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#1DB78B"))
                        Spacer()
                    }
                    
                }
                .padding(.leading,0)
                Spacer()
            }
            .padding(.top,10)
            
            Rectangle()
                .fill(Color(hex: "#7070704D"))
                .frame(height: 1)
                .padding(.top,10)
            //------------------------------------------
            HStack(spacing:0) {
                VStack {
                    HStack {
                        Text("商品の小計:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("配達料・手数料:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("合計:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("割引:")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    HStack {
                        Text("ご請求額:")
                            .font(.medium20)
                            .foregroundColor(Color(hex: "#707070"))
                        Spacer()
                    }
                    
                }
                .frame(width: 120)
                .padding(.leading,10)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("￥13500")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                    }
                    HStack {
                        Spacer()
                        Text("￥800")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                    }
                    HStack {
                        Spacer()
                        Text("￥14300")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                    }
                    HStack {
                        Spacer()
                        Text("-￥200")
                            .font(.regular14)
                            .foregroundColor(Color(hex: "#707070"))
                    }
                    HStack {
                        Spacer()
                        Text("￥14100")
                            .font(.medium20)
                            .foregroundColor(Color(hex: "#F16161"))
                    }
                }
                .padding(.trailing,10)
                .padding(.top,10)
            }
        }
        .frame(width:UIScreen.main.bounds.size.width - 40)
    }
}
