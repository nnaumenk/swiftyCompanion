//
//  AMProgressBar.swift
//  Companion
//
//  Created by Nazar NAUMENKO on 5/11/19.
//  Copyright © 2019 Nazar NAUMENKO. All rights reserved.
//

import Foundation
import YLProgressBar

class ProgressBar : YLProgressBar {
    
    init (width: CGFloat, height: CGFloat, progress: CGFloat, color: UIColor){
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        self.progress = progress
        self.progressTintColor = color
        self.type = YLProgressBarType.flat
        self.stripesOrientation = .left
        self.stripesDirection = .right
        
        let stripe = Int(height / 1.5)
        
        self.stripesWidth = stripe
        self.stripesDelta = stripe
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



