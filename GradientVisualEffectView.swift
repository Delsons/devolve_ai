//
//  GradientVisualEffectView.swift
//  Devolve_Ai
//
//  Created by Delson Silveira on 9/20/16.
//  Copyright © 2016 Kongros Interactive. All rights reserved.
//

import Foundation
import UIKit

class GradientVisualEffectView: UIVisualEffectView {
    
    private let gradient: CAGradientLayer = {
        // You can tweak these colors and their alpha to get the desired gradient.
        // You can also mess with the gradient's locations.
        $0.colors = [
            UIColor.white.withAlphaComponent(0.3).cgColor,
            UIColor(red: 1, green: 0, blue: 0, alpha: 0.7).cgColor
        ]
        return $0
    } (CAGradientLayer())
    
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        layer.addSublayer(gradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Make sure the gradient's frame always matches the blur effect.
        gradient.frame = bounds
    }
    
}
