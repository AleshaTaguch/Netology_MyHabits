import UIKit

class HabitDetailTableView: UIView {

    public var editHabit: Habit?
    
    //let habitDatesArray: [Date] = store.dates.sorted{ $0 > $1 }
    let habitDatesArray: [Date] = HabitsStore.shared.dates.sorted{ $0 > $1 }
        
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.toAutoLayout()
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = Consts.Global.borderWidth
        self.layer.borderColor = Consts.Global.borderColor
        
        self.backgroundColor = Consts.ColorPalette.backgroundView
        self.addSubviews(tableView)

        activateConstraints()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HabitDetailTableViewCell.self, forCellReuseIdentifier: HabitDetailTableViewCell.classIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension HabitDetailTableView: UITableViewDataSource ,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitDatesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailTableViewCell.classIdentifier, for: indexPath) as! HabitDetailTableViewCell
        
        if let habit = editHabit {
            cell.setCellFromDataSet(habit: habit,date: habitDatesArray[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
      
}

extension HabitDetailTableView {
    
    private func activateConstraints () {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
