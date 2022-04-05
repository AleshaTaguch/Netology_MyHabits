//
//  HobitsCollectionViewCell.swift
//  MyHabits
//
//  Created by tertyshniy on 04.04.2022.
//

import UIKit

class HobitsCollectionViewCell: UICollectionViewCell {

    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .white
        nameLabel.text = "Наименование привычки Наименование привычки Наименование привычки Наименование привычки Наименование привычки"
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    let dateStringLabel: UILabel = {
        let dateStringLabel = UILabel()
        dateStringLabel.backgroundColor = .white
        dateStringLabel.text = "Каждый день в 17:00"
        dateStringLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        dateStringLabel.textColor = .systemGray2
        dateStringLabel.toAutoLayout()
        return dateStringLabel
    }()
    
    let imageTakenToday: UIImageView = {
        let imageTakenToday = UIImageView()
        imageTakenToday.image = UIImage(systemName: "checkmark.circle.fill")
        imageTakenToday.tintColor = .black
        imageTakenToday.toAutoLayout()
        return imageTakenToday
    }()
    
    let counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.backgroundColor = .white
        counterLabel.text = "Счетчик: 0"
        counterLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        counterLabel.textColor = .systemGray
        counterLabel.toAutoLayout()
        return counterLabel
    }()
    
    //checkmark.circle.fill
    //circle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubviews(nameLabel,
                                dateStringLabel,
                                imageTakenToday,
                                counterLabel)
        
        activateConstraints()
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HobitsCollectionViewCell {
    
    public func setCellFromDataSet(_ hobitName: String,bk: UIColor) {
        self.nameLabel.text = hobitName
        self.nameLabel.textColor = bk
        imageTakenToday.tintColor = bk
    }

}

extension HobitsCollectionViewCell {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            
            dateStringLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 4),
            dateStringLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            dateStringLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            
            imageTakenToday.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            //imageTakenToday.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageTakenToday.widthAnchor.constraint(equalToConstant: 60),
            imageTakenToday.heightAnchor.constraint(equalToConstant: 60),
            imageTakenToday.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            
            counterLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -20),
            counterLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            counterLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
        ])
    }
}
