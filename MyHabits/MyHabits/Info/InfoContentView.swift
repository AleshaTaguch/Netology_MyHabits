//
//  InfoContentView.swift
//  MyHabits
//
//  Created by tertyshniy on 29.03.2022.
//

import UIKit

class InfoContentView: UIView {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.text = "Привычка за 21 день"
        titleLabel.toAutoLayout()
        return titleLabel
    }()

    
    let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        infoLabel.textColor = .black
        infoLabel.backgroundColor = .white
        infoLabel.numberOfLines = 0
        infoLabel.text = Consts.intoText
        infoLabel.toAutoLayout()
        return infoLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubviews(titleLabel,infoLabel)
        activateConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InfoContentView {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
