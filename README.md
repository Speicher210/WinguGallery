# WinguGallery

[![Version](https://img.shields.io/cocoapods/v/WinguGallery.svg?style=flat)](https://cocoapods.org/pods/WinguGallery)
[![License](https://img.shields.io/cocoapods/l/WinguGallery.svg?style=flat)](https://cocoapods.org/pods/WinguGallery)
[![Platform](https://img.shields.io/cocoapods/p/WinguGallery.svg?style=flat)](https://cocoapods.org/pods/WinguGallery)

View that provides scrollable galleries with zooming. It can be embedded in any other view and in `UIViewController`. Internally it uses `UICollectionView` to display images.

## Features
✅ - Implemented ⚠️ - Will be added in next releases (order may vary)

Basic implementation of a gallery is not listed here. See the screenshots to have basic idea of gallery view.

* ✅ Zooming
* ✅ GIFs Support
* ✅ Local images support
* ✅ Async download images to cell
* ⚠️ Vertical scrolling
* ⚠️ Spacing between images while swiping
* ⚠️ Loader
* ⚠️ Download better resolution while zooming callback

## Screenshots 📸

![Horizontal view](README_media/horizontal.png)<br/>
![Vertical view](README_media/horizontal.png)


## Example

You can clone project and run example demo. It will compile on simulator without any dependency or changes.

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.


To integrate WinguGallery into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "wingu-GmbH/WinguGallery"
```
Run carthage update to build the framework and drag the built WinguGallery.framework into your Xcode project.

### Cocoapods

WinguGallery is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WinguGallery'
```

## Author

Jakub Mazur, [@jkmazur](https://twitter.com/jkmazur)

## Thanks!

To [Unsplash](https://twitter.com/unsplash) for providing photos for this example and to photographers for sharing them! [@sylwiabartyzel](https://twitter.com/sylwiabartyzel), [@lechonkirb](https://twitter.com/lechonkirb), [@karlmagnuson](https://twitter.com/karlmagnuson), [@ludovic_photo](https://twitter.com/ludovic_photo), [@derekrliang](https://twitter.com/derekrliang), [@thetoleikis](https://twitter.com/thetoleikis), [@iwillbm](https://twitter.com/iwillbm), [@Nate_Dumlao](https://twitter.com/nate_dumlao)!

And [Picsum Photos](https://picsum.photos) 🙌 for handling asynchronous calls in the example

Gif support is possible thanks to [SwiftGif](https://github.com/swiftgif/SwiftGif)
## wingu

This is a wingu open source project. With wingu platform, API and SDK it is easier then ever to use proximity technologies in new and exciting ways, such as creating a simple app or adding proximity functionality to your existing application. For more information check out: [https://www.wingu.de/en/developer/](https://www.wingu.de/en/developer/) or start a free trail at [https://wingu-portal.de/register.](https://wingu-portal.de/register.)
## License

WinguGallery is available under the MIT license. See the LICENSE file for more info.

