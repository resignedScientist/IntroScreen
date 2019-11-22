//
//  IntroDataSource.swift
//  IntroScreen
//
//  Created by Norman Laudien on 22.11.19.
//

public protocol IntroDataSource {
    var numberOfPages: Int { get }
    var fadeOutLastPage: Bool { get }
    
    func viewController(at index: Int) -> IntroPageViewController?
}

public extension IntroDataSource {
    
    var fadeOutLastPage: Bool { false }
}
