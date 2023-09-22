import Foundation
import UIKit

final class IconOnlyButton: UIView {
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 12, weight: .thin)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let title: String?
    private let image: UIImage?
    private let selectedImage: UIImage?
    
    var _isSelected: Bool = false {
        didSet {
            updateStyle()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return tag != 1 ? .init(width: 39, height: 39) : .init(width: 64, height: 64)
    }
    
    init(title: String?, image: UIImage?, selectedImage: UIImage?) {
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        super.init(frame: .zero)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateStyle(){
        titleLabel.textColor = _isSelected ? .white : .systemGray
        if tag != 1 {
            iconImageView.image = _isSelected
            ? image?.imageWith(newSize: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white)
            : image?.imageWith(newSize: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysOriginal).withTintColor(UIColor.systemGray)
        } else {
            iconImageView.image = _isSelected
                ? selectedImage?.imageWith(newSize: CGSize(width: 64, height: 64))
                : image?.imageWith(newSize: CGSize(width: 64, height: 64))
        }
       
        titleLabel.text = title ?? ""
    }
    
    private func addConstraints() {
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).inset(tag != 1 ? 0 : -5)
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.bottom.centerX.equalToSuperview()
        }
    }
}
