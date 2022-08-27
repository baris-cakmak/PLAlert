//
//  CustomPopUpViewController.swift
//  DadJokeTeller
//
//  Created by Peace on 16.08.2022.
//

import UIKit

open class PLAlertController: UIViewController, CustomPopUpTransitionable {
    // MARK: - Properties
    var transitionController: PopUpTransitionController?
    private(set) var shadowLayer = CAShapeLayer()
    
    public var shadowColor: UIColor = .darkText {
        didSet {
            shadowLayer.shadowColor = shadowColor.cgColor
        }
    }
    public var shadowDirection: ShadowDirection = .bottom(percentage: 0.5) {
        didSet {
            shadowDirection.addShadow(coreLayer: &shadowLayer)
        }
    }
    public var buttonBackgroundColor: UIColor = .purple {
        didSet {
            popUpButton.backgroundColor = buttonBackgroundColor
        }
    }
    public var titleBackgroundColor: UIColor = .magenta {
        didSet {
            popUpTitle.backgroundColor = titleBackgroundColor
        }
    }
    public var messageBackgroundColor: UIColor = .white {
        didSet {
            popUpText.backgroundColor = messageBackgroundColor
        }
    }
    public var borderWidth: CGFloat = CustomPopUpViewControllerConstant.borderWidth {
        didSet {
            containerView.layer.borderWidth = borderWidth
        }
    }
    public var containerCornerRadius: CGFloat = CustomPopUpViewControllerConstant.containerCornerRadius {
        didSet {
            updateCornerRadius()
        }
    }
    public var popTitleHeightRatio: CGFloat = 1 / 5 {
        didSet {
            precondition(popTitleHeightRatio < 0.3 && popTitleHeightRatio > 0.1, "pop title height can be weird")
            titleHeightConstraint.isActive = false
            titleHeightConstraint = popUpTitle.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: popTitleHeightRatio)
            titleHeightConstraint.isActive = true
        }
    }
    public var buttonHeightRatio: CGFloat = 1 / 5 {
        didSet {
            precondition(buttonHeightRatio < 0.3 && buttonHeightRatio > 0.1, "ugly button error condition check")
            buttonHeightConstraint.isActive = false
            buttonHeightConstraint = popUpButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: buttonHeightRatio)
            buttonHeightConstraint.isActive = true
        }
    }
    public var containerWidthRatio: CGFloat = 0.7 {
        didSet {
            precondition(containerWidthRatio > 0.4, "Delete me if you know what you are doing")
            containerWidthHeightConstraint.isActive = false
            containerWidthHeightConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: containerWidthRatio)
            containerWidthHeightConstraint.isActive = true
        }
    }
    // MARK: - UI Properties
    private(set) var containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = false
        view.backgroundColor = .black
        view.layer.borderWidth = CustomPopUpViewControllerConstant.borderWidth
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var popUpTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .magenta
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 1
        label.layer.cornerRadius = containerCornerRadius - borderWidth
        if #available(iOS 11.0, *) {
            label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
        label.textAlignment = .center
        return label
    }()
    private let popUpText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.masksToBounds = false
        label.textColor = .black
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    private lazy var popUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        button.backgroundColor = .purple
        button.layer.cornerRadius = containerCornerRadius - borderWidth
        if #available(iOS 11.0, *) {
            button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        button.addTarget(self, action: #selector(didPopUpButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - GestureRecognizer
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        return gesture
    }()
    // MARK: - Constraints
    private var titleHeightConstraint: NSLayoutConstraint!
    private var buttonHeightConstraint: NSLayoutConstraint!
    private var messageLeadingConstraint: NSLayoutConstraint!
    private var messageTrailingConstraint: NSLayoutConstraint!
    private var containerWidthHeightConstraint: NSLayoutConstraint!
    // MARK: - Init
    public required init(
        title: String,
        text: String,
        buttonText: String,
        animationConfiguration: AnimationConfiguration? = .init(
            animationStartPosition: .bottomLeft,
            animationEndPosition: .bottomRight,
            animationPresentDuration: 1,
            animationDismissalDuration: 1
        )
    ) {
        super.init(nibName: nil, bundle: nil)
        popUpButton.setTitle(buttonText, for: .normal)
        popUpTitle.text = title
        popUpText.text = text
        modalPresentationStyle = .custom
        view.addGestureRecognizer(tapGesture)
        if let animationConfiguration = animationConfiguration {
            setTransitionController(animationConfiguration: animationConfiguration)
        }
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
     public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addShadowLayerToContainerView()
    }
}
// MARK: - Setup UI
extension PLAlertController {
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(popUpText)
        containerView.addSubview(popUpTitle)
        containerView.addSubview(popUpButton)
    }
}
// MARK: - Setup Layout
extension PLAlertController {
    private func setupLayout() {
        titleHeightConstraint = popUpTitle.heightAnchor.constraint(
            equalTo: containerView.heightAnchor,
            multiplier: CustomPopUpViewControllerConstant.titleHeightRatioRespectToContainer
        )
        buttonHeightConstraint = popUpButton.heightAnchor.constraint(
            equalTo: containerView.heightAnchor,
            multiplier: CustomPopUpViewControllerConstant.buttonHeightRatioRespectToContainer
        )
        messageLeadingConstraint = popUpText.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor,
            constant: borderWidth
        )
        messageTrailingConstraint = popUpText.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor,
            constant: -borderWidth
        )
        containerWidthHeightConstraint = containerView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: CustomPopUpViewControllerConstant.containerWidthRatioRespcectToSuperView
        )
        NSLayoutConstraint.activate([
            // container view
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerWidthHeightConstraint,
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            // title
            popUpTitle.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: CustomPopUpViewControllerConstant.borderWidth
            ),
            popUpTitle.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -CustomPopUpViewControllerConstant.borderWidth
            ),
            popUpTitle.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: CustomPopUpViewControllerConstant.borderWidth
            ),
            titleHeightConstraint,
            // message
            popUpText.topAnchor.constraint(
                equalTo: popUpTitle.bottomAnchor
            ),
            popUpText.bottomAnchor.constraint(
                equalTo: popUpButton.topAnchor
            ),
            messageLeadingConstraint,
            messageTrailingConstraint,
            // button
            buttonHeightConstraint,
            popUpButton.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: CustomPopUpViewControllerConstant.borderWidth
            ),
            popUpButton.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -CustomPopUpViewControllerConstant.borderWidth
            ),
            popUpButton.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -CustomPopUpViewControllerConstant.borderWidth
            )
        ])
    }
}
// MARK: - Helper
extension PLAlertController {
    private func addShadowLayerToContainerView() {
        containerView.layer.cornerRadius = containerCornerRadius
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.path = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: containerView.layer.cornerRadius
        ).cgPath
        shadowLayer.fillColor = containerView.backgroundColor?.cgColor
        shadowLayer.shadowOpacity = CustomPopUpViewControllerConstant.containerShadowOpacity
        shadowLayer.shadowRadius = CustomPopUpViewControllerConstant.containerShadowRadius
        shadowDirection.addShadow(coreLayer: &shadowLayer)
        containerView.layer.insertSublayer(shadowLayer, at: .zero)
    }
    private func updateCornerRadius() {
        containerView.layer.cornerRadius = containerCornerRadius
        popUpTitle.layer.cornerRadius = containerCornerRadius - borderWidth
        popUpButton.layer.cornerRadius = containerCornerRadius - borderWidth
        NSLayoutConstraint.deactivate([
            messageLeadingConstraint,
            messageTrailingConstraint
        ])
        messageLeadingConstraint = popUpText.leadingAnchor.constraint(
            equalTo: containerView.leadingAnchor,
            constant: borderWidth
        )
        messageTrailingConstraint = popUpText.trailingAnchor.constraint(
            equalTo: containerView.trailingAnchor,
            constant: -borderWidth
        )
        NSLayoutConstraint.activate([
            messageLeadingConstraint,
            messageTrailingConstraint
        ])
        addShadowLayerToContainerView()
    }
}
// MARK: - Action
extension PLAlertController {
    @objc func didPopUpButtonTapped() {
        dismiss(animated: true)
    }
    @objc func handleTapGesture(tapGesture: UITapGestureRecognizer) {
        let location = tapGesture.location(in: view)
        containerView.frame.contains(location) ? () : dismiss(animated: true)
    }
}
// MARK: - Constant
extension PLAlertController {
    private enum CustomPopUpViewControllerConstant {
        static let borderWidth: CGFloat = 2
        static let popUpTitleHeight: CGFloat = 60
        static let popUpbuttonHeight: CGFloat = 60
        static let popUpTextTopAndButton: CGFloat = 8
        static let popUpTextLeadingTrailing: CGFloat = 15
        // container
        static let containerWidthRatioRespcectToSuperView: CGFloat = 0.7
        static let containerCornerRadius: CGFloat = 20
        static let containerShadowOpacity: Float = 1
        static let containerShadowRadius: CGFloat = 10
        static let containerShadowOffset: CGSize = .init(width: 4, height: 20)
        // button
        static let buttonCornerRadius: CGFloat = containerCornerRadius - borderWidth
        static let buttonHeightRatioRespectToContainer: CGFloat = 1 / 5
        // title
        static let titleCornerRadius: CGFloat = buttonCornerRadius
        static let titleHeightRatioRespectToContainer: CGFloat = 1 / 5
    }
}
