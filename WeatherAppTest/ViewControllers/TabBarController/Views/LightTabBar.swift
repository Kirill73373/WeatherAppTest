import UIKit

final class LightTabBar: BaseCardTabBar {
    
    private let containerStackView: UIStackView = {
        let stc = UIStackView()
        stc.spacing = 0
        stc.axis = .horizontal
        stc.alignment = .fill
        stc.distribution = .equalSpacing
        stc.backgroundColor = .clear
        return stc
    }()
    
    private let containerAllView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.tabBarBackgroundColor
        vw.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        vw.layer.cornerRadius = 15
        return vw
    }()
    
    private var buttons: [IconOnlyButton] = []
    private var selectedIndex: Int = 0
    
    override var preferredBottomBackground: UIColor {
        return .clear
    }
    
    override var preferredTabBarHeight: CGFloat {
        return 98
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addConstraints()
    }
    
    private func updateStyle() {
        backgroundColor = .clear
    }

    private func addConstraints() {
        addSubview(containerAllView)
        addSubview(containerStackView)
        
        containerAllView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(74)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(44)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(74)
        }
        
        updateStyle()
    }

    override func select(at index: Int, animated: Bool, notifyDelegate: Bool) {
        guard !buttons.isEmpty else { return }
        
        selectedIndex = index
        let selectedButton = buttons[index]

        let block = {
            self.buttons.forEach { $0._isSelected = false }
            selectedButton._isSelected = true
        }
        
        if animated {
            if index != 1 { block() }
        } else {
            block()
        }

        if notifyDelegate {
            delegate?.cardTabBar(self, didSelectItemAt: index)
        }
    }
    
    override func set(items: [UITabBarItem]) {
        buttons = []
        
        containerStackView.arrangedSubviews.forEach {
            containerStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        let buttons: [IconOnlyButton] = items.enumerated().map {
            let button = IconOnlyButton(
                title: $0.element.title,
                image: $0.element.image,
                selectedImage: $0.element.selectedImage
            )
            button.tag = $0.offset
            return button
        }
        
        buttons.forEach { view in
            view.actionView { [weak self] in
                guard let self = self else { return }
                self.select(at: view.tag, animated: true, notifyDelegate: true)
            }
        }
        
        self.buttons = buttons
        containerStackView.addingArrangedSubviews(buttons)
    }
}
