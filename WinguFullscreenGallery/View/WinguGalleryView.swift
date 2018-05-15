//
//  WinguGalleryView.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 04/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

public class WinguGalleryView: WinguGalleryNibLoadingView {
    @IBOutlet weak var collectionView: UICollectionView!

    public var assets: [ImageAsset?]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var preselectedIndex: Int = 0

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.collectionView.register(UINib.init(nibName: String(describing: WinguGalleryCollectionViewCell.self), bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: WinguGalleryCollectionViewCell.reusableIdentifier)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
        if let indexPath = self.collectionView.indexPathsForVisibleItems.last {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    public func preselectItem(at index: Int) {
        self.preselectedIndex = index
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.collectionView.scrollToItem(at: IndexPath(row: self.preselectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension WinguGalleryView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WinguGalleryCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: WinguGalleryCollectionViewCell.reusableIdentifier, for: indexPath) as? WinguGalleryCollectionViewCell)!
        cell.withImageAsset(assets?[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension WinguGalleryView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? WinguGalleryCollectionViewCell)?.cancelPendingDataTask()
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? WinguGalleryCollectionViewCell)?.withImageAsset(assets?[indexPath.row])
    }
}

extension WinguGalleryView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(collectionView.frame.size.width), height: floor(collectionView.frame.size.height))
    }
}

extension WinguGalleryView: WinguGalleryCollectionViewCellDelegate {
    func didStartZooming(_ cell: WinguGalleryCollectionViewCell) {
        //TODO: download better resoluton while zooming?
    }
}
