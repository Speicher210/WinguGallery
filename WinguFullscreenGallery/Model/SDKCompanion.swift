//
//  SDKCompanion.swift
//  winguSDKContent
//
//  Created by Jakub Mazur on 26/04/2018.
//  Copyright © 2018 Jakub Mazur. All rights reserved.
//

import UIKit

class SDKCompanion: NSObject {
    internal func sdkBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }

    internal func nibNameSDK(_ nibName: String) -> UINib {
        return UINib.init(nibName: nibName, bundle: SDKCompanion().sdkBundle())
    }

    class func image(_ imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: SDKCompanion().sdkBundle(), compatibleWith: nil)
    }
}
