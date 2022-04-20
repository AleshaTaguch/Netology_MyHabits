import UIKit

enum HabitEditMode: String{
    case create = "Создать"
    case edit = "Править"
}

class HabitEditViewController: UIViewController {
    
    public var editMode: HabitEditMode = .create {
        didSet {
            title = self.editMode.rawValue
            habitEditView.editMode = self.editMode
            if self.editMode == .create {
                editHabit = nil
            }
        }
    }
        
    public var editHabit: Habit? {
        didSet {
            habitEditView.setFieldFromHabit(editHabit)
        }
    }
    
    private let habitEditView: HabitEditView = {
        let habitEditView = HabitEditView()
        habitEditView.toAutoLayout()
        return habitEditView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Consts.ColorPalette.backgroundViewController
        
        view.addSubviews(habitEditView)
        activateConstraints()
        
        //self.navigationItem.backButtonTitle = "Отмена"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(canselHabit))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabit))
        
        let notificationCenter = NotificationCenter.default
        // подписываемся на уведомления необходимости обновить ячейку
        notificationCenter.addObserver(self,
                                       selector: #selector(showColorPicker),
                                       name: NSNotification.Name(HabitEditView.showColorPickerNotification),
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(showDeleteHabitAlert),
                                       name: NSNotification.Name(HabitEditView.deleteHabitNotification),
                                       object: nil)
    }
}

extension HabitEditViewController {
    
    @objc func saveHabit() {
        let habit = habitEditView.getHabitFromField()
        if editMode == .create {
            //store.habits.append(habit)
            HabitsStore.shared.habits.append(habit)
        } else {
            editHabit?.name = habit.name
            editHabit?.date = habit.date
            editHabit?.color = habit.color
            //store.save()
            HabitsStore.shared.save()
        }
        canselHabit()
    }
    
    @objc func canselHabit() {
        dismiss(animated: true)
    }

    @objc private func showColorPicker(notification: NSNotification) {
         
        guard let selectedColor = notification.userInfo?["selectedColor"] as? UIColor else {
           return
        }
        
        let colorPicketView = UIColorPickerViewController()
        colorPicketView.delegate = habitEditView.self
        colorPicketView.isModalInPresentation = true
        colorPicketView.selectedColor = selectedColor
        
        present(colorPicketView, animated: true)
    }
    
    @objc private func showDeleteHabitAlert(notification: NSNotification) {
        
        var nameHabit: String
        if let name = editHabit?.name {
            nameHabit = name
        } else {
            nameHabit = Consts.HabitEditView.defaultHabitName
        }
        
        let alertViewController = UIAlertController(title: "Удалить привычку",
                                                    message: "Вы хотите удалить привычку \n\(nameHabit)",
                                                    preferredStyle: .alert)
        let deleteAlert = UIAlertAction(title: "Удалить", style: .default, handler: (deleteHabit))
        deleteAlert.setValue(UIColor.red, forKey: "titleTextColor")
        let cancelAlert = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertViewController.addAction(deleteAlert)
        alertViewController.addAction(cancelAlert)
                
        self.present(alertViewController, animated: true, completion: nil)
         
    }
    
    func deleteHabit(_ alertAction: UIAlertAction) {
        if let habit = editHabit {
            //store.remove(habit)
            HabitsStore.shared.remove(habit)
            dismiss(animated: true) //{
                //self.editHabit = nil
                //self.parent. .navigationController?.popViewController(animated: true)
            //}
            //dismiss(animated: true, completion: { navigationController?.popToRootViewController(animated: true)  })
            //navigationController?.popToRootViewController(animated: true)
        }
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

