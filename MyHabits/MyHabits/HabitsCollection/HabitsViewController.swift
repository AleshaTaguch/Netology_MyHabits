import UIKit


class HabitsViewController: UIViewController {
    
    private let habitsCollectionView: HabitsCollectionView = {
        let habitsCollectionView = HabitsCollectionView()
        habitsCollectionView.toAutoLayout()
        return habitsCollectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.title = Consts.TabPage.habitPageButtomTitle
        //self.navigationItem.title = Consts.TabPage.habitPageButtomTitle
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewHabit))
        
        self.view.addSubviews(habitsCollectionView)
        activateConstraints()
        
        navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let notificationCenter = NotificationCenter.default
        // подписываемся на уведомления необходимости обновить ячейку 
        notificationCenter.addObserver(self, selector: #selector(updateCollectionCell), name: NSNotification.Name(HobitsCollectionViewCell.needUpdateCellNotification), object: nil)

        
        //let store = HabitsStore.shared
        //let h1 = Habit(name: "первая привычка", date: Date.init() , color: .blue)
        print("-v-- store.habits -----")
        store.habits.forEach{hb in print(hb.name,hb.trackDates)}
        
        // {habit in print(habit)}
        print(store.habits) // распечатает список добавленных привычек
        //store.habits.append(h1)
        print("-^--- store.habits -----")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        habitsCollectionView.collectionView.reloadData()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }

}

extension HabitsViewController {
    
    @objc private func createNewHabit() {
        let habitEditViewController: HabitEditViewController = {
            let viewController = HabitEditViewController()
            viewController.editMode = .create
            //viewController.title = "Создать"
            viewController.navigationItem.backButtonTitle = "Отмена"
            return viewController
        }()
        navigationController?.pushViewController(habitEditViewController, animated: true)
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
