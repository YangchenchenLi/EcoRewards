//
//  SettingsSection.swift
//  Eco Reward
//
//  Created by Yang Xu on 17/10/20.
//  Code adapted from AppStuff on YouTube.
//  Sources: (https://www.youtube.com/watch?v=WqPoFzVrLj8)



enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case Account
    case Settings
    
    var description: String {
        switch self {
        case .Account: return "Account"
        case .Settings: return "Settings"
            
        }
    }
}


enum AccountOptions: Int, CaseIterable, CustomStringConvertible {
    case myjourney
    case myranking
    case myearning
    
    var description: String {
        switch self {
        case .myjourney: return "My Journey"
        case .myranking: return "My Ranking"
        case .myearning: return "My Earning History"
        }
    }
}

enum SettingsOptions: Int, CaseIterable, CustomStringConvertible {
    //case settings
    case about
    case signout
    
    var description: String {
        switch self {
        //case .settings: return "Settings"
        case .about: return "About"
        case .signout: return "Sign Out"
        }
    }
}
