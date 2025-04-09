//
//  CommonAmountPick.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/19.
//

import SwiftUI

struct CommonAmountPick: View {
    
    @Binding var amountInteger: Int
    
    @Binding var amountDecimal: Int
    
    @State var selectPoint: String = ""
    
    var amountDecimalList:[Int] = [0,25,50,75]
    
    var onCancel: () -> Void = {}
    
    var onCompleted: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0.0){
            Spacer()
            HStack{
                GeneralButton(onClick: {
                    onCancel()
                }, label: {
                    Text("キャンセル")
                        .font(.regular16)
                        .foregroundColor(Color(hex: "1e94fa"))
                })
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                Spacer()
                GeneralButton(onClick: {
                    onCompleted()
                }, label: {
                    Text("完了")
                        .font(.regular16)
                        .foregroundColor(Color(hex: "1e94fa"))
                })
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
            }
            .background(Color(hex: "f5f5f5"))
            HStack(spacing: 0){
                Spacer()
                Picker(selection: self.$amountInteger, label: EmptyView()) {
                    ForEach(0 ..< 100) {
                        Text("\($0)")
                            .frame(width: 140, alignment: .trailing)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .onReceive([self.amountInteger].publisher.first()) { (value) in
                    debugPrintLog(message:"amountInteger: \(value)")}
                .labelsHidden()
                .frame(width: 150)
                .clipped()
                Picker(selection: self.$selectPoint, label: EmptyView()) {
                        Text(".")
                }
                .disabled(true)
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .frame(width: 10)
                .clipped()
                Picker(selection: self.$amountDecimal, label: EmptyView()) {
                    ForEach(amountDecimalList, id: \.self) {
                        Text("\($0)")
                            .frame(width: 140, alignment: .leading)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .onReceive([self.amountDecimal].publisher.first()) { (value) in
                    debugPrintLog(message:"amountDecimal: \(value)")}
                .labelsHidden()
                .frame(width: 150)
                .clipped()
                Spacer()
            }
            .background(Color.white)
        }
        .background(Color(hex: "707070").opacity(0.85))
    }
}
