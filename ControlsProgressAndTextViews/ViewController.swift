//
//  ViewController.swift
//  ControlsProgressAndTextViews
//
//  Created by Alejandro Vanegas Rondon on 3/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Interact: UIButton!
    @IBOutlet weak var pickerCount: UIPickerView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var progressIndicator: UIProgressView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
    private let numbers: [String] = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Interact.setTitle("My Button", for: .normal)
        Interact.backgroundColor = .blue
        Interact.setTitleColor(.white, for: .normal)
        
        pickerCount.backgroundColor = .lightGray
        pickerCount.delegate = self
        pickerCount.dataSource = self
        pickerCount.isHidden = true
        
        pageControl.numberOfPages = numbers.count
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .lightGray
        
        segmentedControl.removeAllSegments()
        for (index, value) in numbers.enumerated() {
            segmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        sliderControl.minimumTrackTintColor = .red
        sliderControl.minimumValue = 1
        sliderControl.maximumValue = Float(numbers.count)
        sliderControl.value = 1
        
        stepperControl.minimumValue = 1
        stepperControl.maximumValue = Double(numbers.count)
        
        switchControl.isOn = false
        switchControl.onTintColor = .purple
        
        progressIndicator.progress = 0
        
        indicatorView.color = .orange
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        
        stepperLabel.font = UIFont.boldSystemFont(ofSize: 36)
        stepperLabel.text = "1"
        stepperLabel.textColor = .darkGray
        
        switchLabel.text = "Off"
        
        textField.textColor = .orange
        textField.placeholder = "Write something!"
        textField.delegate = self
        
        textView.textColor = .brown
        textView.isEditable = true
        textView.delegate = self
        
    }

    @IBAction func changeColor(_ sender: Any) {
        
        if Interact.backgroundColor == .blue {
            
            Interact.backgroundColor = .green
            Interact.setTitleColor( .black, for: .normal )
        }
        else {
            
            Interact.backgroundColor = .blue
            Interact.setTitleColor( .white, for: .normal )
            
        }
        
        textView.resignFirstResponder()
        
    }
    
    @IBAction func changgePos(_ sender: Any) {
        
        pickerCount.selectRow(pageControl.currentPage, inComponent: 0, animated: true)
        Interact.setTitle(numbers[pageControl.currentPage], for: .normal)
        segmentedControl.selectedSegmentIndex = pageControl.currentPage
        stepperControl.value = Double(pageControl.currentPage)
        sliderControl.value = Float(pageControl.currentPage) + 1
        stepperControl.value = Double(pageControl.currentPage) + 1
        stepperLabel.text = String(pageControl.currentPage + 1)
        
        
    }
    
    @IBAction func changeSegmentPost(_ sender: Any) {
        
        pickerCount.selectRow(segmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        Interact.setTitle(numbers[segmentedControl.selectedSegmentIndex], for: .normal)
        pageControl.currentPage = segmentedControl.selectedSegmentIndex
        sliderControl.value = Float(segmentedControl.selectedSegmentIndex) + 1
        stepperControl.value = Double(segmentedControl.selectedSegmentIndex) + 1
        stepperLabel.text = String(segmentedControl.selectedSegmentIndex + 1)
        
    }
    
    @IBAction func changeSliderPos(_ sender: Any) {
        
        switch sliderControl.value {
            
        case 1..<2:
            segmentedControl.selectedSegmentIndex = 0
            pageControl.currentPage = 0
            Interact.setTitle(numbers[0], for: .normal)
            pickerCount.selectRow(0, inComponent: 0, animated: true)
            stepperControl.value = 1
        case 2..<3:
            segmentedControl.selectedSegmentIndex = 1
            pageControl.currentPage = 1
            Interact.setTitle(numbers[1], for: .normal)
            pickerCount.selectRow(1, inComponent: 0, animated: true)
            stepperControl.value = 2
        case 3..<4:
            segmentedControl.selectedSegmentIndex = 2
            pageControl.currentPage = 2
            Interact.setTitle(numbers[2], for: .normal)
            pickerCount.selectRow(2, inComponent: 0, animated: true)
            stepperControl.value = 3
        case 4..<5:
            segmentedControl.selectedSegmentIndex = 3
            pageControl.currentPage = 3
            Interact.setTitle(numbers[3], for: .normal)
            pickerCount.selectRow(3, inComponent: 0, animated: true)
            stepperControl.value = 4
        default:
            segmentedControl.selectedSegmentIndex = 4
            pageControl.currentPage = 4
            Interact.setTitle(numbers[4], for: .normal)
            pickerCount.selectRow(4, inComponent: 0, animated: true)
            stepperControl.value = 5
            
        }
        
        
        progressIndicator.progress = (sliderControl.value)/5
        stepperLabel.text = String(Int(sliderControl.value))
    }
    
    @IBAction func changeStepperPos(_ sender: Any) {
        
        var stepperValue = stepperControl.value
        sliderControl.value = Float(stepperValue)
        segmentedControl.selectedSegmentIndex = Int(stepperValue) - 1
        pageControl.currentPage = Int(stepperValue) - 1
        pickerCount.selectRow(Int(stepperValue) - 1, inComponent: 0, animated: true)
        stepperLabel.text = String(Int(stepperValue))
        
    }
    
    @IBAction func changeSwitchState(_ sender: Any) {
        
        if switchControl.isOn {
            
            pickerCount.isHidden = false
            indicatorView.stopAnimating()
            switchLabel.text = "On"
            
        }
        
        else {
            
            pickerCount.isHidden = true
            indicatorView.startAnimating()
            switchLabel.text = "Off"
            
        }
        
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numbers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Interact.setTitle(numbers[row], for: .normal)
        pageControl.currentPage = row
        segmentedControl.selectedSegmentIndex = row
        sliderControl.value = Float(row) + 1
        stepperControl.value = Double(row) + 1
        stepperLabel.text = String(row + 1)
        
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Interact.setTitle(textField.text, for: .normal)
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textField.isHidden = false
    }
    
}
