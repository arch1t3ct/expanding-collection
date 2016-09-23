//
//  DemoViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 12/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class DemoViewController: ExpandingViewController {
  
  typealias ItemInfo = (imageName: String, title: String)
  var cellsIsOpen = [Bool]()
  let items: [ItemInfo] = [("item0", "Boston"),("item1", "New York"),("item2", "San Francisco"),("item3", "Washington")]
  
  @IBOutlet weak var pageLabel: UILabel!
}

// MARK: life cicle

extension DemoViewController {
  
  override func viewDidLoad() {
    itemSize = CGSize(width: 256, height: 335)
    super.viewDidLoad()
    
    registerCell()
    fillCellIsOpeenArry()
    addGestureToView(toView: collectionView!)
    configureNavBar()
  }
}

// MARK: Helpers 

extension DemoViewController {
  
  func registerCell() {
    let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
    collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
  }
  
  func fillCellIsOpeenArry() {
    for _ in items {
      cellsIsOpen.append(false)
    }
  }
  
  func getViewController() -> ExpandingTableViewController {
    let storyboard = UIStoryboard(storyboard: .Main)
    let toViewController: DemoTableViewController = storyboard.instantiateViewController()
    return toViewController
  }
  
  func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
}

/// MARK: Gesture

extension DemoViewController {
  
  func addGestureToView(toView: UIView) {
    let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(sender:)))) {
      $0.direction = .up
    }
    
    let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(sender:)))) {
      $0.direction = .down
    }
    toView.addGestureRecognizer(gesutereUp)
    toView.addGestureRecognizer(gesutereDown)
  }

  func swipeHandler(sender: UISwipeGestureRecognizer) {
    let indexPath = IndexPath(row: currentIndex, section: 0)
    
    guard let cell  = collectionView?.cellForItem(at: indexPath) as? DemoCollectionViewCell else { return }
    // double swipe Up transition
    if cell.isOpened == true && sender.direction == .up {
      pushToViewController(getViewController())
      
      if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(selected: true)
      }
    }
    
    let open = sender.direction == .up ? true : false
    cell.cellIsOpen(open)
    cellsIsOpen[indexPath.row] = cell.isOpened
  }
}

// MARK: UIScrollViewDelegate 

extension DemoViewController {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    pageLabel.text = "\(currentIndex+1)/\(items.count)"
  }
}

// MARK: UICollectionViewDataSource

extension DemoViewController {
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    
    guard let cell = cell as? DemoCollectionViewCell else { return }

    let index = indexPath.row % items.count
    let info = items[index]
    cell.backgroundImageView?.image = UIImage(named: info.imageName)
    cell.customTitle.text = info.title
    cell.cellIsOpen(cellsIsOpen[index], animated: false)
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? DemoCollectionViewCell
          , currentIndex == indexPath.row else { return }

    if cell.isOpened == false {
      cell.cellIsOpen(true)
    } else {
      pushToViewController(getViewController())
      
      if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
        rightButton.animationSelected(selected: true)
      }
    }
  }
}

// MARK: UICollectionViewDataSource

extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath as IndexPath)
  }
}
