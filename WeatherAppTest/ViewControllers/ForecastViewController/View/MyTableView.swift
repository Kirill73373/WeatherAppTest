import Foundation
import UIKit

final class MyTableView: UIView {
    
    //MARK: - UI
    
    private let scrollView: UIScrollView = {
        let vw = UIScrollView()
        vw.backgroundColor = .clear
        vw.showsVerticalScrollIndicator = false
        vw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return vw
    }()
        
    let stackView = UIStackView()
    
    //MARK: - Life Cycle
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    //MARK: - Public Method
    
    func getItems(items: [UIView]) {
        stackView.addingArrangedSubviews(items)
    }
    
    func setupContentInset(_ contentInset: UIEdgeInsets) {
        scrollView.contentInset = contentInset
    }
    
    func setupSpacing(_ spacing: CGFloat) {
        stackView.spacing = spacing
    }
    
    //MARK: - Private Method
    
    private func styleView() {
        stackView.axis = .vertical
        backgroundColor = .clear
        stackView.spacing = 17
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
       
        scrollView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.remakeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 32)
        }
    }
}
