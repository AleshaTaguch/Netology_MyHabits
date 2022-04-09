import UIKit

class HabitsCollectionView: UIView {
    

    private lazy var layuot: UICollectionViewFlowLayout = {
        let layuot = UICollectionViewFlowLayout()
        layuot.minimumLineSpacing = Consts.HobitsCollection.lineSpacing
        layuot.scrollDirection = .vertical
        return layuot
    }()
    
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        collectionView.register(HobitsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsCollectionViewCell.self))
    
        collectionView.register(HobitsProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HobitsProgressCollectionViewCell.self))
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
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
            print("store.todayProgress= \(store.todayProgress)")
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
        let width: CGFloat = collectionView.frame.width-32
        
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
                                               left: Consts.HobitsCollection.leftMargin,
                                               bottom: 9,
                                               right: Consts.HobitsCollection.rightMargin)

        } else {
            return UIEdgeInsets(top: 9,
                                               left: Consts.HobitsCollection.leftMargin,
                                               bottom: 12,
                                               right: Consts.HobitsCollection.rightMargin)
        }
        
    }
     
     
}

extension HabitsCollectionView {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor,constant: 16*0),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16*0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16*0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16*0)
        ])
    }
}
