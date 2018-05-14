//
//  ImageAsset.swift
//  WinguFullscreenGallery
//
//  Created by Jakub Mazur on 08/05/2018.
//  Copyright © 2018 wingu GmbH. All rights reserved.
//

import UIKit

public class ImageAsset: NSObject {

    public var url: URL?
    public var image: UIImage?
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
        return ImageAsset.download(url: url) { (success, image) in
            self.image = image
            completion(success)
        }
    }

    static func download(url: URL?, completion:@escaping(_ success: Bool?, _ image: UIImage?) -> Void) -> URLSessionDataTask? {
        guard let url = url else {
            completion(false, nil)
            return nil
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async { completion(false, nil) }
                    return
            }
            DispatchQueue.main.async { completion(true, image) }
        }
        dataTask.resume()
        return dataTask
    }

}
