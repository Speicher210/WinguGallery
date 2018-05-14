//
//  WinguNibLoadingView.swift
//  winguSDKContent
//
//  Created by Jakub Mazur on 21/04/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import UIKit

@IBDesignable
public class WinguGalleryNibLoadingView: UIView {

    @IBOutlet weak var view: UIView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        view = WinguBaseNibLoading.nibSetup(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = WinguBaseNibLoading.nibSetup(self)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.view.backgroundColor = .clear
    }
}

private class WinguBaseNibLoading: NSObject {
    class func loadViewFromNib(_ obj: UIView) -> UIView {
        let bundle = Bundle(for: type(of: obj))
        let nib = UINib(nibName: String(describing: type(of: obj)), bundle: bundle)
        let nibView = (nib.instantiate(withOwner: obj, options: nil).first as? UIView)!
        return nibView
    }

    class func nibSetup(_ obj: UIView) -> UIView {
        obj.backgroundColor = .clear
        let view: UIView = WinguBaseNibLoading.loadViewFromNib(obj)
        view.frame = obj.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        obj.addSubview(view)
        return view
    }
}
