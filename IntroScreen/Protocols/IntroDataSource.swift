//
//  IntroDataSource.swift
//  IntroScreen
//
//  Created by Norman Laudien on 22.11.19.
//

public protocol IntroDataSource {
    
    /// The total number of pages.
    var numberOfPages: Int { get }
    
    /// Should the last page fade out to black background color?
    var fadeOutLastPage: Bool { get }
    
    /// Asks for the view controller at the specified index.
    func viewController(at index: Int) -> IntroPageViewController?
}

public extension IntroDataSource {
    
    var fadeOutLastPage: Bool { false }
}
