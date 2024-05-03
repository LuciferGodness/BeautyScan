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
    private var verticalStackView: UIStackView!
    private var labels = [(label: UILabel, state: LabelState)]()
    
    func setup(date: [String]) {
        guard let selectedDate = selectedDate else { return }
        
        if verticalStackView != nil {
            clearStackView()
        }
        
        createVerticalStackView()

        dateFormat(selectedDate: selectedDate, date: date)
        
        if !labels.isEmpty {
            let horizontalStackView = createHorizontalStackView(with: labels.map { $0.label })
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    private func dateFormat(selectedDate: Date, date: [String]) {
        for dateString in date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy"
            outputFormatter.timeZone = TimeZone(identifier: "Russia/Moscow")
            let currentDay = outputFormatter.string(from: selectedDate)
            
            if let timeDate = dateFormatter.date(from: dateString),
               outputFormatter.string(from: timeDate) == currentDay {
                
                let timeString = formatTimeString(from: timeDate)
                let label = createLabel(with: timeString)
                label.tag = labels.count
                labels.append((label: label, state: .deselected))
                
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
        let selectedTime = selectedLabel.text ?? ""
        
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
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = AppColors.textFieldBackground.color
        label.layer.cornerRadius = DesignConstants.cornerRadius
        label.clipsToBounds = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
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
