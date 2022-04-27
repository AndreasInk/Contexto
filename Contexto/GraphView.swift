//
//  GraphView.swift
//  Contexto
//
//  Created by Andreas Ink on 4/26/22.
//

import SwiftUI

struct GraphView: View {
    @ObservedObject var noti: Noti
    @Binding var currentNoti: NotiData
    @State var currentBar = 1
    @State var showDates = false
    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                //ScrollViewReader { scroll in
                VStack(alignment: .leading, spacing: 2) {
                ForEach(Array(zip(currentNoti.ratings, currentNoti.ratings.indices)), id: \.1) { age, i in
                
            HStack {
                ZStack {
                RoundedRectangle(cornerRadius: 7.0)
                    .foregroundColor(.blue)
                 //   .animation(.easeInOut(duration: 1.5))
                    .frame(maxHeight: 25)
                    HStack {
                        Text("\(age.category)")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            .fixedSize()
                            
                        Spacer()
                    } .padding()
                }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                Group {
                   // Spacer(minLength: currentBar > i ? (100 - Double(age.rating)) * 2 : 0)
                    Spacer(minLength: (100 - Double(age.rating * 10)) * 2)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                            
                        currentBar += 1
                        }
                    }
                    let yes = currentNoti.ratings.indices.contains(i - 1)
                    if yes {
                        let ye = (age.date.components(separatedBy: ",").first) == (currentNoti.ratings[i - 1].date.components(separatedBy: ",").first)
                    Text( ye ? "" : (age.date.components(separatedBy: ",").first ?? ""))
                    }
                    Text(showDates ? (age.date.components(separatedBy: ",").last  ?? "") : String("\(age.rating)"))
                    .padding()
                    .fixedSize()
                }
            }
                }
            } .onTapGesture {
                withAnimation {
                    showDates.toggle()
                }
               
            }
            
               // }
            } //.frame(maxHeight: 150)
           
                //}
//        VStack {
//            Spacer(minLength: 300)
         //   TextAnimation(lettersArr: [Letter(letter: "The US population is aging", font: .title3),Letter(letter: "\"Age is the main risk factor for the prevalent diseases of developed countries.\"", font: .title3), Letter(letter: "Niccoli T, Partridge L. Ageing as a risk factor for disease. Curr Biol. 2012 Sep 11;22(17):R741-52. doi: 10.1016/j.cub.2012.07.024. PMID: 22975005.", font: .caption)], speed: 2, spacing: 0)
                    
                    .padding()
//                    .onAppear() {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                     //   showBtn = true
//                        }
//                    }
            
//            Button {
//                vm.currentView = .Intro
//            } label: {
//                Text("NEXT ->")
//                    .font(.system(.title, design: .monospaced).bold())
//            } .opacity(showBtn ? 1 : 0)
//            .buttonStyle(.borderedProminent)
//            .padding()
        }  .onAppear() {
            noti.populateGraphData()
        }
    }
}
