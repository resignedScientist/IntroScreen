//
//  IntroViewController+Lifecycle.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

extension IntroViewController {
    
    func changeColor(from startHue: CGFloat,
                     to targetHue: CGFloat,
                     scrolled: CGFloat) {
        let diff = targetHue - startHue
        let posDiff = diff < 0 ? diff * -1 : diff
        var hue: CGFloat
        if 1 - posDiff > posDiff { // shortest way is not over a color border (0 or 1)
            if diff > 0 { // start < target
                hue = diff * scrolled + startHue
            } else { // start > target
                hue = ((diff * scrolled * -1) - startHue) * -1
            }
        } else { // shortest way is over a color border (0 or 1)
            if diff > 0 { // start < target
                let total = startHue + 1 - targetHue
                hue = startHue - (total * scrolled)
                while hue < 0 {
                    hue += 1
                }
            } else { // start > target
                let total = 1 - startHue + targetHue
                hue = startHue + (total * scrolled)
                while hue > 1 {
                    hue -= 1
                }
            }
        }
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: 1
        )
    }
    
    func fadeOut(hue: CGFloat, scrolled: CGFloat) {
        let alpha = 1 - scrolled
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    func fadeIn(hue: CGFloat, scrolled: CGFloat) {
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: scrolled
        )
    }
    
    func getScrolledPercentage(for pixels: CGFloat) -> CGFloat {
        let width = view.frame.width
        let progressPixels = pixels - width
        return abs(progressPixels / width)
    }
}
