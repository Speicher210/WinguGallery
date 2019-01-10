//
//  ImageAsset.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 08/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

public class ImageAsset: NSObject {

    public enum ImageType {
        case jpg
        case gif

        static func from(mimeType: String) -> ImageType? {
            if mimeType.contains("gif") { return .gif
            } else if mimeType.contains("jpg") { return .jpg }
            return nil
        }
    }

    public var url: URL?
    public var image: UIImage?
    public var type: ImageType?
    public var caption: String?

    private override init() { }

    public init(url: URL) {
        self.url = url
    }

    public init(url: URL, caption: String?) {
        self.url = url
        self.caption = caption
    }

    public init(image: UIImage) {
        self.image = image
    }

    public init(image: UIImage, caption: String?) {
        self.image = image
        self.caption = caption
    }

    func download(completion:@escaping(_ success: Bool?) -> Void) -> URLSessionDataTask? {
        return ImageAsset.download(url: url) { (success, image, type)  in
            self.image = image
            if let type = type {
                self.type = type
            }
            completion(success)
        }
    }

    static func download(url: URL?, completion:@escaping(_ success: Bool?, _ image: UIImage?, _ type: ImageAsset.ImageType?) -> Void) -> URLSessionDataTask? {
        guard let url = url else {
            completion(false, nil, nil)
            return nil
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                var image = UIImage(data: data)
                else {
                    DispatchQueue.main.async { completion(false, nil, nil) }
                    return
            }
            let type: ImageAsset.ImageType? = ImageType.from(mimeType: mimeType)
            if type == .gif, let gif = UIImage.gif(data: data) {
                image = gif
            }
            DispatchQueue.main.async { completion(true, image, type) }
        }
        dataTask.resume()
        return dataTask
    }

}
