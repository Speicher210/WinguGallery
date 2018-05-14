//
//  WinguGalleryCollectionViewCell.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

protocol WinguGalleryCollectionViewCellDelegate: class {
    func didStartZooming(_ cell: WinguGalleryCollectionViewCell)
}

class WinguGalleryCollectionViewCell: UICollectionViewCell {
    static var reusableIdentifier: String = "WinguGalleryCollectionViewCell"

    private var dataTask: URLSessionDataTask?
    weak var delegate: WinguGalleryCollectionViewCellDelegate?

    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!

    private var observer: NSKeyValueObservation?

    func withImageAsset(_ asset: ImageAsset?) {
        guard self.dataTask?.state != URLSessionDataTask.State.running else { return }
        guard let asset = asset else { return }
        if asset.image != nil {
            self.apply(image: self.fitIntoFrame(image: asset.image))
        } else if asset.url != nil {
            self.galleryImageView.image = nil
            self.dataTask = asset.download { (_) in
                self.apply(image: self.fitIntoFrame(image: asset.image))
                self.redrawConstraintIfNeeded()
            }
        }
    }

    func apply(image: UIImage?) {
        guard let image = image else { return }
        self.galleryImageView.alpha = 0
        self.galleryImageView.image = image
        UIView.animate(withDuration: 0.1) {
            self.galleryImageView.alpha = 1
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.scrollView.maximumZoomScale = 4
        self.redrawConstraintIfNeeded()
        self.observer = self.observe(\.bounds, options: NSKeyValueObservingOptions.new, changeHandler: { (_, _) in
            self.apply(image: self.fitIntoFrame(image: self.galleryImageView.image))
            self.redrawConstraintIfNeeded()
        })
    }

    func cancelPendingDataTask() {
        self.dataTask?.cancel()
    }

    override func layoutSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.redrawConstraintIfNeeded()
        }
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.scrollView.setZoomScale(1, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // limitation of cell lifecycle
            self.redrawConstraintIfNeeded()
        }
    }

    func setMargins(vertical: CGFloat, horizontal: CGFloat) {
        self.topConstraint.constant = vertical
        self.bottomConstraint.constant = vertical
        self.leadingConstraint.constant = horizontal
        self.trailingConstraint.constant = horizontal
    }

    func redrawConstraintIfNeeded() {
        let imageHeight = self.galleryImageView.frame.size.height
        let imageWidth = self.galleryImageView.frame.size.width
        let spaceLeftVertical = self.scrollView.frame.size.height-imageHeight
        let spaceLeftHorizontal = self.scrollView.frame.size.width-imageWidth
        let constraintConstantValueVertical = spaceLeftVertical/2 > 0 ? spaceLeftVertical/2 : 0
        let constraintConstantValueHorizontal = spaceLeftHorizontal/2 > 0 ? spaceLeftHorizontal/2 : 0
        self.setMargins(vertical: constraintConstantValueVertical, horizontal: constraintConstantValueHorizontal)
        self.layoutIfNeeded()
    }

    private func fitIntoFrame(image: UIImage?) -> UIImage? {
        guard let image = image else { return nil }
        guard image.size != CGSize.zero else { return nil }
        let screenRatio = UIScreen.main.bounds.size.width/UIScreen.main.bounds.size.height
        var reqWidth: CGFloat = frame.size.width
        if image.size.width > reqWidth {
            reqWidth = image.size.width
        }
        let imageRatio = image.size.width/image.size.height
        if imageRatio < screenRatio {
            reqWidth = frame.size.height*imageRatio
        }
        let size = CGSize(width: reqWidth, height: reqWidth/imageRatio)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let finalImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if imageRatio < screenRatio {
            self.imageHeightConstraint.constant = frame.size.height
            self.imageWidthConstraint.constant = frame.size.height*imageRatio
        } else {
            self.imageHeightConstraint.constant = frame.size.width/imageRatio
            self.imageWidthConstraint.constant = frame.size.width
        }
        return finalImage
    }

    func redrawImage() {
        self.apply(image: self.fitIntoFrame(image: self.galleryImageView.image))
        self.redrawConstraintIfNeeded()
    }
}

extension WinguGalleryCollectionViewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.galleryImageView
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.delegate?.didStartZooming(self)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.redrawConstraintIfNeeded()
    }
}
