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
        happyLabel.text = Consts.HobitsProgressCollectionViewCell.Caption.title
        happyLabel.font = Consts.FontPalette.FootnoteStatus.font
        happyLabel.textColor = Consts.FontPalette.FootnoteStatus.color
        happyLabel.toAutoLayout()
        return happyLabel
    }()

    private let progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.font = Consts.FontPalette.FootnoteStatus.font
        progressLabel.textColor = Consts.FontPalette.FootnoteStatus.color
        progressLabel.toAutoLayout()
        return progressLabel
    }()

    private let backgroudView: UIView = {
        let backgroudView = UIView()
        backgroudView.backgroundColor = Consts.ColorPalette.PregressBar.background
        backgroudView.layer.cornerRadius = 5
        backgroudView.layer.masksToBounds = true
        backgroudView.toAutoLayout()
        return backgroudView
    }()
    
    private let progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = Consts.ColorPalette.PregressBar.progress
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.toAutoLayout()
        return progressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Consts.ColorPalette.backgroundView
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
            happyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.top),
            happyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.leading),
            
            progressLabel.centerYAnchor.constraint(equalTo: happyLabel.centerYAnchor),
            progressLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.trailing),
                    
            backgroudView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.topBar),
            backgroudView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.leading),
            backgroudView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,
                                                 constant: Consts.HobitsProgressCollectionViewCell.Margin.trailing -
                                                           Consts.HobitsProgressCollectionViewCell.Margin.leading
                                                ),
            backgroudView.heightAnchor.constraint(equalToConstant: Consts.HobitsProgressCollectionViewCell.SizeItem.progressBar),

            progressView.topAnchor.constraint(equalTo: happyLabel.bottomAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.topBar),
            progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: Consts.HobitsProgressCollectionViewCell.Margin.leading),
            progressView.heightAnchor.constraint(equalToConstant: Consts.HobitsProgressCollectionViewCell.SizeItem.progressBar)
        ])
    }
}
