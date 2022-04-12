import UIKit

class HobitsCollectionViewCell: UICollectionViewCell {
    
    static let imageTakenTodayUncheck: UIImage? = UIImage(systemName: "circle")
    static let imageTakenTodayCheck: UIImage? = UIImage(systemName: "checkmark.circle.fill")
    
    static let needUpdateCellNotification: String = "needUpdateCellNotification"
    static let showdDetailViewNotification: String = "showdDetailViewNotification"
    
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
                counterLabel.text = "\(Consts.HobitsCollectionViewCell.Caption.countField) \(habit.trackDates.count)"
                
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
        nameLabel.font = Consts.FontPalette.Headline.font
        nameLabel.textColor = Consts.FontPalette.Headline.color
        nameLabel.numberOfLines = 2
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    private let dateStringLabel: UILabel = {
        let dateStringLabel = UILabel()
        dateStringLabel.font = Consts.FontPalette.Caption.font
        dateStringLabel.textColor = Consts.FontPalette.Caption.color
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
        counterLabel.text = Consts.HobitsCollectionViewCell.Caption.countField
        counterLabel.font = Consts.FontPalette.Footnote.font
        counterLabel.textColor = Consts.FontPalette.Footnote.color
        counterLabel.toAutoLayout()
        return counterLabel
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Consts.ColorPalette.backgroundView
        contentView.addSubviews(nameLabel,
                                dateStringLabel,
                                imageTakenToday,
                                counterLabel)
        activateConstraints()
            
        let tapImageTakenTodayGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageTakenToday(_:)))
        imageTakenToday.isUserInteractionEnabled = true
        imageTakenToday.addGestureRecognizer(tapImageTakenTodayGestureRecognizer)
        
        let tapContentViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapContentView(_:)))
        tapContentViewGestureRecognizer.numberOfTapsRequired = 2
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(tapContentViewGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HobitsCollectionViewCell {
    
    @objc private func tapImageTakenToday(_ recognizer: UITapGestureRecognizer) {
        if let habit = self.habitFromCell {
            if habit.isAlreadyTakenToday {
                //store.untrack(habit)
                HabitsStore.shared.untrack(habit)
            } else {
                //store.track(habit)
                HabitsStore.shared.track(habit)
            }
            let userInfoNatification: [String : Any] = ["HobitsCollectionViewCell": self]
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(HobitsCollectionViewCell.needUpdateCellNotification),
                                    object: nil,
                                    userInfo: userInfoNatification)
            //HabitsStore.shared.track(habit)
        }
    }
    
    @objc private func tapContentView(_ recognizer: UITapGestureRecognizer) {
        if let habit = self.habitFromCell {
            let userInfoNatification: [String : Any] = ["habitFromCell": habit]
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(HobitsCollectionViewCell.showdDetailViewNotification),
                                    object: nil,
                                    userInfo: userInfoNatification)
        }
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
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsCollectionViewCell.Margin.leading),
            nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Consts.HobitsCollectionViewCell.Margin.widthMultiplier),
            
            dateStringLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 4),
            dateStringLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsCollectionViewCell.Margin.leading),
            dateStringLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Consts.HobitsCollectionViewCell.Margin.widthMultiplier),
            
            imageTakenToday.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            imageTakenToday.widthAnchor.constraint(equalToConstant: Consts.HobitsCollectionViewCell.SizeItem.imageTakenToday),
            imageTakenToday.heightAnchor.constraint(equalToConstant: Consts.HobitsCollectionViewCell.SizeItem.imageTakenToday),
            imageTakenToday.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            
            counterLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -20),
            counterLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsCollectionViewCell.Margin.leading),
            counterLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: Consts.HobitsCollectionViewCell.Margin.widthMultiplier),
        ])
    }
}
