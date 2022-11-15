
//  MainListView.swift
//  MEMENTO
//
//  Created by 최승원 on 2022/11/10.


import SwiftUI
import Inject

struct MainView: View {
    @ObservedObject private var iO = Inject.observer
    @StateObject var viewModel = MainViewModel()
    
    @State var openPhotoPicker = false
    @State var image = UIImage()
    @State var openAlarmPicker = false
    
   
    var body: some View {
        NavigationView {
        
            VStack{
                GeometryReader { reader in
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            ForEach(viewModel.contents.indices, id: \.self) { index in
                                VStack(alignment: .leading) {
                                    let content = viewModel.contents[index]
                                    
                                    if index == viewModel.contents.count - 1 {
                                        DividerView(comment: "\(DateStringFormatter(date: content.date!).getByDay()) 의 기록")
                                    }
                                    
                                    ContentView(viewModel: viewModel, content: content)
                                    Spacer()
                                        .frame(height: 24)
                                    
                                    if index != 0 && DateStringFormatter(date: content.date!).getByDay() != DateStringFormatter(date: viewModel.contents[index-1].date!).getByDay(){
                                        DividerView(comment: "\(DateStringFormatter(date: content.date!).getByDay()) 의 기록")
                                    }
                                }
                                .rotationEffect(.radians(.pi))
                                .scaleEffect(x: -1, y: 1, anchor: .center)
                                
                            }
                        }.padding(12)
                    }
                    .rotationEffect(.radians(.pi))
                    .scaleEffect(x: -1, y: 1, anchor: .center)
                }
                
                // MARK: TypingView
                typingView
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar { // <2>
                    ToolbarItem(placement: .principal) { // <3>
                        HStack() {
                            Text("MEMENTO")
//                                .font(.headline)
                                .font(.custom("Pretendard-ExtraLight", size: 20 ))
                            Spacer()
                            
                            HStack(alignment: .lastTextBaseline){
                                Button(action: { print("filter button click")}) {
                                    Image(systemName: "slider.vertical.3")
                                        .foregroundColor(.black)
                                    }
                                Button(action: { print("setting button click")}) {
                                    Image(systemName: "gearshape")
                                        .foregroundColor(.black)
                                    }
                            }
                            
                        }
                    }
                }
                
            
            
        }.enableInjection()
    }
        
}

struct DividerView: View {
    let comment: String
    
    var body: some View {
        Text(comment)
            .font(.system(size: 15, weight: .semibold))
        Divider()
            .background(Color.gray)
        Spacer()
            .frame(height: 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
