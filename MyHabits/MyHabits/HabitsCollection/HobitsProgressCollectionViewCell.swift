//
//  HobitsProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by tertyshniy on 04.04.2022.
//

import UIKit

class HobitsProgressCollectionViewCell: UICollectionViewCell {
    
    let happyLabel: UILabel = {
        let happyLabel = UILabel()
        happyLabel.backgroundColor = .white
        happyLabel.text = "Все получится!"
        happyLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        happyLabel.textColor = .systemGray
        happyLabel.toAutoLayout()
        return happyLabel
    }()

    let progressLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .white
        nameLabel.text = "50%"
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel.textColor = .systemGray
        nameLabel.toAutoLayout()
        return nameLabel
    }()

    let backgroudView: UIView = {
        let backgroudView = UIView()
        backgroudView.backgroundColor = .systemGray5
        backgroudView.layer.cornerRadius = 5
        backgroudView.layer.masksToBounds = true
        backgroudView.toAutoLayout()
        return backgroudView
    }()
    
    let progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = .purple
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.toAutoLayout()
        return progressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubviews(happyLabel,
                                progressLabel,
                                backgroudView,
                                progressView)
        
        activateConstraints()
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HobitsProgressCollectionViewCell {
    
    public func setCellFromDataSet(_ hobitName: String,bk: UIColor) {
        /*
        self.nameLabel.text = hobitName
        self.nameLabel.textColor = bk
        imageTakenToday.tintColor = bk
         */
    }

}


extension HobitsProgressCollectionViewCell {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            happyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            happyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            //happyLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            //nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50),
            //nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            //nameLabel.heightAnchor.constraint(equalToConstant: 100),
            
            progressLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 20),
            progressLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),
            
            backgroudView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: 10),
            backgroudView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            backgroudView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,constant: -24),
            backgroudView.heightAnchor.constraint(equalToConstant: 7),

            progressView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: 10),
            progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            progressView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5 , constant: -24),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
        ])
    }
}
