//
//  HabitDetailTableViewCell.swift
//  MyHabits
//
//  Created by tertyshniy on 09.04.2022.
//

import UIKit

class HabitDetailTableViewCell: UITableViewCell {

    static let classIdentifier: String = "HabitDetailTableViewCell"
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Consts.Global.localeIdentifier 
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private let dateItemLabel: UILabel = {
        let dateItemLabel = UILabel()
        dateItemLabel.font = Consts.FontPalette.Body.font
        dateItemLabel.textColor = Consts.FontPalette.Body.color
        dateItemLabel.numberOfLines = 1
        dateItemLabel.toAutoLayout()
        return dateItemLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubviews(dateItemLabel)
        activateConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HabitDetailTableViewCell {
    
    public func setCellFromDataSet(habit: Habit, date: Date) {
        self.dateItemLabel.text = dateFormatter.string(from: date)
        if store.habit(habit, isTrackedIn: date) {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }

}

extension HabitDetailTableViewCell {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            dateItemLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dateItemLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Consts.HabitDetailTableViewCell.Margin.leading)
        ])
    }
}
