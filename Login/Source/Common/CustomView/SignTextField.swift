//
//  SignTextField.swift
//  Login
//
//  Created by 0-jerry on 5/13/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SignTextField: UIView {
    
    struct Configuration {
        let textFieldFont: UIFont?
        let textColor: UIColor?
        let borderColor: UIColor?
        let backgroundColor: UIColor?
        let placeHolder: String?
        let isSecureTextEntry: Bool
        
        init(textFieldFont: UIFont? = nil,
             textColor: UIColor? = nil,
             borderColor: UIColor? = nil,
             backgroundColor: UIColor? = nil,
             placeHolder: String? = nil,
             isSecureTextEntry: Bool = false) {
            self.textFieldFont = textFieldFont
            self.textColor = textColor
            self.borderColor = borderColor
            self.backgroundColor = backgroundColor
            self.placeHolder = placeHolder
            self.isSecureTextEntry = isSecureTextEntry
        }
        
    }
    
    private let configuration: Configuration?
    private let disposeBag = DisposeBag()
    
    let invalid = PublishRelay<Void>()
    let startEditing = PublishRelay<Void>()
    var endEditing: Driver<Void> {
        textField.rx.controlEvent(.editingDidEnd).asDriver() }
    var text: ControlProperty<String?> { textField.rx.text }
    var error = PublishRelay<SignUpError>()
    weak var nextTextField: SignTextField?
    
    private let textFieldBorder: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = .System.medium20
        textField.textColor = .black
        return textField
    }()
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .systemGray
        button.setImage(UIImage(systemName: "xmark.circle.fill"),
                        for: .normal)
        button.isHidden = true
        
        return button
    }()
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        
        label.font = .System.regular12
        label.textColor = .systemRed
        label.textAlignment = .right
        label.isHidden = true
        
        return label
    }()
    
    init(_ configuration: Configuration? = nil) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        configure()
        setupUI()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let configuration = configuration else { return }
        textField.placeholder = configuration.placeHolder
        textField.isSecureTextEntry = configuration.isSecureTextEntry
        
        if let font = configuration.textFieldFont {
            textField.font = font
        }
        if let tintColor = configuration.textColor {
            textField.textColor = tintColor
            textFieldBorder.layer.borderColor = tintColor.cgColor
        }
        if let borderColor = configuration.borderColor {
            textFieldBorder.layer.borderColor = borderColor.cgColor
        }
        if let backgroundColor = configuration.backgroundColor {
            textField.backgroundColor = backgroundColor
        }
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        addSubViews(
            textFieldBorder,
            textField,
            clearButton,
            errorMessageLabel
        )
        
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldBorder.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            textFieldBorder.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            textFieldBorder.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            textFieldBorder.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldBorder.topAnchor, constant: 4),
            textField.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: -4),
            textField.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: 4)
        ])
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: textFieldBorder.trailingAnchor, constant: -8),
            clearButton.widthAnchor.constraint(equalToConstant: 24),
            clearButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: 4),
            errorMessageLabel.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: textFieldBorder.trailingAnchor),
            errorMessageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func bind() {
        textField.rx.controlEvent(.editingDidBegin)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.clearButton.isHidden = false
                owner.clearState()
            }).disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.clearButton.isHidden = true
            }).disposed(by: disposeBag)
        
        clearButton.rx.tap
            .throttle(.milliseconds(300),
                      scheduler: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.textField.text = nil
            }).disposed(by: disposeBag)
        
        invalid
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.invalidInput()
            }).disposed(by: disposeBag)
        
        startEditing
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.textField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                guard let nextTextField = owner.nextTextField else { return }
                nextTextField.startEditing.accept(())
            }).disposed(by: disposeBag)
        
        error
            .map { $0.errorMessage }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, errorMessage in
                owner.errorMessageLabel.text = errorMessage
                owner.errorMessageLabel.isHidden = false
            }).disposed(by: disposeBag)
    }
    
    private func clearState() {
        let borderColor = configuration?.borderColor ?? .black
        self.textFieldBorder.layer.borderColor = borderColor.cgColor
        self.errorMessageLabel.isHidden = true
    }
    
    private func invalidInput() {
        self.textFieldBorder.layer.borderColor = UIColor.systemRed.cgColor
        self.errorMessageLabel.isHidden = false
    }
    
}
