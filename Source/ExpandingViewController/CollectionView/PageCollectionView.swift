//
//  PageCollectionView.swift
//  TestCollectionView
//
//  Created by Alex K. on 05/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageCollectionView: UICollectionView {
  
}

// MARK: init

extension PageCollectionView {
  
  class func createOnView(_ view: UIView,
                          layout: UICollectionViewLayout,
                          height:CGFloat,
                          dataSource: UICollectionViewDataSource,
                          delegate: UICollectionViewDelegate) -> PageCollectionView {
    
    let collectionView = Init(PageCollectionView(frame: CGRect.zero, collectionViewLayout: layout)) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.decelerationRate                          = UIScrollViewDecelerationRateFast
      $0.showsHorizontalScrollIndicator            = false
      $0.dataSource                                = dataSource
      $0.delegate                                  = delegate
      $0.backgroundColor                           = UIColor.clear
    }
    view.addSubview(collectionView)
    
    // add constraints
    _ = collectionView >>>- {
      $0.attribute = .height
      $0.constant  = height
    }
    [NSLayoutAttribute.left, .right, .centerY].forEach { attribute in
      _ = (view, collectionView) >>>- {
        $0.attribute = attribute
        $0.constant = 0
      }
    }
    
    return collectionView
  }
  
}
