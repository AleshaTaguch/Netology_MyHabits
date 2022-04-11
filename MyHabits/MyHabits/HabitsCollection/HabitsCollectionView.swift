import UIKit

class HabitsCollectionView: UIView {
    

    private lazy var layuot: UICollectionViewFlowLayout = {
        let layuot = UICollectionViewFlowLayout()
        layuot.minimumLineSpacing = Consts.HabitsCollectionView.Margin.lineSpacing
        layuot.scrollDirection = .vertical
        return layuot
    }()
    
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Consts.ColorPalette.backgroundViewController
        collectionView.register(HobitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsCollectionViewCell.self))
    
        collectionView.register(HobitsProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsProgressCollectionViewCell.self))
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Consts.ColorPalette.backgroundViewController
        self.layer.borderWidth = Consts.Global.borderWidth
        self.layer.borderColor = Consts.Global.borderColor
        
        self.addSubviews(collectionView)
        activateConstraints()
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HabitsCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return store.habits.count
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HobitsProgressCollectionViewCell.self),
                                                                for: indexPath) as? HobitsProgressCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setCellFromDataSet(store.todayProgress)
            print("HabitsCollectionView todayProgress= \(store.todayProgress)")
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HobitsCollectionViewCell.self),
                                                                for: indexPath) as? HobitsCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setCellFromDataSet(store.habits[indexPath.row])
            return cell
        }
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat
        let width: CGFloat = collectionView.frame.width - (Consts.HabitsCollectionView.Margin.left +
                                                           Consts.HabitsCollectionView.Margin.right)
        
        if indexPath.section == 0 {
            height = 60

        } else {
            height = 130
        }
        
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22,
                                left: Consts.HabitsCollectionView.Margin.left,
                                               bottom: 9,
                                               right: Consts.HabitsCollectionView.Margin.right)

        } else {
            return UIEdgeInsets(top: 9,
                                left: Consts.HabitsCollectionView.Margin.left,
                                               bottom: 12,
                                               right: Consts.HabitsCollectionView.Margin.right)
        }
        
    }
     
     
}

extension HabitsCollectionView {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
