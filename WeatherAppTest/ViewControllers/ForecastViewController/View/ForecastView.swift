import Foundation
import UIKit

final class ForecastView: UIView {
    
    //MARK: - UI
    
    private let localityLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.titleColor
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 30, weight: .thin)
        lb.textAlignment = .center
        lb.text = "Load..."
        return lb
    }()
    
    private let myTableView = MyTableView()
    private let groupView = GroupView(view: [])
    
    //MARK: - Private Property
   
    private var count = 0
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyleView()
        appendViewsInStack()
        setupConstrints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public Method
    
    func getCountryName(_ name: String) {
        localityLabel.text = name
    }
    
    func getItemsLanguage(_ model: WeatherModel) {
        groupView.removeAllSubview()
        
        model.daily.forEach { modelDaily in
            let date = Date().addingTimeInterval(86400 * TimeInterval(count))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayInWeek = dateFormatter.string(from: date)
                        
            let containerView = UIView()
            containerView.tag = count
            containerView.backgroundColor = .clear
            
            let languageLabel = UILabel()
            languageLabel.textColor = .white
            languageLabel.font = .systemFont(ofSize: 14, weight: .light)
            languageLabel.textAlignment = .left
            languageLabel.text = dayInWeek
            languageLabel.lineBreakMode = .byTruncatingTail
            
            let maxLabel = UILabel()
            maxLabel.textColor = .white
            maxLabel.font = .systemFont(ofSize: 17, weight: .light)
            maxLabel.textAlignment = .left
            maxLabel.text = "\(modelDaily.temp.max) C"
            maxLabel.lineBreakMode = .byTruncatingTail
            
            let minLabel = UILabel()
            minLabel.textColor = .white.withAlphaComponent(0.6)
            minLabel.font = .systemFont(ofSize: 16, weight: .light)
            minLabel.textAlignment = .left
            minLabel.text = "\(modelDaily.temp.min) C"
            minLabel.lineBreakMode = .byTruncatingTail
            
            let lineView = UIView()
            lineView.backgroundColor = ColorHelper.titleColor.withAlphaComponent(0.5)
            lineView.isHidden = (model.daily.count - 1) == count
           
            groupView.addingArrangedSubview(
                containerView
            )
            
            containerView.snp.remakeConstraints { make in
                make.height.equalTo(50)
            }
            
            containerView.addSubview(languageLabel)
            containerView.addSubview(lineView)
            containerView.addSubview(maxLabel)
            containerView.addSubview(minLabel)
            
            languageLabel.snp.remakeConstraints { make in
                make.centerY.trailing.leading.equalToSuperview()
            }
            
            lineView.snp.remakeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(0.3)
            }
            
            minLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
            maxLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalTo(minLabel.snp.leading).inset(-10)
            }
            
            count += 1
        }
        
        count = 0
    }
    
    //MARK: - Private Method
    
    private func appendViewsInStack() {
        myTableView.getItems(items: [
            localityLabel,
            groupView
        ])
    }
    
    private func setupStyleView() {
        backgroundColor = .clear
        groupView.newCornerRadius(15)
        myTableView.setupSpacing(15)
        myTableView.setupContentInset(.init(top: 12.5, left: 0, bottom: 150, right: 0))
    }
    
    private func setupConstrints() {
        addSubview(myTableView)
        
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
