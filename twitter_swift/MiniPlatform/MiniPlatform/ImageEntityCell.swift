//
//  ImageEntityCell.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class ImageEntityCell : UICollectionViewCell {
    var imageView : TFNCachedImageView

    init(coder aDecoder: NSCoder!)
    {
        imageView = TFNCachedImageView(url: nil)
        super.init(coder: aDecoder)
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}
