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
    
    private var subtitle: String
    private var image: UIImage
    private var textColor: UIColor
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textColor
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var subtitleLabel: UILabel = {
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
    
    private func addViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    private func layout() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32),
            
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: 150),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -8),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
}
