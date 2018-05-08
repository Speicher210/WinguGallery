//
//  SimpleZoom.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

class SimpleZoom: WinguNibLoadingView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        self.redrawHeighConstraints()
        super.layoutSubviews()
        self.manipulateImage()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.redrawHeighConstraints()
        self.scrollView.maximumZoomScale = 5.0
    }
    
    func redrawHeighConstraints() {
        let imageViewHeight = self.imageView.frame.size.height
        let zoomLevel = self.scrollView.zoomScale
        let left = self.scrollView.frame.size.height-imageViewHeight
        if left/2 > 0 {
        self.topConstraint.constant = left/2
        self.bottomConstraint.constant = left/2
        } else {
            self.topConstraint.constant = 0
            self.bottomConstraint.constant = 0
        }
        self.layoutIfNeeded()
    }
    
    func manipulateImage() {
        print(self.imageView.image?.size.width)
        let image = SDKCompanion.image("3")
        let imageRatio = (image?.size.width ?? 0)/(image?.size.height ?? 1)
        let size = CGSize(width: frame.size.width, height: frame.size.width/imageRatio)
        UIGraphicsBeginImageContext(size)
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        var finalImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.imageView.image = finalImage
        print(self.imageView.image?.size.width)
    }
}

extension SimpleZoom: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.redrawHeighConstraints()
    }
}
