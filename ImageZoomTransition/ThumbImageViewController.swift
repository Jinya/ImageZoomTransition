//
//  ThumbImageViewController.swift
//  ImageZoomTransition
//
//  Created by Jinya on 2022/4/13.
//

import UIKit

class ThumbImageViewController: UIViewController {
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Thumb Image"

        guard let imagePath = Bundle.main.path(
            forResource: "demoImage",
            ofType: "jpeg"
        ) else { fatalError() }
        imageView.image = UIImage(contentsOfFile: imagePath)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        view.addSubview(imageView)
        imageView.frame = .init(x: 50, y: 100, width: 100, height: 100)

        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(pushToDetail))
        )
    }

    @objc func pushToDetail() {
        guard let image = imageView.image else {
            fatalError()
        }
        Coordinator.shared.showImageDetail(with: image)
    }
}

extension ThumbImageViewController: ZoomTransitionDelegate {
    func wantsZoomTransition(for type: TransitionType) -> Bool {
        return true
    }

    func zoomTransitionView(_ transition: ZoomTransition) -> UIView? {
        return self.imageView
    }

    func zoomTransitionWillBegin(_ transition: ZoomTransition) {
        self.imageView.isHidden = true
    }

    func zoomTransitionDidEnd(_ transition: ZoomTransition) {
        imageView.isHidden = false
    }
}

