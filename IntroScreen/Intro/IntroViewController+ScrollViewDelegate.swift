//
//  IntroViewController+ScrollViewDelegate.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

extension IntroViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            let startColor = self.startColor,
            let targetColor = self.targetColor
            else { return }
        
        let numberOfPages = introDataSource.numberOfPages
        let offset = scrollView.contentOffset
        let scrolled = getScrolledPercentage(for: offset.x)
        
        guard scrolled != 0 else {
            self.startColor = targetColor
            return
        }
        
        if (introDataSource.fadeOutLastPage) {
            // to last page -> alpha transition, fade out
            if currentVC?.index == numberOfPages - 2, targetVC?.index == numberOfPages - 1 {
                fadeOut(hue: startColor, scrolled: scrolled)
                return
            }
            
            // from last page -> alpha transition, fade in
            if currentVC?.index == numberOfPages - 1, targetVC?.index == numberOfPages - 2 {
                fadeIn(hue: targetColor, scrolled: scrolled)
                return
            }
        }
        
        // color transition
        changeColor(
            from: startColor,
            to: targetColor,
            scrolled: scrolled
        )
    }
}
