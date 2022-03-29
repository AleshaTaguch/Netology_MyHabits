//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by tertyshniy on 29.03.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.title = Consts.TabPage.habitPageButtomTitle
        
        navigationController?.tabBarItem.title = Consts.TabPage.habitPageName
        navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabitToList))

    }


}

extension HabitsViewController {
    
    @objc func addHabitToList() {
        return
    }
    
}
