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

    @IBOutlet weak var winguGalleryView: WinguGalleryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var returnArray: [UIImage?] = [UIImage]()
        for i in 1...7 {
            returnArray.append(UIImage(named: String(i)))
        }
        winguGalleryView.images = returnArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

