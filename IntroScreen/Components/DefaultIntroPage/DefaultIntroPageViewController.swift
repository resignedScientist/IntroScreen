//
//  DefaultIntroPageViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

public class DefaultIntroPageViewController: IntroPageViewController {
    
    public let index: Int
    public let hue: CGFloat
    
    var subtitle: String
    var image: UIImage
    var textColor: UIColor
    var constraints = [NSLayoutConstraint]()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textColor
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.textColor = textColor
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 5
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return subtitleLabel
    }()
    
    /// - Parameters:
    ///   - index: The page index of this intro page.
    ///   - hue: The color hue between 0 & 1 for the HSV color.
    ///   - title: The page title.
    ///   - subtitle: The page subtitle.
    ///   - image: The page image.
    ///   - textColor: The text label color. Default is black.
    public init(
        index: Int,
        hue: CGFloat,
        title: String,
        subtitle: String,
        image: UIImage,
        textColor: UIColor = .black
    ) {
        self.index = index
        self.hue = hue
        self.subtitle = subtitle
        self.image = image
        self.textColor = textColor
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        addViews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
