import UIKit

public final class PushModalPresentationController: NSObject, UIViewControllerTransitioningDelegate {
  
  public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PushModalPresentTransitioning()
  }
  
  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return PushModalDismissTransitioning()
  }
  
}

private final class PushModalPresentTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.25
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let toViewController = transitionContext.viewController(forKey: .to) else {
      return
    }
    
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)
    
    var toViewInitialFrame   = transitionContext.initialFrame(for: toViewController)
    let toViewFinalFrame     = transitionContext.finalFrame(for: toViewController)
    toView.map(containerView.addSubview)
    
    toViewInitialFrame.origin = CGPoint(x: containerView.bounds.maxX, y: containerView.bounds.minY)
    toViewInitialFrame.size = toViewFinalFrame.size
    toView?.frame = toViewInitialFrame
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
      toView?.frame = toViewFinalFrame
    }) { _ in
      let isCompleted = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(isCompleted)
    }
  }
  
}

private final class PushModalDismissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.25
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromViewController = transitionContext.viewController(forKey: .from) else {
      return
    }
    
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)
    let fromView = transitionContext.view(forKey: .from)
    var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController)
    
    toView.map(containerView.addSubview)
    
    if let fromView = fromView {
      fromViewFinalFrame = fromView.frame.offsetBy(dx: fromView.frame.width, dy: 0)
    }
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.allowUserInteraction, .curveEaseOut], animations: {
      fromView?.frame = fromViewFinalFrame
    }) { _ in
      let isCompleted = !transitionContext.transitionWasCancelled
      transitionContext.completeTransition(isCompleted)
    }
  }
  
}
