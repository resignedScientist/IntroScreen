//
//  DefaultIntroPageViewController+Layout.swift
//  IntroScreen
//
//  Created by Norman Laudien on 18.04.20.
//

extension DefaultIntroPageViewController {
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            NSLayoutConstraint.deactivate(constraints)
            layout()
        }
    }
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    func layout() {
        switch traitCollection.verticalSizeClass {
        case .compact:
            layoutForSmallHeight()
        case .regular, .unspecified:
            layoutForLargeHeight()
        @unknown default:
            layoutForLargeHeight()
        }
    }
    
    private func layoutForLargeHeight() {
        let safeArea = view.safeAreaLayoutGuide
        
        constraints = [
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
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func layoutForSmallHeight() {
        let safeArea = view.safeAreaLayoutGuide
        
        constraints = [
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: view.frame.width / 15),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -32),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
