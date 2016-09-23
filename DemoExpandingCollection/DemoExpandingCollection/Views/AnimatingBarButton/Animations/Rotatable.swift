//
//  Rotatable.swift
//  TestCollectionView
//
//  Created by Alex K. on 23/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol Rotatable {

  func rotateAnimationFrom(fromItem: UIView, toItem: UIView, duration: Double) 
}

extension Rotatable {

  func rotateAnimationFrom(fromItem: UIView, toItem: UIView, duration: Double) {
    
    let fromRotate  = animationFrom(from: 0, to: M_PI, key: "transform.rotation", duration: duration)
    let fromOpacity = animationFrom(from: 1, to: 0, key: "opacity", duration: duration)

    let toRotate    = animationFrom(from: -M_PI, to: 0, key: "transform.rotation", duration: duration)
    let toOpacity   = animationFrom(from: 0, to: 1, key: "opacity", duration: duration)
    
    fromItem.layer.add(fromRotate, forKey: nil)
    fromItem.layer.add(fromOpacity, forKey: nil)
    
    toItem.layer.add(toRotate, forKey: nil)
    toItem.layer.add(toOpacity, forKey: nil)
 }
  
  private func animationFrom(from: Double, to: Double, key: String, duration: Double) -> CABasicAnimation {
    return Init(CABasicAnimation(keyPath: key)) {
      $0.duration            = duration
      $0.fromValue           = from
      $0.toValue             = to
      $0.fillMode            = kCAFillModeForwards
      $0.isRemovedOnCompletion = false
    }
  }
}
