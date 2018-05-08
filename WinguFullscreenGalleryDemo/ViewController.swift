//
//  ViewController.swift
//  WinguFullscreenGalleryDemo
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit
import WinguFullscreenGallery

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var winguGalleryView: WinguGalleryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var returnArray: [ImageAsset?] = [ImageAsset]()
        for i in 1...7 {
            let image = UIImage(named: String(i))
            let asset = ImageAsset(image: image!)
            returnArray.append(asset)
        }
        winguGalleryView.assets = returnArray
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
    }
    
}

