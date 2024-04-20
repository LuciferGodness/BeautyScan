//
//  AppointmentVC.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import UIKit
import SwiftUI

protocol PAppointmentVC: PBaseVC {
    func reloadTable()
}

final class AppointmentVC: BaseVC, PAppointmentVC {
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: PAppointmentVM?
    
    override var navigationBarTitle: String? {
        "Appointment"
    }
    
    override var isNavigationBarLeftButton: Bool {
        false
    }

    override func viewDidLoad() {
        viewModel?.getAppointment()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: DoctorMainInfoCell.self)
        tableView.registerCell(ofType: ImageCell.self)
        tableView.registerCell(ofType: WeekScheduleCell.self)
        tableView.registerCell(ofType: BookTimeCell.self)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }

    // MARK: - Navigation
}

extension AppointmentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            420
        } else if indexPath.row == 3 {
            200
        }
        else {
            300
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueCell(ofType: ImageCell.self) else {
                return UITableViewCell()
            }
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueCell(ofType: WeekScheduleCell.self) else {
                return UITableViewCell()
            }
            
            let hostingController = UIHostingController(rootView: CalendarView(didSelectDate: { date in
                self.didSelectDate(date)
            }))
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            addChild(hostingController)
            hostingController.view.frame = cell.calendarView.frame
            hostingController.view.layer.cornerRadius = 10
            cell.calendarView.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: cell.calendarView.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: cell.calendarView.leadingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: cell.calendarView.bottomAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: cell.calendarView.trailingAnchor),
                hostingController.view.widthAnchor.constraint(equalTo: cell.calendarView.widthAnchor),
                hostingController.view.heightAnchor.constraint(equalTo: cell.calendarView.heightAnchor)
                ])
            hostingController.view.contentMode = .scaleAspectFill
            hostingController.view.clipsToBounds = true
            hostingController.didMove(toParent: self)
            
            return cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueCell(ofType: BookTimeCell.self) else {
                return UITableViewCell()
            }
            cell.selectedDate = .now
            cell.setup(date: viewModel?.model?.date ?? [])

            return cell
        } else {
            guard let cell = tableView.dequeueCell(ofType: DoctorMainInfoCell.self) else {
                return UITableViewCell()
            }
            cell.setup(model: viewModel?.model)
            
            return cell
        }
    }
}

extension AppointmentVC {
    func didSelectDate(_ date: Date) {
        if let bookTimeCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? BookTimeCell {
            bookTimeCell.selectedDate = date
            bookTimeCell.setup(date: viewModel?.model?.date ?? [])
        }
    }
}

