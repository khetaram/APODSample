//
//  DatePickerView.swift
//  APODSample
//
//  Created by Khetaram Kumawat on 23/01/22.
//

import Cartography

struct DatePickerModel {
    let date: Date
    var donePressed: (_ date: Date) -> Void
}

class DatePickerView: UIView {
    private let datePicker : UIDatePicker = UIDatePicker()
    private let doneButton = UIButton()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = AppColor.bannerBackground
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .white
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChangedInDate(sender:)), for: .valueChanged)
        addSubview(datePicker)

        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.blue, for: .normal)
        doneButton.addTarget(self, action: #selector(doneClicked), for: .touchUpInside)

        addSubview(doneButton)


        constrain(datePicker, doneButton, self) { datePicker, doneButton, containerView in
            datePicker.top == containerView.top + 16

            doneButton.height == 40
            doneButton.width == 70

            if #available(iOS 14.0, *) {
                // iOS 14 and above inline date picker compact UI
                datePicker.centerX == containerView.centerX - 35
                datePicker.bottom == containerView.bottom - 16

                doneButton.centerY == containerView.centerY
                doneButton.trailing == containerView.trailing

            } else {
                datePicker.centerX == containerView.centerX
                doneButton.centerX == containerView.centerX
                datePicker.bottom == doneButton.top - 16
                doneButton.bottom == containerView.bottom - 8
            }
        }
    }

    func bindDate(model: DatePickerModel) {
        self.model = model
        selectedDate = model.date
        datePicker.setDate(model.date, animated: true)
    }

    var selectedDate: Date!
    var model: DatePickerModel?
    @objc func dateChangedInDate(sender: UIDatePicker){

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        selectedDate = sender.date
    }

    @objc func doneClicked() {
        model?.donePressed(selectedDate)
    }
}
