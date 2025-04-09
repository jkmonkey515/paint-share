//
//  CommonDatePick.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/05/07.
//

import SwiftUI

struct CommonDatePick: View {
    
    @Binding var currentDate: Date
    
    var onCancel: () -> Void = {}
    
    var onCompleted: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack{
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
                DatePicker("", selection: $currentDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .padding(.top, -20.0)
                .background(Color.white)
            }
            .background(Color.white)
        }
        .background(Color(hex: "707070").opacity(0.85))
    }
}
