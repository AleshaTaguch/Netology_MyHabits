
import UIKit

class HabitEditViewController: UIViewController {
    
    let habitEditView: HabitEditView = {
        let habitEditView = HabitEditView()
        habitEditView.toAutoLayout()
        return habitEditView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        view.addSubviews(habitEditView)
        activateConstraints()
        
        //self.navigationItem.backButtonTitle = "Отмена"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(canselHabit))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: habitEditView.self, action: #selector(saveHabit))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       navigationController?.navigationBar.prefersLargeTitles = true

    }
    
}


extension HabitEditViewController {
    
    @objc func saveHabit() {
        /*
        let nameForSave = nameTextField.text ??  "no name"
        let dateForSave = datePicker.date
        let colorForSave = colorView.backgroundColor ?? UIColor.white
        
        let habit = Habit(name: nameForSave, date: dateForSave, color: colorForSave)
        store.habits.append(habit)
        */
        navigationController?.popViewController(animated: true)
        
        return
    }
    
    @objc func canselHabit() {
        navigationController?.popViewController(animated: true)
        return
    }
    
}

extension HabitEditViewController {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            habitEditView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            habitEditView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            habitEditView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            habitEditView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension HabitEditViewController: UIColorPickerViewControllerDelegate {
   
    @objc func chageColor(_ recognizer: UITapGestureRecognizer) {
        /*
        let colorVC = UIColorPickerViewController()
        colorVC.delegate = self
        colorVC.isModalInPresentation = true
        if let currentColorView = colorView.backgroundColor {
            colorVC.selectedColor = currentColorView
        }
        present(colorVC, animated: true)
        */
        return
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        /*
        let colorSelect = viewController.selectedColor
        colorView.backgroundColor = colorSelect
        print("colorSelect=",colorSelect)
        */
    }
    
    
}
/*
class HabitEditViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .white
        nameLabel.text = "Наименование"
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.toAutoLayout()
        return nameLabel
    }()
    
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.backgroundColor = .white
        nameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameTextField.textColor = .blue
        nameTextField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        //nameTextField.addTarget(self, action:  #selector(statusTextChanged), for: .editingChanged)
        nameTextField.toAutoLayout()
        return nameTextField
    }()
  
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.backgroundColor = .white
        colorLabel.text = "Цвет"
        colorLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        colorLabel.textColor = .black
        colorLabel.toAutoLayout()
        return colorLabel
    }()
    
    let colorView: UIView = {
        let colorView = UIView()
        colorView.backgroundColor = .orange
        colorView.layer.cornerRadius = 30 / 2
        colorView.layer.masksToBounds = true
        colorView.toAutoLayout()
        return colorView
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = .white
        timeLabel.text = "Время"
        timeLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        timeLabel.textColor = .black
        timeLabel.toAutoLayout()
        return timeLabel
    }()

    
    let timeTextLabel: UILabel = {
        let timeTextLabel = UILabel()
        timeTextLabel.backgroundColor = .white
        timeTextLabel.text = "Каждый день в 11:00 PM"
        timeTextLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        timeTextLabel.textColor = .black
        timeTextLabel.toAutoLayout()
        return timeTextLabel
    }()
    
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action:  #selector(chageDatePicker), for: .valueChanged)
        datePicker.toAutoLayout()
        return datePicker
    }()
    
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setTitle("Удалить привычку", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        //deleteButton.addTarget(self, action: #selector(setStatusButtonPressed), for: .touchUpInside)
        deleteButton.toAutoLayout()
        return deleteButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Create/Edit"
        
        view.addSubviews(nameLabel,
                         nameTextField,
                         colorLabel,
                         colorView,
                         timeLabel,
                         timeTextLabel,
                         datePicker,
                         deleteButton)
        activateConstraints()
        
        nameTextField.becomeFirstResponder()
        
        self.navigationItem.backButtonTitle = "Отмена"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(canselHabit))
        
        let tapAvatarGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chageColor(_:)))
        colorView.isUserInteractionEnabled = true
        colorView.addGestureRecognizer(tapAvatarGestureRecognizer)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
       navigationController?.navigationBar.prefersLargeTitles = true

    }
    
}


extension HabitEditViewController {
    
    @objc func saveHabit() {
        let nameForSave = nameTextField.text ??  "no name"
        let dateForSave = datePicker.date 
        let colorForSave = colorView.backgroundColor ?? UIColor.white
        
        let habit = Habit(name: nameForSave, date: dateForSave, color: colorForSave)
        store.habits.append(habit)
        
        navigationController?.popViewController(animated: true)
        
        return
    }
    
    @objc func canselHabit() {
        navigationController?.popViewController(animated: true)
        return
    }
    
    @objc func chageDatePicker() {
        print("datePicker=",datePicker.date)
        
        return
    }
}

extension HabitEditViewController {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 22),
            
            colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            colorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            colorLabel.heightAnchor.constraint(equalToConstant: 18),
            
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            timeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            timeLabel.heightAnchor.constraint(equalToConstant: 18),
            
            timeTextLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timeTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            timeTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            timeTextLabel.heightAnchor.constraint(equalToConstant: 22),
  
            datePicker.topAnchor.constraint(equalTo: timeTextLabel.bottomAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            datePicker.heightAnchor.constraint(equalToConstant: 216),
            
            deleteButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            deleteButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 22),
   
        ])
    }
}


extension HabitEditViewController: UIColorPickerViewControllerDelegate {
   
    @objc func chageColor(_ recognizer: UITapGestureRecognizer) {
        
        let colorVC = UIColorPickerViewController()
        colorVC.delegate = self
        colorVC.isModalInPresentation = true
        if let currentColorView = colorView.backgroundColor {
            colorVC.selectedColor = currentColorView
        }
        present(colorVC, animated: true)
        return
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let colorSelect = viewController.selectedColor
        colorView.backgroundColor = colorSelect
        print("colorSelect=",colorSelect)
    }
    
    
}
*/
