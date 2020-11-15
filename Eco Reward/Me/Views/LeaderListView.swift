//
//  RecordsListView.swift
//  Eco Reward
//
//  Created by Yang Xu on 18/10/20.

import SwiftUI
import Firebase
import FirebaseAuth

//let testData = [
//    Leader(id: "001", nickname: "Monkey", points: 100),
//    Leader(id: "002", nickname: "Lion", points: 200),
//    Leader(id: "003", nickname: "Tiger", points: 300)



struct LeaderListView: View {
    
    // var leaders = testData
    
    // real-time data from the Firestore database
    @ObservedObject var viewModel = LeaderViewModel()
    @ObservedObject var extraViewModel = UserViewModel()
    
    
    
    
    
    var body: some View {
     
//        VStack(alignment: .leading) {
//
//            Text("Rank XXX").font(.headline)
//            Text("Me").font(.headline)
//            Text("XXX points").font(.subheadline)
//
//
//        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .topLeading).background(Color.white)


        //NavigationView {
        
        List(viewModel.leaders.sorted(by: { $0.points > $1.points })) { leader in
            
            HStack(spacing:25){
                
                Image(uiImage: UIImage(systemName: "person")!)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .leading)
                
                Text("Rank \(leader.rank)").font(.headline)
                Text(leader.nickname).font(.headline)
                Text("\(leader.points) points").font(.subheadline)
            }
            

            
        }.onAppear() {viewModel.fetchData()}
        
    }
    //.navigationBarTitle("Current Month Leaders")
    //}
}



struct LeaderListView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderListView()
        
    }
}

