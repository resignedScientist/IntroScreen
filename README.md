# IntroScreen
A beautiful intro screen for iOS written in Swift.

![](IntroScreen.gif)

How to use:

1. Add a ViewController to your storyboard & set IntroViewController as the class.

2. Add a segue to this ViewController

3. Set the introDataSource to the IntroViewController in prepareForSegue()

3. Configure the ViewController in your data source like this:

```swift
var numberOfPages: Int {
  return 3
}

// Return true, if you want to fade out the last page colour into black.
var fadeOutLastPage: Bool {
  return false
}

func viewController(at index: Int) -> IntroPageViewController? {
  switch index {
    case 0:
      return DefaultIntroPageViewController.getInstance(
            index: index,
                hue: 30/360,
                title: "First page",
                subtitle: "This is the first page.",
                image: nil
            )
    case 1:
      return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 60/360,
                title: "Second page",
                subtitle: "This is the second page.",
                image: nil
            )
    case 2:
      return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 90/360,
                title: "Third page",
                subtitle: "This is the third page.",
                image: nil
            )
    default:
            return nil
  }
}


Of course you can also use a custom view controller for the pages. Just extend IntroPageViewController. But you have to give it a clear background, so that the colours are visible.
