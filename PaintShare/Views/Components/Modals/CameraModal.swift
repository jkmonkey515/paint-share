//
//  CameraModal.swift
//  PaintShare
//
//  Created by Lee on 2022/5/25.
//

import SwiftUI
import StripeUICore

struct CameraModal: View {
    
    @Binding var showModal: Bool
    
    var text: String
    
    var disabled: Bool = false
    
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {
            
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(Color(hex:"#46747E"))
                .font(Font.system(size: 36, weight: .bold))
                .padding(.top,30)
            
            Text(text)
                .font(.bold27)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 0)
            GeneralButton(onClick: {
                if (disabled) {
                    
                }
            }, label: {

            })
            
            Spacer()
            
            VStack(spacing:10){
               
                HStack (alignment:.top,spacing:0){
                    Spacer()
                    Text("撮影の際は下記ご留意ください")
                        .font(.medium16)
                        .foregroundColor(. mainText)
                        .lineLimit(nil)
                    Spacer()
                }
               
                HStack (alignment:.top,spacing:0){
                    Spacer()
                                    Text("・ピントが合っていること")
                                        .font(.medium16)
                                        .foregroundColor(. mainText)
                                        .lineLimit(nil)
                    Text("こと")
                        .font(.medium16)
                        .foregroundColor(Color.white)
                       
                                    Spacer()
                }
                .padding(.top,10)
                
                HStack (alignment:.top,spacing:0){
                    Spacer()
                                    Text("・商品名がはっきりわかること")
                                        .font(.medium16)
                                        .foregroundColor(. mainText)
                                        .lineLimit(nil)
                
                                    Spacer()
                                }
                
            }
            .frame(width:UIScreen.main.bounds.size.width - 90)
            
            Spacer()
            OvalButton(text: "確認しました", width: 256, height: 50) {
                self.showModal = false
                onConfirm()
            }.padding(.bottom, 33)
        }
        .frame(width:UIScreen.main.bounds.size.width - 40 , height: 370)
    }
}
