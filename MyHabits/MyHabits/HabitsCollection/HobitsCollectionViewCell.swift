//
//  HobitsCollectionViewCell.swift
//  MyHabits
//
//  Created by tertyshniy on 04.04.2022.
//

import UIKit

class HobitsCollectionViewCell: UICollectionViewCell {
    
    static let imageTakenTodayUncheck: UIImage? = UIImage(systemName: "circle")
    static let imageTakenTodayCheck: UIImage? = UIImage(systemName: "checkmark.circle.fill")
    
    static let needUpdateCellNotification: String = "needUpdateCellNotification"
    
    private var habitFromCell: Habit? {
        didSet {
            if let habit = habitFromCell {
                self.nameLabel.text = habit.name
                self.nameLabel.textColor = habit.color
                self.dateStringLabel.text = habit.dateString
                
                if habit.isAlreadyTakenToday {
                    self.imageTakenToday.image = HobitsCollectionViewCell.imageTakenTodayCheck
                } else {
                    self.imageTakenToday.image = HobitsCollectionViewCell.imageTakenTodayUncheck
                }
                self.imageTakenToday.tintColor = habit.color
                counterLabel.text = "Счетчик: \(habit.trackDates.count)"
                
            } else {
                self.nameLabel.text = nil
                self.nameLabel.textColor = nil
                self.dateStringLabel.text = nil
                self.imageTakenToday.image = nil
                self.imageTakenToday.tintColor = nil
                self.counterLabel.text = nil
            }
        }
    }

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    private let dateStringLabel: UILabel = {
        let dateStringLabel = UILabel()
        dateStringLabel.backgroundColor = .white
        dateStringLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        dateStringLabel.textColor = .systemGray2
        dateStringLabel.toAutoLayout()
        return dateStringLabel
    }()
    
    private let imageTakenToday: UIImageView = {
        let imageTakenToday = UIImageView()
        imageTakenToday.tintColor = .black
        imageTakenToday.toAutoLayout()
        return imageTakenToday
    }()
    
    private let counterLabel: UILabel = {
        let counterLabel = UILabel()
        counterLabel.backgroundColor = .white
        counterLabel.text = "Счетчик: 0"
        counterLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        counterLabel.textColor = .systemGray
        counterLabel.toAutoLayout()
        return counterLabel
    }()
        
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
            
        let tapImageTakenTodayGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageTakenToday(_:)))
        imageTakenToday.isUserInteractionEnabled = true
        imageTakenToday.addGestureRecognizer(tapImageTakenTodayGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HobitsCollectionViewCell {
    
    @objc private func tapImageTakenToday(_ recognizer: UITapGestureRecognizer) {
        if let habit = self.habitFromCell {
            if habit.isAlreadyTakenToday {
                store.untrack(habit)
            } else {
                store.track(habit)
            }
            let userInfoNatification: [String : Any] = ["HobitsCollectionViewCell": self]
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(HobitsCollectionViewCell.needUpdateCellNotification),
                                    object: nil,
                                    userInfo: userInfoNatification)
            //HabitsStore.shared.track(habit)
        }
        return
    }
}

extension HobitsCollectionViewCell {
    
    public func setCellFromDataSet(_ habit: Habit) {
        self.habitFromCell = habit
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
            imageTakenToday.widthAnchor.constraint(equalToConstant: 60),
            imageTakenToday.heightAnchor.constraint(equalToConstant: 60),
            imageTakenToday.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            
            counterLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -20),
            counterLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            counterLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
        ])
    }
}
