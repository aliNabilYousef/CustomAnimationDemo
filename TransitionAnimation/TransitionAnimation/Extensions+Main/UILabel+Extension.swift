//
//  UILabel+Extension.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/24/22.
//

import UIKit

extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
}
