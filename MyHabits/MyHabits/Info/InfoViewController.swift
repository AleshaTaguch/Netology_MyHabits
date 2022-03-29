//
//  InfoViewController.swift
//  MyHabits
//
//  Created by tertyshniy on 29.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.layer.borderWidth = 0.5
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.isScrollEnabled = true
        
        scrollView.contentMode = .scaleToFill
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    let contentView: InfoContentView = {
        let contentView = InfoContentView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.title = Consts.TabPage.infoPageName
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        activateConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollView.contentSize = CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.size.width
                                      ,height: 22 + 24 + 16 + self.contentView.infoLabel.frame.size.height + 16)
    }
    
}

extension InfoViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
    
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
    
        ])
    }
}
