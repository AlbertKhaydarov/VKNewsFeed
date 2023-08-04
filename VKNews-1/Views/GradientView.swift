//
//  GradientView.swift
//  VKNews-1
//
//  Created by Admin on 03.08.2023.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    private var startColor: UIColor = #colorLiteral(red: 1, green: 0.6317989826, blue: 0.6205432415, alpha: 1)
    private var endColor: UIColor = #colorLiteral(red: 1, green: 0.8585236669, blue: 0.5462808609, alpha: 1)
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}
