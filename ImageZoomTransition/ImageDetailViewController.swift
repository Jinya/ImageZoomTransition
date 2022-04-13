//
//  ImageDetailViewController.swift
//  ImageZoomTransition
//
//  Created by Jinya on 2022/4/13.
//

import UIKit

protocol ImageDetailViewControllerDelegate: AnyObject {
    func controller(_ controller: ImageDetailViewController, handlePanToInteractivePopGesture gesture: UIPanGestureRecognizer)
}

class ImageDetailViewController: UIViewController {
    weak var delegate: ImageDetailViewControllerDelegate?

    let imageView = UIImageView()

    init(delegate: ImageDetailViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        delegate?.controller(self, handlePanToInteractivePopGesture: gesture)
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
