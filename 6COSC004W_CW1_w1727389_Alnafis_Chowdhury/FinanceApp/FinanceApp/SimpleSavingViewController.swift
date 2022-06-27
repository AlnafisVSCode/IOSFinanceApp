//
//  SimpleSavingViewController.swift
//  FinanceApp
//
//  Created by Alnafis Chowdhury on 04/03/2022.
//

import UIKit

class SimpleSavingViewController: UIViewController {
    //Labels and TextFields + icons inside textfields
    @IBOutlet weak var simpleSavingLabel: UILabel!
    @IBOutlet weak var principalAmountLabel: UILabel!
    @IBOutlet weak var principalAmountTextField: UITextField! {
        didSet{
            let iconPALabel = UILabel()
            iconPALabel.text = " £ :"
            iconPALabel.sizeToFit()
            principalAmountTextField.leftView = iconPALabel
            principalAmountTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var interestTextField: UITextField! {
        didSet{
            let iconINLabel = UILabel()
            iconINLabel.text = " % :"
            iconINLabel.sizeToFit()
            interestTextField.leftView = iconINLabel
            interestTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    
    @IBOutlet weak var futureValue: UILabel!
    @IBOutlet weak var futureValueTextField: UITextField! {
        didSet{
            let iconFVLabel = UILabel()
            iconFVLabel.text = " £ : "
            iconFVLabel.sizeToFit()
            futureValueTextField.leftView = iconFVLabel
            futureValueTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    
    @IBOutlet weak var numberOfPaymentsLabel: UILabel!
    @IBOutlet weak var numberOfPaymentsTextField: UITextField!  {
        didSet{
            let iconNumLabel = UILabel()
            iconNumLabel.text = "Time :"
            iconNumLabel.sizeToFit()
            numberOfPaymentsTextField.leftView = iconNumLabel
            numberOfPaymentsTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    
    @IBOutlet weak var showYearsLabel: UILabel! //for the switch
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Naming labels
        self.simpleSavingLabel.text = "Simple Savings"
        self.principalAmountLabel.text = "Principal Amount £ :"
        self.interestLabel.text = "Interest % :"
        self.futureValue.text = "Future Value £ :"
        self.numberOfPaymentsLabel.text = "Number Of Payments (Months): "
        self.showYearsLabel.text = "Show Years"
        
        //The system persist user data if the application closes or quits. To also repopulate them once restarted
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        let defaults = UserDefaults.standard
        let principalAmount = defaults.string(forKey: "principalAmount")
        let interestRate = defaults.string(forKey: "interestRate")
        let futureValue = defaults.string(forKey: "futureValue")
        let numberOfPayments = defaults.string(forKey: "numberOfPayments")
        
        
        principalAmountTextField.text = principalAmount
        interestTextField.text = interestRate
        futureValueTextField.text = futureValue
        numberOfPaymentsTextField.text = numberOfPayments
    }
    
    //repopulate the fields with saved information using key
    @objc func appMovedToBackground() {
        print("backgrounded or closed")
        
        let defaults = UserDefaults.standard
        let principalAmount = principalAmountTextField.text
        defaults.set(principalAmount, forKey: "principalAmount")
        
        let interestRate = interestTextField.text
        defaults.set(interestRate, forKey: "interestRate")
        
        let futureValue = futureValueTextField.text
        defaults.set(futureValue, forKey: "futureValue")
        
        
        let numberOfPayments = numberOfPaymentsTextField.text
        defaults.set(numberOfPayments, forKey: "numberOfPayments")
        
    }
    
    //counter for each text fields! used later to identify if there were blank field
    func checkFieldOutput() -> Int {
        var counter = 0
        if !(principalAmountTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(interestTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(futureValueTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(numberOfPaymentsTextField.text?.isEmpty)! {
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
    @IBAction func tapGestureLoans(_ sender: UITapGestureRecognizer) {
        if((self.view.viewWithTag(1)?.isFirstResponder) != nil)
        {
            principalAmountTextField.resignFirstResponder()
            interestTextField.resignFirstResponder()
            futureValueTextField.resignFirstResponder()
            numberOfPaymentsTextField.resignFirstResponder()
        }
    }
    
    
    //To Calculate empty field / alert message after field check
    @IBAction func buttonCalculateSaving(_ sender: UIButton) {
        if checkFieldOutput() == 3 {
            calculateEmptyField()
        } else if checkFieldOutput() == 4 {
            textPopUpAlert(message: "Leave the field you want to calculate empty!", title: "Alert")
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
    @IBAction func switchToYears(_ sender: UISwitch) {
        if (interestTextField.text == "") {
            textPopUpAlert(message: "Switching Duration Type before calculating answer!.", title: "Alert")
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
            numberOfPaymentsTextField.text = ""
            showYearsLabel.text = "Show Years"
            numberOfPaymentsLabel.text = "Number Of Payments (Months)"
            presentValueState = .months
            calculateEmptyField()
        } else {
            numberOfPaymentsTextField.text = ""
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
    
    func changeState() {
        if presentValueState == .years { //after switch action to turn value to year conversion
            print("Test")
        }
    }
    //button to reset- reset function
    @IBAction func ResetButton(_ sender: UIButton) {
        resetFields()
    }
    //reset function
    func resetFields() {
        principalAmountTextField.text = ""
        interestTextField.text = ""
        futureValueTextField.text = ""
        numberOfPaymentsTextField.text = ""
    }
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    //--------------------------------------------------------------------------------------------
    //Principal Amount (Monthly Conversion)-done
    func monthlyCalculationPrincipalAmount(futureValue: Double, interest: Double, compoundInterest: Double, numberOfPayment: Double) throws -> Double {
        
        let A = Double(futureValue)
        let R = Double(interest / 100.0)
        let T = Double(numberOfPayment)/12
        let N = Double(compoundInterest)
        let P = Double(A/pow(1 + (R/N), N*T))
        
        let twoDecimalAns = (P * 100).rounded()/100//rounded 2 decimal point
        
        return twoDecimalAns
    }
    
    //Principal Amount (Yearly Conversion)-done
    func yearlyCalculationPrincipalAmount(futureValue: Double, interest: Double, compoundInterest: Double,  numberOfPayment: Double) throws -> Double {
        
        let A = Double(futureValue)
        let R = Double(interest / 100.0)
        let T = Double(numberOfPayment)
        let N = Double(compoundInterest)
        let P = Double(A/pow(1 + (R/N), N*T))
        let twoDecimalAns = (P * 100).rounded()/100
        
        return twoDecimalAns
    }
    
    //--------------------------------------------------------------------------------------------
    //Future Value (Monthly)-done
    func calculateFutureValueMonthly(principalValue: Double, interest: Double, compoundInterest: Double, numberOfPayments: Double) throws -> Double {
        let P = Double(principalValue)
        let R = Double((interest) / 100)
        let T = Double(numberOfPayments)/12
        let N = Double(compoundInterest)
        let A = Double(P * (pow((1 + R/N), N * T)))
        let twoDecimalAns = (A * 100).rounded()/100//rounded 2 decimal point
        
        return twoDecimalAns
    }
    //Future Value (Yearly)-done
    func calculateFutureValueYearly(principalValue: Double, interest: Double, compoundInterest: Double, numberOfPayments: Double) throws -> Double {
        let P = Double(principalValue)
        let R = Double((interest) / 100)
        let T = Double(numberOfPayments)
        let N = Double(compoundInterest)
        let A = Double(P * (pow((1 + R/N), N * T)))
        let twoDecimalAns = (A * 100).rounded()/100
        
        return twoDecimalAns
    }
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    //--------------------------------------------------------------------------------------------
    // Interest Rate (Monthly Conversion!)-done
    func monthlyInterestRate(principalValue: Double, futureValue: Double, compoundInterest: Double, numberOfPayments: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let T = Double(numberOfPayments)/12
        let N = Double(compoundInterest)
        let R = Double(N * (pow((A/P),(1/(N * T))) - 1))
        let twoDecimalAns = ((R*100) * 100).rounded()/100//rounded 2 decimal point
        
        return twoDecimalAns
    }
    // Interest Rate (Yearly Conversion!)-done
    func yearlyInterestRate(principalValue: Double, futureValue: Double, compoundInterest: Double, numberOfPayments: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let T = Double(numberOfPayments)
        let N = Double(compoundInterest)
        let R = Double(N * (pow((A/P),(1/(N * T))) - 1))
        let twoDecimalAns = ((R*100) * 100).rounded()/100
        
        return twoDecimalAns
    }
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    //--------------------------------------------------------------------------------------------
    //Number of payments(Monthly Conversion)-done
    func monthlyNumberOfPayments(principalValue: Double, futureValue: Double, compoundInterest: Double, interest: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let N = Double(compoundInterest)
        let R = Double(interest / 100)
        let T = Double(log(A/P) / (N * log(1+(R/N)))) * 12
        let twoDecimalAns = (T * 100).rounded()/100//rounded 2 decimal point
        
        return twoDecimalAns
    }
    //Number of payments(Yearly Conversion)-done
    func yearlyNumberOfPayments(principalValue: Double, futureValue: Double, compoundInterest: Double, interest: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let N = Double(compoundInterest)
        let R = Double(interest / 100)
        let T = Double(log(A/P) / (N * log(1+(R/N)))) //Formula for this Cal
        let twoDecimalAns = (T * 100).rounded()/100
        
        return twoDecimalAns
    }
    
    //--------------------------------------------------------------------------------------------
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    //To calculate any emptyField
    func calculateEmptyField() {
        
        let A = Double(futureValueTextField.text!)//futureValue
        let P = Double(principalAmountTextField.text!)//principal value
        let R = Double(interestTextField.text!)//interest
        let N = 12.0//years
        let T = Double(numberOfPaymentsTextField.text!)//number of payments
        
        //To start at 0 for each of textfields
        var answerBox : Double = 0.0
        
        //if textbox empty and in months use (X Formula) else use (Y Formula)
        
        //Principal textfields
        if (principalAmountTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try answerBox = Double (monthlyCalculationPrincipalAmount(futureValue: A!, interest: R!, compoundInterest: N, numberOfPayment: T!))
                    principalAmountTextField.text = String(answerBox)
                } catch let err {
                    print(err)
                }
            } else {
                do {
                    try answerBox = Double (yearlyCalculationPrincipalAmount(futureValue: A!, interest: R!, compoundInterest: N, numberOfPayment: T!))
                    principalAmountTextField.text = String(answerBox)
                }
                catch let err {
                    print(err)
                }
            }
        }
        //--------------------------------------------------------------------------------------------
        
        //Interest TextField
        if (interestTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try answerBox = Double (monthlyInterestRate(principalValue: P!, futureValue: A!, compoundInterest: N, numberOfPayments: T!))
                    interestTextField.text = String(answerBox)
                } catch let err {
                    print(err)
                }
            } else {
                do {
                    try answerBox = Double (yearlyInterestRate(principalValue: P!, futureValue: A!, compoundInterest: N, numberOfPayments: T!))
                    interestTextField.text = String(answerBox)
                }
                catch let err {
                    print(err)
                }
            }
        }
        
        //--------------------------------------------------------------------------------------------
        
        //FutureValue Text Fields
        if (futureValueTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try answerBox = Double (calculateFutureValueMonthly(principalValue: P!, interest: R!, compoundInterest: N, numberOfPayments: T!))
                    futureValueTextField.text = String(answerBox)
                } catch let err {
                    print(err)
                }
            } else {
                do {
                    try answerBox = Double (calculateFutureValueYearly(principalValue: P!, interest: R!, compoundInterest: N, numberOfPayments: T!))
                    futureValueTextField.text = String(answerBox)
                }
                catch let err {
                    print(err)
                }
            }
        }
        
        //--------------------------------------------------------------------------------------------
        //Number of Payments Text Fields
        if (numberOfPaymentsTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try answerBox = Double (monthlyNumberOfPayments(principalValue: P!, futureValue: A!, compoundInterest: N, interest: R!))
                    numberOfPaymentsTextField.text = String(answerBox)
                } catch let err {
                    print(err)
                }
            } else {
                do {
                    try answerBox = Double (yearlyNumberOfPayments(principalValue: P!, futureValue: A!, compoundInterest: N, interest: R!))
                    numberOfPaymentsTextField.text = String(answerBox)
                }
                catch let err {
                    print(err)
                }
            }
        }
        
        
    }
    
    
}
