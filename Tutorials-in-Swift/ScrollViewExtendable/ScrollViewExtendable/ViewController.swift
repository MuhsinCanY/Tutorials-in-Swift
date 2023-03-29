//
//  ViewController.swift
//  ScrollViewExtendable
//
//  Created by Muhsin Can Yılmaz on 28.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .systemRed
        
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.bounds.width - 20, height: view.bounds.height - 20))
        scrollView.backgroundColor = .systemGreen
        view.addSubview(scrollView)
        
        let upperButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 100))
        upperButton.backgroundColor = .systemBlue
        scrollView.addSubview(upperButton)
        
        let lowerButton = UIButton(frame: CGRect(x: 20, y: 2000, width: 100, height: 100))
        lowerButton.backgroundColor = .systemBlue
        scrollView.addSubview(lowerButton)
        
        scrollView.contentSize = CGSize(width: view.frame.width - 20, height: 2200)
        
    }

}

