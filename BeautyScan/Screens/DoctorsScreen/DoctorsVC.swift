//
//  DoctorsVC.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import UIKit

protocol PDoctorsVC: PBaseVC {
    func reloadTable()
}

final class DoctorsVC: BaseVC, PDoctorsVC {
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: PDoctorsVM?
    
    override var navigationBarTitle: String? {
        LocalizationKeys.doctors.localized()
    }
    
    override var isNavigationBarLeftButton: Bool {
        false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startLoading()
        viewModel?.getData()
        super.viewWillAppear(animated)
    }
    
    func reloadTable() {
        tableView.reloadData()
        endLoading()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ofType: UserAppointmentCell.self)
        tableView.registerCell(ofType: DoctorsCell.self)
    }

    // MARK: - Navigation
}

extension DoctorsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Sections(rawValue: section) {
        case .userAppointments:
            return viewModel?.appointmentModel.count ?? 0
        case .doctors:
            return viewModel?.doctorsModel.count ?? 0
        case .none: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Sections(rawValue: indexPath.section)?.rowHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .userAppointments:
            guard let cell = tableView.dequeueCell(ofType: UserAppointmentCell.self) else {
                return UITableViewCell()
            }
            cell.setup(model: viewModel?.appointmentModel[indexPath.row])
            return cell
        case .doctors:
            guard let cell = tableView.dequeueCell(ofType: DoctorsCell.self) else {
                return UITableViewCell()
            }
            cell.setup(model: viewModel?.doctorsModel[indexPath.row])
            return cell
        case .none: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        Sections(rawValue: section)?.headerView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Sections(rawValue: indexPath.section) {
        case .userAppointments:
            break
        case .doctors:
            if let doctor = viewModel?.doctorsModel[indexPath.row] {
                let doctorId = doctor.id
                openDoctorDetails(id: doctorId)
            }
        case .none:
            break
        }
    }
    
    private func openDoctorDetails(id: Int) {
        navigationController?.pushViewController(AppointmentAssembler.assemble(id: id), animated: true)
    }
}
