import Foundation
import UIKit

final class GroupView: UIView {
    
    //MARK: - UI

    private let containerStackView: UIStackView = {
        let stc = UIStackView()
        stc.axis = .vertical
        stc.alignment = .fill
        stc.distribution = .fillEqually
        stc.backgroundColor = .clear
        return stc
    }()
    
    //MARK: - Public Property
    
    var views: [UIView] {
        return containerStackView.arrangedSubviews
    }
    
    //MARK: - Life Cycle

    init(view: [UIView]) {
        containerStackView.addingArrangedSubviews(view)
        super.init(frame: .zero)
        styleView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Method
    
    func removeAllSubview() {
        containerStackView.removeAllArrangedSubviews()
    }
    
    func addingArrangedSubview(_ views: UIView) {
        containerStackView.addingArrangedSubview(views)
    }
    
    func newCornerRadius(_ corner: CGFloat) {
        layer.cornerRadius = corner
    }
    
    //MARK: - Private Method
    
    private func styleView() {
        backgroundColor = .clear
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
