//
//  ViewController.swift
//  WinguFullscreenGalleryDemo
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit
import WinguGallery

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var winguGalleryView: WinguGalleryView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentedControlValueChanged(self.segmentedControl)
        self.winguGalleryView.preselectItem(at: 2)
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: self.fillWithLocalImages()
        case 1: self.fillWithURLImages()
        case 2: self.fillWithGifs()
        default: break
        }
    }

    func fillWithURLImages() {
        let lowRange: UInt32 = 600
        let highRange: UInt32 = 1200
        var returnArray: [ImageAsset?] = [ImageAsset]()
        for _ in 1...8 {
            let url = URL(string: "https://picsum.photos/\(Int(arc4random_uniform(highRange) + lowRange))/\(Int(arc4random_uniform(highRange) + lowRange))")
            let asset = ImageAsset(url: url!)
            returnArray.append(asset)
        }
        winguGalleryView.assets = returnArray
    }

    func fillWithLocalImages() {
        var returnArray: [ImageAsset?] = [ImageAsset]()
        for index in 1...8 {
            let image = UIImage(named: String(index))
            let asset = ImageAsset(image: image!)
            returnArray.append(asset)
        }
        winguGalleryView.assets = returnArray
    }

    func fillWithGifs() {
        let gifs: [String] = [
            "https://i.giphy.com/njSlroypPFvKo.gif",
            "https://i.giphy.com/wKQRIoFXsQIGA.gif",
            "https://i.giphy.com/3ohjUNy8TSfbaWVZlu.gif",
            "https://i.giphy.com/hrOSnyyh7O372.gif",
            "https://i.giphy.com/3YGKFfw611fZS.gif",
            "https://i.giphy.com/3o7qDLkrKr034Z3hQI.gif",
            "https://i.giphy.com/zvnMQ8j6lb9bW.gif",
            "https://i.giphy.com/mYb4JOmRfa5oKRh6k4.gif"
        ]
        var returnArray: [ImageAsset?] = [ImageAsset]()
        for item in gifs {
            let url = URL(string: item)
            let asset = ImageAsset(url: url!)
            returnArray.append(asset)
        }
        winguGalleryView.assets = returnArray
    }

}
