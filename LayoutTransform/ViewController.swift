//
//  ViewController.swift
//  LayoutTransform
//
//  Created by Uporabnik on 05/07/2018.
//  Copyright © 2018 Uporabnik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var button1: UIButton!
    
    var viewWidth: CGFloat = 0
    var counter = 0
    
    var texts: [String] = ["Hello World", "Very Long Text ogadbigo obfsaio fbfasifoaib fabos "]
    var rotate: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.anchorPoint = CGPoint.zero
        containerView.translatesAutoresizingMaskIntoConstraints = true
        
        view.insertSubview(containerView, belowSubview: button1)
        
        if let text = texts.first {
            set(text: text)
        }
    }
    
    func set(text: String) {
        labelView.text = text
    }
    
    func updateContainer() {
        guard viewWidth > 0, let subview = containerView.subviews.first else {
            return
        }
        
        containerView.bounds = CGRect(x: 0, y: 0, width: viewWidth, height: 0)
        
        while containerView.needsUpdateConstraints() {
            containerView.updateConstraints()
        }
        
        containerView.layoutIfNeeded()
        
        let width = subview.frame.width
        let height = subview.frame.height
        
        containerView.center = CGPoint(x: viewWidth - (rotate ? height : width), y: (rotate ? width : 0) + button1.frame.maxY)
        containerView.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        containerView.transform = CGAffineTransform(rotationAngle: rotate ? -CGFloat.pi / 2 : 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if view.bounds.width != viewWidth {
            viewWidth = view.bounds.width
            updateContainer()
        }
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        counter += 1
        
        let idx = counter % texts.count
        
        set(text: texts[idx])
        rotate = counter % 2 == 0
        
        UIView.animate(withDuration: 1) {
            self.updateContainer()
        }
    }
}
