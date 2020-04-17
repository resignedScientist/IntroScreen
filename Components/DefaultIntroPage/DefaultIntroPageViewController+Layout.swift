//
//  DefaultIntroPageViewController+Layout.swift
//  IntroScreen
//
//  Created by Norman Laudien on 18.04.20.
//

extension DefaultIntroPageViewController {
    
    func addViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    func layout() {
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
