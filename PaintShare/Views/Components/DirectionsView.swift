//
//  DirectionsView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/05/23.
//

import SwiftUI

struct DirectionsView: View {
    @EnvironmentObject var directionsDataModel:DirectionsDataModel
    @State private var currentPage = 0
   //0: forward 1:backward
    @State private var direction = 0
    
    var body: some View {
        
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            //---------Image------------
            
            VStack{
//                PageView([
//                    AnyView(Page1()),
//                    AnyView(Page2()),
//                    AnyView(Page3())
//                ], currentPage:  $currentPage
//                )
                if (currentPage==0){
                    Page1()
                        .transition(.slide)
                }else if(currentPage == 1){
                    if (direction==0){
                    Page2()
                            .transition(.backslide)
                        
                    }else if(direction == 1){
                        Page2()
                            .transition(.slide)
                    }
                    
                }else if(currentPage == 2){
                    Page3()
                        .transition(.backslide)
                }
                
            }//.padding(.top, 50)
           // .frame(height:665.65)
            .padding(.bottom, 120)
            .allowsHitTesting(false)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
                debugPrintLog(message:value.translation)
                switch(value.translation.width, value.translation.height) {
                case (...0, -30...30):
                    if(currentPage == 2){
                        directionsDataModel.show = false
                    }else{
                        withAnimation(.easeInOut) {
                            self.currentPage = currentPage+1
                            direction=0
                        }
                        }
                case (0..., -30...30):
                    if(currentPage > 0){
                        withAnimation(.easeInOut) {
                    self.currentPage = currentPage-1
                            direction=1
                        }
                    }
                default:  debugPrintLog(message:"no clue")
                }
            }
            )
            //---------Circle------------
            VStack{
                Spacer()
                HStack(alignment: .center, spacing: 25){
                    Circle()
                        .fill(Color(hex: currentPage == 0 ? "#1E94FA" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(hex: currentPage == 1 ? "#1E94FA" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                    Circle()
                        .fill(Color(hex: currentPage == 2 ? "#1E94FA" : "#E0E0E0"))
                        .frame(width: 17, height: 17)
                }
                .padding(.top,18)
                .frame(width: 97, height: 17)
                .padding(.bottom,100)
                
            }
            
            //---------Button------------
           VStack{
                Spacer()
                ZStack(alignment: .center){
                    
                    //---------[次へ]------------
                    GeneralButton(onClick: {
                        if(currentPage == 2){
                            directionsDataModel.show = false
                        }else{
                            self.currentPage = currentPage+1}
                    }, label: {
                        if(currentPage == 2){
                            Text("始める")
                                .font(.regular18)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                
                        }else{
                            Text("次へ")
                                .font(.regular18)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
            
                        }
                    })
                        .background(Color(hex: "#086570"))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.2), radius:6, x: 0, y: 3)
                    
                    //---------[Skip]------------
                    if(currentPage != 2){
                        HStack{
                            Spacer()
                            GeneralButton(onClick: {
                                directionsDataModel.show = false
                                // self.presentationMode.wrappedValue.dismiss()//back to login
                            }, label: {
                                Text("Skip")
                                    .font(.regular18)
                                    .foregroundColor(Color(hex:"#56B8C4"))
                                
                            })
                        }
                        .padding(.trailing,35)
                    }//if
                }
            }
         //  .padding(.top,20)
            .padding(.bottom,30)
                //Spacer()
        }
    }
}


//---------PageView------------
struct Page1:View{
    var body: some View{
        Image("direction1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct Page2:View{
    var body: some View{
        Image("direction2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct Page3:View{
    var body: some View{
        Image("direction3")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
    }
}

