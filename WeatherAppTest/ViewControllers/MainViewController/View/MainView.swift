import Foundation
import UIKit

final class MainView: UIView {
    
    //MARK: - Type Flow
    
    enum Flow {
        case textFieldDidChangeSelection(String)
    }
    
    //MARK: - UI
    
    private let searchView = SearchView()
    
    private let localityLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.titleColor
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 30, weight: .thin)
        lb.textAlignment = .center
        lb.text = "Load..."
        return lb
    }()
    
    private let temperatureLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.titleColor
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 22, weight: .ultraLight)
        lb.textAlignment = .center
        lb.text = "Load..."
        return lb
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "sunnyIcon")
        return img
    }()
    
    private let adviceLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.titleColor
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 15, weight: .thin)
        lb.textAlignment = .center
        lb.text = "Load..."
        return lb
    }()
        
    //MARK: - Publick Property
    
    var flow: ((Flow) -> Void)?
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
        setupStyle()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Method
    
    func getInformation(locality: String, temperature: String, temperatureC: CGFloat? = nil) {
        localityLabel.text = locality
        temperatureLabel.text = "\(temperature) C"
        setupAdviceText(for: temperatureC)
    }
    
    //MARK: - Private Method
    
    private func bindUI() {
        searchView.flow = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .textFieldDidChangeSelection(let text):
                self.flow?(.textFieldDidChangeSelection(text))
            }
        }
    }
    
    private func setupAdviceText(for temperatureC: CGFloat?) {
        if let temperatureC {
            switch temperatureC {
            case _ where temperatureC < 0:
                adviceLabel.text = "Dress warmly"
                iconImageView.image = UIImage(named: "snowIcon")
            case _ where temperatureC > 0 && temperatureC <= 15:
                adviceLabel.text = "Bring a light jacket"
                iconImageView.image = UIImage(named: "cloudyIcon")
            case _ where temperatureC > 15:
                adviceLabel.text = "The weather is just right for walking"
                iconImageView.image = UIImage(named: "sunnyIcon")
            default:
                break
            }
        } else {
            iconImageView.image = UIImage(named: "sleetIcon")
        }
    }
    
    private func setupStyle() {
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        addSubview(searchView)
        addSubview(localityLabel)
        addSubview(temperatureLabel)
        addSubview(iconImageView)
        addSubview(adviceLabel)
        
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10.vertical)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(36)
        }
        
        localityLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(searchView.snp.bottom).inset(-26.vertical)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(localityLabel.snp.bottom).inset(-16.vertical)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).inset(-26.vertical)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        adviceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(iconImageView.snp.bottom).inset(-26.vertical)
        }
    }
}
