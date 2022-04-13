//
//  Coordinator.swift
//  ImageZoomTransition
//
//  Created by Jinya on 2022/4/14.
//

import UIKit

class Coordinator: NSObject {
    static let shared: Coordinator = .init(navVC: UINavigationController(rootViewController: ThumbImageViewController()))

    let navVC: UINavigationController
    let transitionController: ZoomTransitionController

    init(navVC: UINavigationController) {
        self.navVC = navVC
        self.transitionController = ZoomTransitionController(navigationController: navVC)

        super.init()
    }

    func showImageDetail(with image: UIImage) {
        let detailVC = ImageDetailViewController(delegate: self)
        detailVC.imageView.image = image
        navVC.pushViewController(detailVC, animated: true)
    }
}

extension Coordinator: ImageDetailViewControllerDelegate {
    func controller(_ controller: ImageDetailViewController, handlePanToInteractivePopGesture gesture: UIPanGestureRecognizer) {
        transitionController.handleSlideToPopGesture(gesture)
    }
}
