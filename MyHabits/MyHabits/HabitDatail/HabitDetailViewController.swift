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
        
        self.view.backgroundColor = .systemGray6
        self.view.addSubviews(habitDetailTableView)
        activateConstraints()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(showEditHabitView))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let habit = editHabit {
            self.title = habit.name
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true

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
        navigationController?.pushViewController(habitEditViewController, animated: true)
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
