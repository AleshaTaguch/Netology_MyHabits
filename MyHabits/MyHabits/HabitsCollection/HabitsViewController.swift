import UIKit


class HabitsViewController: UIViewController {
    
    let habitsCollectionView: HabitsCollectionView = {
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

        
        //let store = HabitsStore.shared
        //let h1 = Habit(name: "первая привычка", date: Date.init() , color: .blue)
        print("-v-- store.habits -----")
        print(store.habits) // распечатает список добавленных привычек
        //store.habits.append(h1)
        print("-^--- store.habits -----")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }

}

extension HabitsViewController {
    
    @objc func createNewHabit() {
        let habitEditViewController: HabitEditViewController = {
            let viewController = HabitEditViewController()
            viewController.title = "Создать"
            viewController.navigationItem.backButtonTitle = "Отмена"
            return viewController
        }()
        navigationController?.pushViewController(habitEditViewController, animated: true)
        
        
        
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
/*
class HabitsViewController: UIViewController {
    
    lazy var layuot: UICollectionViewFlowLayout = {
        let layuot = UICollectionViewFlowLayout()
        layuot.sectionInset = UIEdgeInsets(top: Consts.HobitsCollection.topMargin*0,
                                           left: Consts.HobitsCollection.leftMargin*0,
                                           bottom: Consts.HobitsCollection.buttomMargin*0,
                                           right: Consts.HobitsCollection.rightMargin*0)
        layuot.minimumLineSpacing = Consts.HobitsCollection.lineSpacing
        layuot.minimumInteritemSpacing = Consts.HobitsCollection.interitemSpacing*0
        layuot.scrollDirection = .vertical
        return layuot
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.register(HobitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsCollectionViewCell.self))
    
        collectionView.register(HobitsProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsProgressCollectionViewCell.self))
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.title = Consts.TabPage.habitPageButtomTitle
        //self.navigationItem.title = Consts.TabPage.habitPageButtomTitle
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createNewHabit))
        self.view.addSubviews(collectionView)
        activateConstraints()
        
        navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true

        
        //let store = HabitsStore.shared
        //let h1 = Habit(name: "первая привычка", date: Date.init() , color: .blue)
        print("-v-- store.habits -----")
        print(store.habits) // распечатает список добавленных привычек
        //store.habits.append(h1)
        print("-^--- store.habits -----")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }

}

extension HabitsViewController {
    
    @objc func createNewHabit() {
        let habitEditViewController: HabitEditViewController = {
            let viewController = HabitEditViewController()
            viewController.title = "Создать"
            viewController.navigationItem.backButtonTitle = "Отмена"
            return viewController
        }()
        navigationController?.pushViewController(habitEditViewController, animated: true)
        
        
        
    }
    
}


extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.habits.count+1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HobitsProgressCollectionViewCell.self),
                                                                for: indexPath) as? HobitsProgressCollectionViewCell else {
                return UICollectionViewCell()
            }
            //cell.setCellFromDataSet(store.habits[indexPath.row].name,
                                   // bk: store.habits[indexPath.row].color)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HobitsCollectionViewCell.self),
                                                                for: indexPath) as? HobitsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setCellFromDataSet(store.habits[indexPath.row - 1].name,
                                    bk: store.habits[indexPath.row - 1].color)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat
        let width: CGFloat = collectionView.frame.width
        
        if indexPath.row == 0 {
            height = 60

        } else {
            height = 130
        }
        
        return CGSize(width: width, height: height)
    }
     
}

extension HabitsViewController {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -16)
        ])
    }
}
*/
