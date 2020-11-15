//
//  ContentView.swift
//  Eco Reward
//
//  Created by Yang Xu on 16/10/20.
//

import SwiftUI

struct TestView : View {
    var body: some View {
        
        ZStack{
            Color.green
            
            VStack {
                Text("Test1")
                Text("Test2")
                Text("Test3")
                Text("Test4")
                Text("Test5")
                Text("Test6")
                Text("Test7")
                Text("Test8")
                Text("Test9")
                Text("Test10")
            }
            
        }
        
    }
}

struct TEstView_Preview: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
