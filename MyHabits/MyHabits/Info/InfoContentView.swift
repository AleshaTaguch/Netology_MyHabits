import UIKit

class InfoContentView: UIView {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = Consts.FontPalette.Title3.font
        titleLabel.textColor = Consts.FontPalette.Title3.color
        titleLabel.numberOfLines = 1
        titleLabel.text = Consts.InfoContentView.Caption.title
        titleLabel.toAutoLayout()
        return titleLabel
    }()

    
    let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.font = Consts.FontPalette.Body.font
        infoLabel.textColor = Consts.FontPalette.Body.color
        infoLabel.numberOfLines = 0
        infoLabel.text = Consts.Global.intoText
        infoLabel.toAutoLayout()
        return infoLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Consts.ColorPalette.backgroundView
        
        self.addSubviews(titleLabel,infoLabel)
        activateConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InfoContentView {
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Consts.InfoContentView.Margin.topTitle),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.InfoContentView.Margin.leading),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Consts.InfoContentView.Margin.trailing),
            titleLabel.heightAnchor.constraint(equalToConstant: Consts.InfoContentView.SizeItem.title),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Consts.InfoContentView.Margin.topInfo),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Consts.InfoContentView.Margin.leading),
            infoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Consts.InfoContentView.Margin.trailing),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Consts.InfoContentView.Margin.bottom)
        ])
    }
}
