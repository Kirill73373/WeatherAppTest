import Foundation
import UIKit

final class SearchView: UIView {
    
    //MARK: - Type Flow
    
    enum Flow {
        case textFieldDidChangeSelection(String)
    }
    
    //MARK: - UI
    
    private let fieldView: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.tintColor = .white
        tf.font = .systemFont(ofSize: 15, weight: .thin)
        tf.autocorrectionType = .no
        return tf
    }()
    
    //MARK: - Publick Property
    
    var flow: ((Flow) -> Void)?
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Method
    
    private func setupStyle() {
        fieldView.attributedPlaceholder = NSAttributedString(
            string: "Search city...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        fieldView.delegate = self
        backgroundColor = ColorHelper.tabBarBackgroundColor.withAlphaComponent(0.5)
        layer.cornerRadius = 8
    }
    
    private func setupConstraints() {
        addSubview(fieldView)
        
        fieldView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
    }
}

//MARK: - Text Field Delegate

extension SearchView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        flow?(.textFieldDidChangeSelection(text))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
