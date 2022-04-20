import UIKit

class HabitDetailViewController: UIViewController {
    
    public var editHabit: Habit?  {
        didSet {
            habitDetailTableView.editHabit = editHabit
        }
    }
    
    private let habitDetailTableView: HabitDetailTableView = {
        let habitDetailTableView = HabitDetailTableView()
        habitDetailTableView.toAutoLayout()
        return habitDetailTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Consts.ColorPalette.backgroundViewController
        self.view.addSubviews(habitDetailTableView)
        //activateConstraints()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showEditHabitView))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // проверяем удалена или нет привычка из массива
        guard let habit = editHabit, let _ = HabitsStore.shared.habits.first(where:  {$0 == habit}) else {
            navigationController?.popViewController(animated: true)
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        if let habit = editHabit {
            self.title = habit.name
        }
        activateConstraints()
    }
    
}

extension HabitDetailViewController {
    
    @objc private func showEditHabitView() {
        let habitEditViewController: HabitEditViewController = {
            let viewController = HabitEditViewController()
            viewController.editMode = .edit
            viewController.editHabit = editHabit
            viewController.navigationItem.backButtonTitle = "Отмена"
            return viewController
        }()
        let editNavigationController: UINavigationController = {
            let editNavigationController = UINavigationController()
            editNavigationController.modalPresentationStyle = .fullScreen
            editNavigationController.setViewControllers([habitEditViewController], animated: true)
            return editNavigationController
        }()
        present(editNavigationController, animated: true)

    }
    
}
    
extension HabitDetailViewController {
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            habitDetailTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            habitDetailTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            habitDetailTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            habitDetailTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ])
    }

}
