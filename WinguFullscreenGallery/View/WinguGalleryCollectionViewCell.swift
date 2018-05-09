//
//  WinguGalleryCollectionViewCell.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

class WinguGalleryCollectionViewCell: UICollectionViewCell {
    static var reusableIdentifier: String = "WinguGalleryCollectionViewCell"
    
    private var dataTask: URLSessionDataTask?
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var galleryImageView: UIImageView!
    
    func withImageAsset(_ asset: ImageAsset?) {
        guard let asset = asset else { return }
        if let image = asset.image {
            galleryImageView.image = self.fitIntoFrame(image: image)
        } else if asset.url != nil {
            self.galleryImageView.image = UIImage()
            self.dataTask = asset.download { (success) in
                self.galleryImageView.image = self.fitIntoFrame(image: asset.image)
                self.redrawConstraintIfNeeded()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.scrollView.maximumZoomScale = 4
        self.redrawConstraintIfNeeded()
    }
    
    func cancelPendingDataTask() {
        self.dataTask?.cancel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.scrollView.setZoomScale(1, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // limitation of cell lifecycle
            self.redrawConstraintIfNeeded()
        }
    }
    
    func setMargins(_ value: CGFloat) {
        self.topConstraint.constant = value
        self.bottomConstraint.constant = value
    }
    
    func redrawConstraintIfNeeded() {
        let imageHeight = self.galleryImageView.frame.size.height
        let imageWidth = self.galleryImageView.frame.size.width
        let spaceLeftVertical = self.scrollView.frame.size.height-imageHeight
        let spaceLeftHorizontal = self.scrollView.frame.size.width-imageWidth
        print(spaceLeftHorizontal)
        let constraintConstantValue = spaceLeftVertical/2 > 0 ? spaceLeftVertical/2 : 0
        self.setMargins(constraintConstantValue)
        self.layoutIfNeeded()
    }
    
    private func fitIntoFrame(image: UIImage?) -> UIImage? {
        guard let image = image else { return nil }
        var reqWidth: CGFloat = frame.size.width
        if image.size.width > reqWidth {
            reqWidth = image.size.width
        }
        let imageRatio = image.size.width/image.size.height
        let size = CGSize(width: reqWidth, height: reqWidth/imageRatio)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let finalImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if imageRatio < (UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height) {
            self.imageHeightConstraint.constant = frame.size.height
        } else {
            self.imageHeightConstraint.constant = frame.size.width/imageRatio
        }
        return finalImage
    }
}

extension WinguGalleryCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.galleryImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.redrawConstraintIfNeeded()
    }
}
