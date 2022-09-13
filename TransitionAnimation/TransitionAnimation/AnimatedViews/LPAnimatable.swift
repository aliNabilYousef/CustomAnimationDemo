//
//  LPAnimatable.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/25/22.
//

import UIKit

protocol LPAnimatable {
    var animationType: AnimationType? { get set }
    func animate()
}
