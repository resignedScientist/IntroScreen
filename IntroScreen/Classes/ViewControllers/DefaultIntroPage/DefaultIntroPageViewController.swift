//
//  DefaultIntroPageViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

public class DefaultIntroPageViewController: IntroPageViewController {
    private var subtitle: String?
    private var image: UIImage?
    private var textColor: UIColor?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    /// Returns a configured instance of the IntroPageViewController.
    /// - Parameters:
    ///   - index: The page index of this intro page.
    ///   - hue: The color hue between 0 & 1 for the HSV color.
    ///   - title: The page title.
    ///   - subtitle: The page subtitle.
    ///   - image: The page image.
    ///   - textColor: The text label color. Default is black.
    public static func getInstance(
        index: Int,
        hue: CGFloat,
        title: String?,
        subtitle: String?,
        image: UIImage?,
        textColor: UIColor = .black
    ) -> DefaultIntroPageViewController {
        let instance = UIStoryboard(name: "DefaultIntroPage", bundle: Bundle(for: self)).instantiateInitialViewController() as! DefaultIntroPageViewController
        instance.index = index
        instance.hue = hue
        instance.title = title
        instance.subtitle = subtitle
        instance.image = image
        instance.textColor = textColor
        return instance
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = textColor
        subtitleLabel.textColor = textColor
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
    }
}
