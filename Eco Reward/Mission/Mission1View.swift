//
//  MissionView1.swift
//  MissionProject
//
//  Created by chenchen on 10/19/20.
//

import SwiftUI

struct MissionView1: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing:5){
                
                VStack{
                    Text("Task 01")
                        .font(Font.system(size:35))
                        .foregroundColor(Color.black)


                    Spacer()
                    
                    Text("For consumers who shop daily")
                        .foregroundColor(Color.white)
                        .font(Font.system(size:20))

                }
                .frame(width: UIScreen.main.bounds.width -  20, height: 80)
                .padding(20)
                .background(Color(red: 0.325, green: 0.71, blue: 0.376))
                
                ScrollView(.vertical){

                    // task one
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf1.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.0")
                                .font(Font.system(size:25))
                            
                            Text("spend over $10")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 10")
                                .font(Font.system(size:18))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .background(Color(red: 0.89, green: 0.90, blue: 0.88))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    
                    
                    // task two
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf2.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.5")
                                .font(Font.system(size:25))
                            
                            Text("spend over $10")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 15")
                                .font(Font.system(size:18))
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .background(Color(red:0.78, green: 0.788, blue: 0.77))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    
                    
                    // task three
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf3.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.0")
                                .font(Font.system(size:25))
                            
                            Text("spend over $15")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 20")
                                .font(Font.system(size:18))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .background(Color(red:0.6, green: 0.6588, blue: 0.569))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )

                    
                    // task four
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf4.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.5")
                                .font(Font.system(size:25))
                            
                            Text("spend over $15")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 25")
                                .font(Font.system(size:18))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .background(Color(red:0.615, green: 0.749, blue: 0.54))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    .background(Color.green)
                    
                    // task five
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf5.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.0")
                                .font(Font.system(size:25))
                            
                            Text("spend over $20")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 25")
                                .font(Font.system(size:18))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .background(Color(red:0.682, green: 0.89, blue: 0.561))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    
                    // task six
                    HStack(spacing:50){
                        Image(uiImage: UIImage(named: "leaf6.png")!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Average rating >= 4.5")
                                .font(Font.system(size:25))
                            
                            Text("spend over $20")
                                .font(Font.system(size:25))

                            
                            Text("Points: + 30")
                                .font(Font.system(size:18))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                    .background(Color.green)
                    
                    // empty stack
                    HStack(spacing:50){
                        Text("")
                    }
                    .frame(width: UIScreen.main.bounds.width -  20, height: 80)

                    
                }
                .frame(width: UIScreen.main.bounds.width -  20, height: UIScreen.main.bounds.height - 100)
                // set padding for both side
                .padding(20)
           
            }
        }
    }
}

struct MissionView1_Previews: PreviewProvider {
    static var previews: some View {
        MissionView1()
    }
}

