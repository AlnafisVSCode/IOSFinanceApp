//
//  LoansMortgageViewController.swift
//  FinanceApp
//
//  Created by Alnafis Chowdhury on 04/03/2022.
//

import UIKit

class LoansMortgageViewController: UIViewController {
    //Labels and TextFields + icons inside textfields
    @IBOutlet weak var loansMortgageLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var loanAmountTextField: UITextField! {
        didSet{
            let iconPLabel = UILabel()
            iconPLabel.text = "£ :"
            iconPLabel.sizeToFit()
            loanAmountTextField.leftView = iconPLabel
            loanAmountTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    @IBOutlet weak var interestAmountLabel: UILabel!
    @IBOutlet weak var interestAmountTextField: UITextField! {
        didSet{
            let iconILabel = UILabel()
            iconILabel.text = "% :"
            iconILabel.sizeToFit()
            interestAmountTextField.leftView = iconILabel
            interestAmountTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var monthlyPaymentTextField: UITextField! {
        didSet{
            let iconPPLabel = UILabel()
            iconPPLabel.text = "£ : "
            iconPPLabel.sizeToFit()
            monthlyPaymentTextField.leftView = iconPPLabel
            monthlyPaymentTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    
    @IBOutlet weak var numberOfPaymentsLabel: UILabel!
    @IBOutlet weak var numberPaymentsTextField: UITextField! {
        didSet{
            let iconNumLabel = UILabel()
            iconNumLabel.text = "Time :"
            iconNumLabel.sizeToFit()
            numberPaymentsTextField.leftView = iconNumLabel
            numberPaymentsTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    //For the switch (year-month)
    @IBOutlet weak var showYearsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Naming the labels
        self.loansMortgageLabel.text = "Loans Mortgage"
        self.loanAmountLabel.text = "Loan Amount £ :"
        self.interestAmountLabel.text = "Interest % :"
        self.monthlyPaymentLabel.text = "Monthly Payment £ :"
        self.numberOfPaymentsLabel.text = "Number Of Payments (Months):"
        self.showYearsLabel.text = "Show Years"
        
        
        //listen for the notification the app moved to the background
        //The system persist user data if the application closes or quits. To also repopulate them once restarted
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        let defaults = UserDefaults.standard
        let loanAmount = defaults.string(forKey: "loanAmount")
        let loansInterestRate = defaults.string(forKey: "loansInterestRate")
        let monthlyPaymentAmount = defaults.string(forKey: "monthlyPaymentAmount")
        let loansNumberOfPayment = defaults.string(forKey: "loansNumberOfPayment")
        
        
        loanAmountTextField.text = loanAmount
        interestAmountTextField.text = loansInterestRate
        monthlyPaymentTextField.text = monthlyPaymentAmount
        numberPaymentsTextField.text = loansNumberOfPayment
    }
    //repopulate the fields with saved information using key
    @objc   func appMovedToBackground() {
        print("backgrounded or closed")
        
        let defaults = UserDefaults.standard
        let loanAmount = loanAmountTextField.text
        defaults.set(loanAmount, forKey: "loanAmount")
        
        let loansInterestRate = interestAmountTextField.text
        defaults.set(loansInterestRate, forKey: "loansInterestRate")
        
        let monthlyPaymentAmount = monthlyPaymentTextField.text
        defaults.set(monthlyPaymentAmount, forKey: "monthlyPaymentAmount")
        
        let loansNumberOfPayment = numberPaymentsTextField.text
        defaults.set(loansNumberOfPayment, forKey: "loansNumberOfPayment")
        
        
        
    }
    //counter for each text fields! used later to identify if there were blank field
    func checkFieldOutput() -> Int {
        var counter = 0
        if !(loanAmountTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(interestAmountTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(monthlyPaymentTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(numberPaymentsTextField.text?.isEmpty)! {
            counter += 1
        } else {
        }
        return counter
    }
    
    //pop alerts used to warn user if they missed any fields
    func textPopUpAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //Tap Gesture! to get the keypad hidden toggle
    @IBAction func tapGestureCompound(_ sender: UITapGestureRecognizer) {
        if((self.view.viewWithTag(1)?.isFirstResponder) != nil)
        {
            loanAmountTextField.resignFirstResponder()
            interestAmountTextField.resignFirstResponder()
            monthlyPaymentTextField.resignFirstResponder()
            numberPaymentsTextField.resignFirstResponder()
        }
    }
    
    //To Calculate empty field / alert message after field check
    @IBAction func calculateButtonLoans(_ sender: UIButton) {
        if (interestAmountTextField.text == "") {
            textPopUpAlert(message: "Interest Field Must be Filled!, loans and mortgage does not allow interest field to be calculated.", title: "Alert")
            return
        } else if checkFieldOutput() == 3 {
            calculateEmptyField()
        } else if checkFieldOutput() == 4 {
            textPopUpAlert(message: "Leave the field you want to calculate empty", title: "Alert")
        } else if checkFieldOutput() == 0 {
            textPopUpAlert(message: "Fill Out Fields to Calculate!", title: "Alert")
        } else {
            textPopUpAlert(message: "Please fill atleast 3 fields to calculate answer!", title: "Alert")
        }
    }
    
    //Help Section within the page alert
    @IBAction func questionInstruction(_ sender: UIButton) {
        textPopUpAlert(message: "To calculate the Simple Saving: Required to fill in three fields from the following text fields, principal Amount, Interest, future value and number of payments. Interest Rate can be left Not-Filled! \n\n To calculate the mortgage loan: Required to fill in three fields from the following text fields, Loan Amount, Interest, monthly payment or Number of Payments. Interest Rate Must be Filled! \n\n To calculate the Compound saving : Required to fill in four fields from the following text fields, principal amount, interest, monthly payment, future value and number of payment. Interest Rate Must be Filled! \n\n To Switch between years and months: Complete 3 or 4 Fields", title: "Help Instruction")
    }
    
    //Switch to convert months to years and years to months
    //https://www.ioscreator.com/tutorials/switch-ios-tutorial
    @IBAction func switchYearLoansMortgage(_ sender: UISwitch) {
        if (interestAmountTextField.text == "") {
            textPopUpAlert(message: "Interest Field Must be Filled!, loans and mortgage does not allow interest field to be calculated.", title: "Alert")
            return
        } else if checkFieldOutput() == 3 {
            calculateEmptyField()
        } else if checkFieldOutput() == 4 {
            calculateEmptyField()
        } else if checkFieldOutput() == 0 {
            textPopUpAlert(message: "Fill Out Fields to Calculate!", title: "Alert")
        } else {
            textPopUpAlert(message: "Please fill atleast 3 fields to calculate answer!", title: "Alert")
        }
        
        if sender.isOn {
            numberPaymentsTextField.text = ""
            showYearsLabel.text = "Show Years"
            numberOfPaymentsLabel.text = "Number Of Payments (Months)"
            presentValueState = .months
            
            calculateEmptyField()
        } else {
            numberPaymentsTextField.text = ""
            showYearsLabel.text = "Show Months"
            numberOfPaymentsLabel.text = "Number Of Payments (Years)"
            presentValueState = .years
            calculateEmptyField()
        }
    }
    //predefined list of values- switching between years and months
    enum switchState {
        case months
        case years
    }
    
    //current state of switch - starting with months default
    var presentValueState: switchState? = .months
    
    //after switch action to turn value to year conversion
    func changeState() {
        if presentValueState == .years {
            print("Test")
        }
    }
    
    //reset
    @IBAction func resetButtonLoans(_ sender: UIButton) {
        resetTextFields()
    }
    
    //reset fields
    func resetTextFields() {
        loanAmountTextField.text = ""
        interestAmountTextField.text = ""
        monthlyPaymentTextField.text = ""
        numberPaymentsTextField.text = ""
    }
    
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    
    //https://www.calculatorsoup.com/calculators/financial/loan-calculator.php    //-------------------------------------------------------------------------------------------------------------------
    // Principal Loan Amount Monthly -done
    func monthlyPrincipleAmount(interest: Double, monthlyPayment: Double, numberOfPayments: Double) throws -> Double {
        let PMT = monthlyPayment
        let R = (interest / 100.0)/12
        let T = numberOfPayments
        let P = (PMT/R)*(1 - (1/(pow(1+R, T))))
        
        let decX = (P * 100).rounded()/100
        return decX
    }
    
    
    // Principal Loan Amount Yearly -done
    func yearlyPrincipleAmount(interest: Double, monthlyPayment: Double, numberOfPayments: Double) throws -> Double {
        let PMT = monthlyPayment
        let R = (interest / 100.0) / 12
        let T = numberOfPayments * 12
        let P = (PMT/R)*(1 - (1/(pow(1+R, T))))
        
        let decX = ((P * 100)).rounded()/100 //* 12 Is for number of months in year(12)
        return decX
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------
    
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    
    //Monthly Payment -done
    func calculateMissingMonthlyPayment(interest: Double, principalAmount: Double, numberOfPayments: Double) throws -> Double {
        let R = (interest / 100.0) / 12
        let P = principalAmount
        let T = numberOfPayments
        
        //        let PMT = (P * (R/N) * pow(1+(R/N), N*T))/(pow(1+(R/N), N*T) - 1)
        
        let PMT = (((P*R)*(pow(1+R, T)))/(pow(1+R, T)-1))
        
        let decX = (PMT * 100).rounded()/100
        return decX
    }
    
    //Monthly Payment Field Yearly Coversion -done
    func calculateMissingYearlyPayment(interest: Double, principalAmount: Double, numberOfPayments: Double) throws-> Double {
        let R = (interest / 100.0) / 12
        let P = principalAmount
        let T = numberOfPayments*12
        
        let PMT = (((P*R)*(pow(1+R, T)))/(pow(1+R, T)-1))
        
        let decX = (PMT * 100).rounded()/100
        return decX
    }
    
    //-------------------------------------------------------------------------------------------------------------------
    
    //Number of payments(Monthly)-done
    func monthlyNumberOfPayments(interest: Double, principalAmount: Double, monthlyPayment: Double) throws -> Double {
        let PMT = monthlyPayment
        let P = principalAmount
        let R = (interest / 100.0) / 12
        
        let partA = log((PMT/R) / ((PMT / R) - P))
        let partB = log(1+R)
        
        let N = (partA / partB)
        
        let decX = (N * 100).rounded() / 100
        return decX
    }
    
    //-------------------------------------------------------------------------------------------------------------------
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    
    //Number of payments (Years Converted)-done
    func yearlyNumberOfPayments(interest: Double, principalAmount: Double, monthlyPayment: Double) throws -> Double {
        let PMT = monthlyPayment
        let P = principalAmount
        let R = (interest / 100.0) / 12
        
        //        let partA = log((-12 * PMT)/((P * (R/100)) - (12 * PMT)))
        //        let partB = 12 * log(((R/100) + 12)/12)
        let partA = log((PMT/R) / ((PMT / R) - P))
        let partB = log(1+R)
        
        let N = (partA / partB) / 12
        let decX = (N * 100).rounded() / 100
        return decX
    }
            
    
    //-------------------------------------------------------------------------------------------------------------------
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    
    
    func calculateEmptyField() {
        
        let P = Double(loanAmountTextField.text!)
        let R = Double(interestAmountTextField.text!)
        let PMT = Double(monthlyPaymentTextField.text!)
        let T = Double(numberPaymentsTextField.text!)
        
        //To start at 0 for each of textfields
        var result : Double = 0.0
        
        //if textbox empty and in months use (X Formula) else use (Y Formula)
        
        
        if (loanAmountTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = Double(monthlyPrincipleAmount(interest: R!, monthlyPayment: PMT!, numberOfPayments: T!))
                    loanAmountTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            } else if presentValueState == .years {
                do {
                    try result = Double(yearlyPrincipleAmount(interest: R!, monthlyPayment: PMT!, numberOfPayments: T!))
                    loanAmountTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
        //-------------------------------------------------------------------------------------------------------------------
        
        //Monthly PaymentWithout Year Cal
        if (monthlyPaymentTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = Double(calculateMissingMonthlyPayment(interest: R!, principalAmount: P!, numberOfPayments: T!))
                    monthlyPaymentTextField.text = String(result)
                }
                catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = Double(calculateMissingYearlyPayment(interest: R!, principalAmount: P!, numberOfPayments: T!))
                    monthlyPaymentTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        //-------------------------------------------------------------------------------------------------------------------
        
        //Number of payments Conversion(Year or months)
        if (numberPaymentsTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = monthlyNumberOfPayments(interest: R!, principalAmount: P!, monthlyPayment: PMT!)
                    numberPaymentsTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = yearlyNumberOfPayments(interest: R!, principalAmount: P!, monthlyPayment: PMT!)
                    numberPaymentsTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
    }
    
}

