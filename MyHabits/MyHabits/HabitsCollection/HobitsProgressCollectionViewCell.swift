import UIKit

final class HobitsProgressCollectionViewCell: UICollectionViewCell {
    
    private var todayProgress: CGFloat = 0.00 {
        didSet {
            self.progressLabel.text = "\(String(Int(floor(self.todayProgress * 100))))%"
            progressViewConstraint.isActive = false
            progressViewConstraint = progressView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
                                                                         multiplier: self.todayProgress,
                                                                         constant: -24)
            progressViewConstraint.isActive = true
        }
        
    }
    
    private var progressViewConstraint: NSLayoutConstraint =  NSLayoutConstraint()
    
    private let happyLabel: UILabel = {
        let happyLabel = UILabel()
        happyLabel.backgroundColor = .white
        happyLabel.text = "Все получится!"
        happyLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        happyLabel.textColor = .systemGray
        happyLabel.toAutoLayout()
        return happyLabel
    }()

    private let progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.backgroundColor = .white
        progressLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        progressLabel.textColor = .systemGray
        progressLabel.toAutoLayout()
        return progressLabel
    }()

    private let backgroudView: UIView = {
        let backgroudView = UIView()
        backgroudView.backgroundColor = .systemGray5
        backgroudView.layer.cornerRadius = 5
        backgroudView.layer.masksToBounds = true
        backgroudView.toAutoLayout()
        return backgroudView
    }()
    
    private let progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = .purple
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.toAutoLayout()
        return progressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubviews(happyLabel,
                                progressLabel,
                                backgroudView,
                                progressView)
        activateConstraints()
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HobitsProgressCollectionViewCell {
    
    public func setCellFromDataSet(_ progress: Float) {
        self.todayProgress = CGFloat(floor(progress*100)/100)
        print("HobitsProgressCollectionViewCell todayProgress= ", self.todayProgress)
    }

}


extension HobitsProgressCollectionViewCell {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            happyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            happyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            
            progressLabel.centerYAnchor.constraint(equalTo: happyLabel.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),
                    
            backgroudView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: 10),
            backgroudView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            backgroudView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,constant: -24),
            backgroudView.heightAnchor.constraint(equalToConstant: 7),

            progressView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: 10),
            progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
    }
}
