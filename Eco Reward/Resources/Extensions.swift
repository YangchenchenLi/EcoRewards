//
//  Extensions.swift
//  Eco Reward
//
//  Created by Yang Xu on 14/10/20.
//  Author: Yang Xu
//
//  Code adapted from iOS Academy on YouTube by Afraz Siddiqui
//  Source: (https://www.youtube.com/playlist?list=PL5PR3UyfTWvdlk-Qi-dPtJmjTj-2YIMMf)



import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
        
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.height + self.frame.origin.x
    }
}
