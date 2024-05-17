//
//  BookTimeCell.swift
//  BeautyScan
//
//  Created by Admin on 4/14/24.
//

import UIKit

enum LabelState {
    case selected
    case deselected
}

final class BookTimeCell: UITableViewCell {
    var selectedDate: Date?
    private var selectedTime: Int?
    private var verticalStackView: UIStackView!
    private var labels = [(label: UILabel, state: LabelState)]()
    var buttonAction: ((Int) -> Void)?
    
    func setup(date: ([String], [Int]), isAvailable: [Int]) {
        guard let selectedDate = selectedDate else { return }
        
        if verticalStackView != nil {
            clearStackView()
        }
        
        createVerticalStackView()

        dateFormat(selectedDate: selectedDate, date: date, isAvailable: isAvailable)
        
        if !labels.isEmpty {
            let horizontalStackView = createHorizontalStackView(with: labels.map { $0.label })
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    private func dateFormat(selectedDate: Date, date: ([String], [Int]), isAvailable: [Int]) {
        for (index, dateString) in date.0.enumerated() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy"
            let currentDay = outputFormatter.string(from: selectedDate)
            
            if let timeDate = dateFormatter.date(from: dateString),
               outputFormatter.string(from: timeDate) == currentDay {
                
                let timeString = formatTimeString(from: timeDate)
                let available: LabelState = isAvailable[index] == 0 ? .selected : .deselected
                let label = createLabel(with: timeString, tag: date.1[index], available: available)
                labels.append((label: label, state: available))
                
            }
        }
    }
    
    private func clearStackView() {
        verticalStackView?.removeFromSuperview()
        labels.removeAll()
    }
    
    private func createVerticalStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = DesignConstants.cornerRadius
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView = stackView
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: DesignConstants.frameHeight),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                        constant: DesignConstants.anchorStackView),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor,
                                                   constant: DesignConstants.frameHeight),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                                      constant: DesignConstants.anchorStackView)
        ])
    }
    
    private func formatTimeString(from date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    @objc private func labelTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLabel = sender.view as? UILabel else { return }
        selectedTime = selectedLabel.tag
        
        if let index = labels.firstIndex(where: { $0.label == selectedLabel }) {
            switch labels[index].state {
            case .selected:
                labels[index].label.backgroundColor = AppColors.textFieldBackground.color
                labels[index].label.textColor = AppColors.blackAsset.color
                labels[index].state = .deselected
            case .deselected:
                for index in labels.indices {
                    labels[index].label.backgroundColor = AppColors.textFieldBackground.color
                    labels[index].label.textColor = AppColors.blackAsset.color
                    labels[index].state = .deselected
                }
                labels[index].label.backgroundColor = AppColors.buttonColor.color
                labels[index].label.textColor = AppColors.whiteAsset.color
                labels[index].state = .selected
            }
        }
    }
    
    private func createLabel(with text: String, tag: Int, available: LabelState) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tag = tag
        label.textAlignment = .center
        label.backgroundColor = AppColors.textFieldBackground.color
        label.layer.cornerRadius = DesignConstants.cornerRadius
        label.clipsToBounds = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        if available == .selected {
            label.isUserInteractionEnabled = false
            label.isEnabled = false
        } else {
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
        }
        return label
    }
    
    @IBAction private func bookTime() {
        buttonAction?(selectedTime ?? 0)
    }
    
    private func createHorizontalStackView(with labels: [UILabel]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.spacing = DesignConstants.cornerRadius
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }
}
