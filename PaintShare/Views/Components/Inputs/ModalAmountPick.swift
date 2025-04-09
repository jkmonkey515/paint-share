//
//  ModalAmountPick.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/26.
//

import SwiftUI

struct ModalAmountPick: View {
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var isWish: Bool = false
    
    @Binding var showModal: Bool
    
    @Binding var showPick: Bool
    
    var onConfirm: () -> Void
    
    var onCancel: () -> Void = {}
    
    @Binding var amountInteger: Int
    
    @Binding var amountDecimal: Int
    
    var amountDecimalList:[Int] = [0,25,50,75]
    
    var amountIsIntDecimalList:[Int] = [0]
    
    var onPickCancel: () -> Void = {}
    
    var onPickCompleted: () -> Void = {}
    
    @State var amountStr: String
    
    @State var selectPoint: String = ""
    
    var isInt: Bool = false
    
    var maxInt: Int = 100
    
    var maxFloat: Int = 0
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                }
            }
            .background(Color(hex: "707070").opacity(0.85))
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.primary)
                        .frame(height: 110)
                    Image("info-circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Spacer()
                Text(isWish == true ? "数量を入力してください" : "在庫数を入力してください")
                    .font(.regular16)
                    .foregroundColor(.mainText)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                VStack{
                    GeneralButton(disabled: true, onClick: {
                        showPick = true
                    }, label: {
                        Text("\(amountStr)")
                            .font(.bold27)
                            .foregroundColor(.mainText)
                    })
                    .padding(.bottom, 12)
                }
                .padding(.top, 16)
                .frame(width: 137, height: 64)
                .border(Color.primary, width: 5)
                HStack(){
                    GeneralButton(disabled: true, onClick: {
                        if isInt {
                            if (amountInteger != 0 ||  amountDecimal != maxFloat){
                                if amountDecimal == 0 {
                                    amountInteger = amountInteger - 1
                                    amountDecimal = maxFloat
                                }else{
                                    amountDecimal = amountDecimal - maxFloat
                                }
                                amountStr = String(amountInteger) + "." + String(amountDecimal)
                            }
                        }else{
                            if (amountInteger != 0 ||  amountDecimal != 0){
                                if amountDecimal == 0 {
                                    amountInteger = amountInteger - 1
                                    amountDecimal = 75
                                }else{
                                    amountDecimal = amountDecimal - 25
                                }
                                amountStr = String(amountInteger) + "." + String(amountDecimal)
                            }
                        }
                    }, label: {
                        Image("feather-minus-circle")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)
                    })
                    GeneralButton(disabled: true, onClick: {
                        if isInt {
                            if ((amountInteger != maxInt ||  amountDecimal != 0) && (Float(amountStr) ?? 0 < Float(String(maxInt) + "." + String(maxFloat)) ?? 0)){
                                if amountDecimal == maxFloat {
                                    amountInteger = amountInteger + 1
                                    amountDecimal = 0
                                }else{
                                    amountDecimal = amountDecimal + maxFloat
                                }
                                amountStr = String(amountInteger) + "." + String(amountDecimal)
                            }else{
                                if (amountInteger == maxInt && amountDecimal != maxFloat){
                                    amountDecimal = maxFloat
                                    amountStr = String(amountInteger) + "." + String(amountDecimal)
                                }
                            }
                        }else{
                            if (amountInteger != 99 ||  amountDecimal != 75){
                                if amountDecimal == 75 {
                                    amountInteger = amountInteger + 1
                                    amountDecimal = 0
                                }else{
                                    amountDecimal = amountDecimal + 25
                                }
                                amountStr = String(amountInteger) + "." + String(amountDecimal)
                            }
                        }
                    }, label: {
                        Image("feather-plus-circle")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    })
                }
                Spacer()
                HStack(spacing: 28) {
                    CommonButton(text: "キャンセル", color: Color.primary, width: 100, height: 28, onClick: {
                        self.showModal = false
                        onCancel()
                    })
                    CommonButton(text: "OK", color: Color.primary, width: 100, height: 28, onClick: {
                        self.showModal = false
                        onConfirm()
                        dialogsDataModel.showEditDialog = true
                        dialogsDataModel.editDialogText = isWish == true ? "数量を入力されました" : "在庫数を入力されました"
                    })
                }
                Spacer()
            }
            .background(Color.white)
            .frame(width: 303, height: 372)
            Spacer(minLength: 120)
        }
        .background(Color(hex: "707070").opacity(0.1))
        if showPick {
            if isInt {
                VStack(spacing: 0.0){
                    Spacer()
                    HStack{
                        GeneralButton(disabled: true, onClick: {
                            self.showPick = false
                            onPickCancel()
                        }, label: {
                            Text("キャンセル")
                                .font(.regular16)
                                .foregroundColor(Color(hex: "1e94fa"))
                        })
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        Spacer()
                        GeneralButton(disabled: true, onClick: {
                            if (amountInteger != 0 || amountDecimal != 0){
                                self.showPick = false
                                amountStr = String(amountInteger) + "." + String(amountDecimal)
                                onPickCompleted()
                            }
                        }, label: {
                            Text("更新")
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
                            ForEach(0 ..< Int(maxInt)+1) {
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
                            ForEach(amountIsIntDecimalList, id: \.self) {
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
            }else{
                VStack(spacing: 0.0){
                    Spacer()
                    HStack{
                        GeneralButton(disabled: true, onClick: {
                            self.showPick = false
                            onPickCancel()
                        }, label: {
                            Text("キャンセル")
                                .font(.regular16)
                                .foregroundColor(Color(hex: "1e94fa"))
                        })
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        Spacer()
                        GeneralButton(disabled: true, onClick: {
                            self.showPick = false
                            amountStr = String(amountInteger) + "." + String(amountDecimal)
                            onPickCompleted()
                        }, label: {
                            Text("更新")
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
            }
        }
    }
}
