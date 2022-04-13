//
//  ViewController.swift
//  ImageZoomTransition
//
//  Created by Jinya on 2022/4/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rootVC = Coordinator.shared.navVC

        addChild(rootVC)
        view.addSubview(rootVC.view)
        rootVC.didMove(toParent: self)

        rootVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
