import UIKit


class HabitsViewController: UIViewController {
    
    private let habitsCollectionView: HabitsCollectionView = {
        let habitsCollectionView = HabitsCollectionView()
        habitsCollectionView.toAutoLayout()
        return habitsCollectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Consts.ColorPalette.backgroundViewController
        
        self.title = Consts.TabPage.habitPageButtomTitle
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showCreateHabitView))
        
        self.view.addSubviews(habitsCollectionView)
        activateConstraints()
        
        navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let notificationCenter = NotificationCenter.default
        // подписываемся на уведомления необходимости обновить ячейку 
        notificationCenter.addObserver(self, selector: #selector(updateCollectionCell), name: NSNotification.Name(HobitsCollectionViewCell.needUpdateCellNotification), object: nil)
        // подписываемся на уведомления необходимости показать длелали привычки
        notificationCenter.addObserver(self, selector: #selector(showdDetailView), name: NSNotification.Name(HobitsCollectionViewCell.showdDetailViewNotification), object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsCollectionView.collectionView.reloadData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HabitsViewController {
    
    @objc private func showCreateHabitView() {
        let habitEditViewController: HabitEditViewController = {
            let viewController = HabitEditViewController()
            viewController.editMode = .create
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
    
    
    @objc private func updateCollectionCell(notification: NSNotification) {
        guard let viewCell = notification.userInfo?["HobitsCollectionViewCell"] as? HobitsCollectionViewCell else {
            return
        }
        
        if let indexPath = habitsCollectionView.collectionView.indexPath(for: viewCell) {
            habitsCollectionView.collectionView.reloadItems(at: [indexPath])
        }
        habitsCollectionView.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        
    }
    
    @objc private func showdDetailView(notification: NSNotification) {
        guard let habitFromCell = notification.userInfo?["habitFromCell"] as? Habit else {
            return
        }
        
        let habitDetailViewController: HabitDetailViewController = {
            let viewController = HabitDetailViewController()
            viewController.editHabit = habitFromCell
            viewController.navigationItem.backButtonTitle = "Отмена"
            return viewController
        }()

        navigationController?.pushViewController(habitDetailViewController, animated: true)

    }
}

extension HabitsViewController {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            habitsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            habitsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
