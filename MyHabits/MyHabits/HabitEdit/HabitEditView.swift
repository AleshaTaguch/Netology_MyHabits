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
        nameLabel.backgroundColor = .white
        nameLabel.text = "НАЗВАНИЕ"
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    private let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.backgroundColor = .white
        nameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameTextField.textColor = .blue
        nameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        nameTextField.toAutoLayout()
        return nameTextField
    }()
  
    private let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.backgroundColor = .white
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        colorLabel.textColor = .black
        colorLabel.toAutoLayout()
        return colorLabel
    }()
    
    private let colorView: UIView = {
        let colorView = UIView()
        colorView.backgroundColor = .orange
        colorView.layer.cornerRadius = 30 / 2
        colorView.layer.masksToBounds = true
        //colorView.layer.borderWidth = 0.5
        //colorView.layer.borderColor = UIColor.lightGray.cgColor
        colorView.toAutoLayout()
        return colorView
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = .white
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        timeLabel.textColor = .black
        timeLabel.toAutoLayout()
        return timeLabel
    }()

    private let timeTextLabel: UILabel = {
        let timeTextLabel = UILabel()
        timeTextLabel.backgroundColor = .white
        timeTextLabel.text = "Каждый день в "
        timeTextLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeTextLabel.textColor = .black
        timeTextLabel.toAutoLayout()
        return timeTextLabel
    }()
    
    private let timeValueLabel: UILabel = {
        let timeValueLabel = UILabel()
        timeValueLabel.backgroundColor = .white
        timeValueLabel.text = "11:00 PM"
        timeValueLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeValueLabel.textColor = .blue
        timeValueLabel.toAutoLayout()
        return timeValueLabel
    }()
    
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action:  #selector(chageDatePicker), for: .valueChanged)
        datePicker.toAutoLayout()
        datePicker.locale = Locale(identifier: "ru_RU")
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
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .white
        
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
            colorView.backgroundColor = UIColor.orange
            datePicker.date = Date.init()
        }
        chageDatePicker()
    }
    
    public func getHabitFromField() -> Habit {
        let nameForSave: String = nameTextField.text ??  "no name"
        let dateForSave: Date  = datePicker.date
        let colorForSave: UIColor = colorView.backgroundColor ?? UIColor.orange
        
        return Habit(name: nameForSave, date: dateForSave, color: colorForSave)
    }

}

extension HabitEditView {
    
    @objc private func chageDatePicker() {
        timeValueLabel.text = dateFormatter.string(from: datePicker.date)//  getHabitFromField().dateString
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
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            timeTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            timeValueLabel.centerYAnchor.constraint(equalTo: timeTextLabel.centerYAnchor, constant: 0),
            timeValueLabel.leadingAnchor.constraint(equalTo: timeTextLabel.trailingAnchor, constant: 0),
            timeValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
  
            datePicker.topAnchor.constraint(equalTo: timeTextLabel.bottomAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 216),
            
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

