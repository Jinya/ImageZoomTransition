//
//  ImageDetailViewController.swift
//  ImageZoomTransition
//
//  Created by Jinya on 2022/4/13.
//

import UIKit

class ImageDetailViewController: UIViewController {
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Image Detail"

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        view.addSubview(imageView)
        imageView.frame = .init(x: 100, y: 300, width: 300, height: 300)

        let panToDismiss = UIPanGestureRecognizer(target: self, action: #selector(interactivePopBack(_:)))

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(panToDismiss)
        if let defaultEdgePanToPop = navigationController?.interactivePopGestureRecognizer {
            panToDismiss.require(toFail: defaultEdgePanToPop)
        }
    }

    @objc func interactivePopBack(_ gesture: UIPanGestureRecognizer) {
//        navigationController?.popViewController(animated: true)
        if let navVC = navigationController as? NavController {
            navVC.handleSlideToPopGesture(gesture)
        }
    }

}

extension ImageDetailViewController: ZoomTransitionDelegate {
    func wantsZoomTransition(for type: TransitionType) -> Bool {
        return true
    }

    func zoomTransitionView(_ transition: ZoomTransition) -> UIView? {
        return self.imageView
    }

    func zoomTransitionWillBegin(_ transition: ZoomTransition) {
    }
}
