import UIKit

class HabitEditView: UIView {
    
    static let showColorPickerNotification: String = "showColorPickerNotification"
    static let deleteHabitNotification: String = "deleteHabitNotification"
    
    public var editMode: HabitEditMode = .create {
        didSet {
            deleteButton.isHidden = (self.editMode == .create)
        }
    }
       
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = Consts.HabitEditView.Caption.nameField
        nameLabel.font = Consts.FontPalette.FootnoteStatus.font
        nameLabel.textColor = Consts.FontPalette.FootnoteStatus.color
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    private let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.font = Consts.FontPalette.Headline.font
        nameTextField.textColor = Consts.FontPalette.Headline.color
        nameTextField.placeholder = Consts.HabitEditView.placeholderNameField
        nameTextField.toAutoLayout()
        return nameTextField
    }()
  
    private let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = Consts.HabitEditView.Caption.colorField
        colorLabel.font = Consts.FontPalette.FootnoteStatus.font
        colorLabel.textColor = Consts.FontPalette.FootnoteStatus.color
        colorLabel.toAutoLayout()
        return colorLabel
    }()
    
    private let colorView: UIView = {
        let colorView = UIView()
        colorView.backgroundColor = Consts.ColorPalette.defaultHabitColor
        colorView.layer.cornerRadius = Consts.HabitEditView.SizeItem.colorView / 2
        colorView.layer.masksToBounds = true
        colorView.toAutoLayout()
        return colorView
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = Consts.HabitEditView.Caption.timeField
        timeLabel.font = Consts.FontPalette.FootnoteStatus.font
        timeLabel.textColor = Consts.FontPalette.FootnoteStatus.color
        timeLabel.toAutoLayout()
        return timeLabel
    }()

    private let timeTextLabel: UILabel = {
        let timeTextLabel = UILabel()
        timeTextLabel.text = Consts.HabitEditView.Caption.timeFieldPrefix
        timeTextLabel.font = Consts.FontPalette.Body.font
        timeTextLabel.textColor = Consts.FontPalette.Body.color
        timeTextLabel.toAutoLayout()
        return timeTextLabel
    }()
    
    private let timeValueLabel: UILabel = {
        let timeValueLabel = UILabel()
        timeValueLabel.font = Consts.FontPalette.Body.font
        timeValueLabel.textColor = .purple
        timeValueLabel.toAutoLayout()
        return timeValueLabel
    }()
    
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action:  #selector(chageDatePicker), for: .valueChanged)
        datePicker.toAutoLayout()
        datePicker.locale = Consts.Global.localeIdentifier
        return datePicker
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        deleteButton.toAutoLayout()
        return deleteButton
    }()

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Consts.Global.localeIdentifier
        formatter.timeStyle = .short
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.borderWidth = Consts.Global.borderWidth
        self.layer.borderColor = Consts.Global.borderColor
        self.backgroundColor = Consts.ColorPalette.backgroundView
        
        self.addSubviews(nameLabel,
                         nameTextField,
                         colorLabel,
                         colorView,
                         timeLabel,
                         timeTextLabel,
                         timeValueLabel,
                         datePicker,
                         deleteButton)
        activateConstraints()
        
        nameTextField.becomeFirstResponder()
        
        let tapColorViewGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chageColor(_:)))
        colorView.isUserInteractionEnabled = true
        colorView.addGestureRecognizer(tapColorViewGestureRecognizer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HabitEditView {
    
    public func setFieldFromHabit(_ habit: Habit?) {
        if let habitValue = habit {
            nameTextField.text = habitValue.name
            colorView.backgroundColor = habitValue.color
            datePicker.date = habitValue.date

        } else {
            nameTextField.text = nil
            colorView.backgroundColor = Consts.ColorPalette.defaultHabitColor
            datePicker.date = Date.init()
        }
        chageDatePicker()
    }
    
    public func getHabitFromField() -> Habit {
        let nameForSave: String = nameTextField.text ??  Consts.HabitEditView.defaultHabitName
        let dateForSave: Date  = datePicker.date
        let colorForSave: UIColor = colorView.backgroundColor ?? Consts.ColorPalette.defaultHabitColor
        
        return Habit(name: nameForSave, date: dateForSave, color: colorForSave)
    }

}

extension HabitEditView {
    
    @objc private func chageDatePicker() {
        timeValueLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc private func tapDeleteButton() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(HabitEditView.deleteHabitNotification),
                                object: nil)
    }
    
}

extension HabitEditView {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Consts.HabitEditView.Margin.trailing),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            colorView.widthAnchor.constraint(equalToConstant: Consts.HabitEditView.SizeItem.colorView),
            colorView.heightAnchor.constraint(equalToConstant: Consts.HabitEditView.SizeItem.colorView),
            
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            
            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            timeTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            
            timeValueLabel.centerYAnchor.constraint(equalTo: timeTextLabel.centerYAnchor),
            timeValueLabel.leadingAnchor.constraint(equalTo: timeTextLabel.trailingAnchor),
            timeValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Consts.HabitEditView.Margin.trailing),
            
  
            datePicker.topAnchor.constraint(equalTo: timeTextLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.HabitEditView.Margin.leading),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Consts.HabitEditView.Margin.trailing),
            datePicker.heightAnchor.constraint(equalToConstant: Consts.HabitEditView.SizeItem.datePicker),
            
            deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18)
   
        ])
    }
}


extension HabitEditView: UIColorPickerViewControllerDelegate {
   
    @objc private func chageColor(_ recognizer: UITapGestureRecognizer) {
        if let selectedColor = colorView.backgroundColor {
            let userInfoNatification: [String : Any] = ["selectedColor": selectedColor]
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(HabitEditView.showColorPickerNotification),
                                    object: nil,
                                    userInfo: userInfoNatification)
        }
        /* // вариант через расширение класса uiview
        let colorVC = UIColorPickerViewController()
        colorVC.delegate = self
        colorVC.isModalInPresentation = true
        if let currentColorView = colorView.backgroundColor {
            colorVC.selectedColor = currentColorView
        }
        parentViewController?.present(colorVC, animated: true)
         */
        return
    }
    
    public func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let colorSelect = viewController.selectedColor
        colorView.backgroundColor = colorSelect
        print("colorSelect=",colorSelect)
    }
    
    
}

