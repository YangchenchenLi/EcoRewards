//
//  EarningListView.swift
//  Eco Reward
//
//  Created by Yang Xu on 29/10/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct EarningListView: View {
    
    @ObservedObject var viewModel = EarningViewModel()
    
    var body: some View {
        
        //NavigationView {
        List(viewModel.record.sorted(by: { $0.order > $1.order })) { record in
            
            let points = Int(record.points + record.bonus)
            let avgstars = record.avgstars
            
            HStack(spacing:25){
                Image(uiImage: UIImage(named: "record.png")!)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .leading)
                
                Text("on \(record.date)").font(.headline)
                
                VStack(alignment: .trailing, spacing: 5){

                    Text("+ \(points) points").font(.headline)

                    Text("Average \(avgstars, specifier: "%.2f") ⭐️").font(.subheadline)
                }
                
            }
            
            //VStack(alignment: .leading) {
                
            
        }.onAppear() {viewModel.fetchData()}
        
    }
    
    
}


struct EarningListView_Previews: PreviewProvider {
    static var previews: some View {
        EarningListView()
    }
}
