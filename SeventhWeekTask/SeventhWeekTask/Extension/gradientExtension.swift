//
//  gradientExtension.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 04.07.2021..
//

import Foundation
import UIKit

extension UIView{
   
    func addBlackGradientLayerInForeground(colors:[UIColor]){
        self.layer.sublayers = nil
    let gradient = CAGradientLayer()
    gradient.frame = self.frame
    gradient.colors = colors.map{$0.cgColor}
    self.layer.insertSublayer(gradient, at: 0)
   }
   
   func addBlackGradientLayerInBackground(colors:[UIColor]){
    self.layer.sublayers = nil
    let gradient = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = colors.map{$0.cgColor}
    self.layer.insertSublayer(gradient, at: 0)
   }
}
