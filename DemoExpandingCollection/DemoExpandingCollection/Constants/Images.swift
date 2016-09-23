// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum Asset: String {
  case BackgroundImage = "BackgroundImage"
  case CloseButton = "CloseButton"
  case Dots = "dots"
  case Face1 = "face1"
  case Face2 = "face2"
  case Heand = "heand"
  case Icons = "icons"
  case Image2 = "image2"
  case Item0 = "item0"
  case Item1 = "item1"
  case Item2 = "item2"
  case Item3 = "item3"
  case LocationButton = "locationButton"
  case Map = "map"
  case PinIcon = "pinIcon"
  case SearchIcon = "searchIcon"
  case Stars = "stars"
  case Title = "Title"

  var image: Image {
    return Image(asset: self)
  }
}
// swiftlint:enable type_body_length

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
