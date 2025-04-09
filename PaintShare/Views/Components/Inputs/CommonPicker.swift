//
//  CommonPicker.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/26.
//

import SwiftUI

struct CommonPicker: View {
    
    @Binding var selection: Int
    
    var pickList:[PickItem]
    
    var onCancel: () -> Void = {}
    
    var onCompleted: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()
            VStack(spacing: 0.0){
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
                Picker(selection: $selection, label: Text("picker")) {
                    ForEach(pickList, id: \.self) { (pickItem) in
                        Text(pickItem.value).tag(pickItem.key)
                                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .background(Color.white)
            }
            .background(Color.white)
        }.background(Color(hex: "707070").opacity(0.85))
    }
}
