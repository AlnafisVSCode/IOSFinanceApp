//
//  CompoundSavingViewController.swift
//  FinanceApp
//
//  Created by Alnafis Chowdhury on 06/03/2022.
//

import UIKit

class CompoundSavingViewController: UIViewController {
    //Labels and TextFields + icons inside textfields
    @IBOutlet weak var compoundSavingsLabel: UILabel!
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
    
            
    @IBOutlet weak var monthlyPaymentLabel: UILabel!
    @IBOutlet weak var monthlyPaymentTextField: UITextField! {
        didSet{
            let iconPPLabel = UILabel()
            iconPPLabel.text = " £ : "
            iconPPLabel.sizeToFit()
            monthlyPaymentTextField.leftView = iconPPLabel
            monthlyPaymentTextField.leftViewMode = UITextField.ViewMode.always
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
    
    
    @IBOutlet weak var futureValueLabel: UILabel!
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
    @IBOutlet weak var numberOfPaymentsTextField: UITextField! {
        didSet{
            let iconNumLabel = UILabel()
            iconNumLabel.text = "Time :"
            iconNumLabel.sizeToFit()
            numberOfPaymentsTextField.leftView = iconNumLabel
            numberOfPaymentsTextField.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    //For the switch (year-month)
    @IBOutlet weak var showYearsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //naming the labels
        self.compoundSavingsLabel.text = "Compound Savings"
        self.principalAmountLabel.text = "Principal Amount £ :"
        self.interestLabel.text = "Interest % :"
        self.monthlyPaymentLabel.text = "Monthly Payment £ :"
        self.futureValueLabel.text = "Future Value £ :"
        self.numberOfPaymentsLabel.text = "Number of Payments (Months): "
        self.showYearsLabel.text = "Show Years"
        
        //The system persist user data if the application closes or quits. To also repopulate them once restarted
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        let defaults = UserDefaults.standard
        let principalAmountCompound = defaults.string(forKey: "principalAmountCompound")
        let monthlyPaymentCompound = defaults.string(forKey: "monthlyPaymentCompound")
        let interestRateCompound = defaults.string(forKey: "interestRateCompound")
        let futureValueCompound = defaults.string(forKey: "futureValueCompound")
        let numberOfPaymentsCompound = defaults.string(forKey: "numberOfPaymentsCompound")
        
        
        principalAmountTextField.text = principalAmountCompound
        monthlyPaymentTextField.text = monthlyPaymentCompound
        interestTextField.text = interestRateCompound
        futureValueTextField.text = futureValueCompound
        numberOfPaymentsTextField.text = numberOfPaymentsCompound
    }
    //repopulate the fields with saved information using key
    @objc func appMovedToBackground() {
        print("backgrounded or closed")
        
        let defaults = UserDefaults.standard
        let principalAmountCompound = principalAmountTextField.text
        defaults.set(principalAmountCompound, forKey: "principalAmountCompound")
        
        let monthlyPaymentCompound = monthlyPaymentTextField.text
        defaults.set(monthlyPaymentCompound, forKey: "monthlyPaymentCompound")
        
        let interestRateCompound = interestTextField.text
        defaults.set(interestRateCompound, forKey: "interestRateCompound")
        
        let futureValueCompound = futureValueTextField.text
        defaults.set(futureValueCompound, forKey: "futureValueCompound")
        
        
        let numberOfPaymentsCompound = numberOfPaymentsTextField.text
        defaults.set(numberOfPaymentsCompound, forKey: "numberOfPaymentsCompound")
        
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
        if !(monthlyPaymentTextField.text?.isEmpty)! {
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
    @IBAction func questionInstruction(_ sender: UIButton) {
        TextPopUpAlert(message: "To calculate the Simple Saving: Required to fill in three fields from the following text fields, principal Amount, Interest, future value and number of payments. Interest Rate can be left Not-Filled! \n\n To calculate the mortgage loan: Required to fill in three fields from the following text fields, Loan Amount, Interest, monthly payment or Number of Payments. Interest Rate Must be Filled! \n\n To calculate the Compound saving : Required to fill in four fields from the following text fields, principal amount, interest, monthly payment, future value and number of payment. Interest Rate Must be Filled! \n\n To Switch between years and months: Complete 4 or 5 Fields", title: "Help Instruction")
    }
    
    //pop alerts used to warn user if they missed any fields
    func TextPopUpAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //Tap Gesture! to get the keypad hidden toggle
    @IBAction func tapGestureCompound(_ sender: UITapGestureRecognizer) {
        if((self.view.viewWithTag(1)?.isFirstResponder) != nil)
        {
            principalAmountTextField.resignFirstResponder()
            monthlyPaymentTextField.resignFirstResponder()
            interestTextField.resignFirstResponder()
            futureValueTextField.resignFirstResponder()
            numberOfPaymentsTextField.resignFirstResponder()
        }
    }
    //To Calculate empty field / alert message after field check
    @IBAction func calculateButtonCompound(_ sender: UIButton) {
        if (interestTextField.text == "") {
            TextPopUpAlert(message: "Interest Field Must be Filled!, compound saving does not allow interest field to be calculated.", title: "Alert")
            return
        } else if checkFieldOutput() == 4 {
            calculateEmptyField()
        } else if checkFieldOutput() == 5 {
            TextPopUpAlert(message: "Leave the field you want to calculate empty", title: "Alert")
        } else if checkFieldOutput() == 0 {
            TextPopUpAlert(message: "Fill Out Fields to Calculate!", title: "Alert")
        } else {
            TextPopUpAlert(message: "Please fill atleast 4 fields to calculate answer!", title: "Alert")
        }
    }
    //Switch to convert months to years and years to months
    //https://www.ioscreator.com/tutorials/switch-ios-tutorial
    @IBAction func switchYearsCompound(_ sender: UISwitch) {
        if (interestTextField.text == "") {
            TextPopUpAlert(message: "Interest Field Must be Filled!, compound saving does not allow interest field to be calculated.", title: "Alert")
            return
        } else if checkFieldOutput() == 3 {
            TextPopUpAlert(message: "Switching Duration Type before calculating answer!", title: "Alert")
        } else if checkFieldOutput() == 4 {
            calculateEmptyField()
        } else if checkFieldOutput() == 5 {
            calculateEmptyField()
        } else if checkFieldOutput() == 0 {
            TextPopUpAlert(message: "Fill Out Fields to Calculate!", title: "Alert")
        } else {
            TextPopUpAlert(message: "Please fill atleast 4 fields to calculate answer!", title: "Alert")
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
    
    //after switch action to turn value to year conversion
    func changeState() {
        if presentValueState == .years {
            print("Test")
        }
    }
    //reset
    @IBAction func resetButtonCompound(_ sender: UIButton) {
        resetFields()
    }
    //reset fields
    func resetFields() {
        principalAmountTextField.text = ""
        monthlyPaymentTextField.text = ""
        interestTextField.text = ""
        futureValueTextField.text = ""
        numberOfPaymentsTextField.text = ""
    }
    
    //--------------------------------------------------------------------------------------------
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    //https://math.stackexchange.com/questions/4150453/compound-interest-with-regular-monthly-contributions-formula 
    //Principal Amount (Monthly Conversion)-done
    func monthlyCalculationPrincipalAmount(futureValue: Double, interest: Double, monthlyPayment: Double, compoundInterest: Double, numberOfPayment: Double) throws -> Double {
        
        let A = Double(futureValue)
        let R = Double(interest / 100.0)
        let T = Double(numberOfPayment)/12
        let N = Double(compoundInterest) //12
        let PMT = Double(monthlyPayment)
        
        
        let P = (A - (PMT * (pow((1 + R / N), T*N) - 1) / ( R / N))) / pow((1 + R / N), N * T)
        let decimalX = (P * 100).rounded()/100//rounded 2 decimal point
        
        return decimalX
        
    }
    
    //Principal Amount (Monthly Conversion)-done
    func yearlyCalculationPrincipalAmount(futureValue: Double, interest: Double, monthlyPayment: Double, compoundInterest: Double, numberOfPayment: Double) throws -> Double {
        
        let A = Double(futureValue)
        let R = Double(interest / 100.0)
        let T = Double(numberOfPayment)
        let N = Double(compoundInterest) //12
        let PMT = Double(monthlyPayment)
        
        let P = (A - (PMT * (pow((1 + R / N), T*N) - 1) / ( R / N))) / pow((1 + R / N), N * T)
        let decimalX = (P * 100).rounded()/100
        
        return decimalX
    }
    //--------------------------------------------------------------------------------------------
    
    //Number of Monthly Payments (Monthly)-done
    func calculateMissingMonthlyPayment(principalAmount: Double, futureValue: Double, compoundInterest: Double, interest: Double, numberOfPayments: Double) throws -> Double {
        let P = Double(principalAmount)
        let R = Double((interest)/100)
        let T = Double(numberOfPayments)/12
        let N = Double(compoundInterest)
        let A = Double(futureValue)
        
        //        let PMT = Double( ((A-P)*(pow(1+R/N, N*T))) / ((pow(1+R/N, N*T) - 1) / (R/N)) / (1 + R / N))
        let PMT =  (A-(P * (pow(1+R/N, N*T)))) / ((pow(1+R/N, N*T) - 1) / (R/N))
        
        let decimalX = (PMT * 100).rounded()/100//rounded 2 decimal point
        return decimalX
    }
    
    //Number of Monthly Payments (Yearly Conversion)-done
    func calculateMissingYearlyPayment(principalAmount: Double, futureValue: Double,  compoundInterest: Double, interest: Double, numberOfPayments: Double) throws -> Double {
        let P = Double(principalAmount)
        let R = Double((interest)/100)
        let T = Double(numberOfPayments)
        let N = Double(compoundInterest)
        let A = Double(futureValue)
        
        //        let T = Double((log(A + ((PMT * N) / R )) - log(((R * P) + (PMT * N )) / R )) / (N * log(1 + (R / N)))
        
        //        let PMT = Double( ((A-P)*(pow(1+R/N, N*T))) / ((pow(1+R/N, N*T) - 1) / (R/N)))
        let PMT =  (A-(P * (pow(1+R/N, N*T)))) / ((pow(1+R/N, N*T) - 1) / (R/N))
        
        let decimalX = (PMT * 100).rounded()/100
        
        return decimalX
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------
    
    
    //Future Value (Monthly)-done
    func calculateFutureValueMonthly(principalValue: Double, interest: Double, compoundInterest: Double, numberOfPayments: Double,  monthlyPayment: Double) throws -> Double {
        let P = Double(principalValue)
        let R = Double((interest)/100)
        let T = Double(numberOfPayments)/12
        let N = Double(compoundInterest)
        let PMT = Double(monthlyPayment)
        
        let A = Double((P * (pow (1+R/N, N * T))) + (PMT * (pow (1+(R / N), N * T)-1) / (R/N)))
        let decimalX = (A * 100).rounded()/100//rounded 2 decimal point
        
        return decimalX
    }
    
    //Future Value (Yearly)-done
    func calculateFutureValueYearly(principalValue: Double, interest: Double, compoundInterest: Double, numberOfPayments: Double,  monthlyPayment: Double) throws -> Double {
        let P = Double(principalValue)
        let R = Double((interest)/100)
        let T = Double(numberOfPayments)
        let N = Double(compoundInterest)
        let PMT = Double(monthlyPayment)
        
        let A = Double((P * (pow (1+R/N, N * T))) + (PMT * (pow (1+(R / N), N * T)-1) / (R/N)))
        let decimalX = (A*100).rounded()/100
        
        return decimalX
        
    }
    
    //-------------------------------------------------------------------------------------------------------
    
    //PMT = Monthly Payment
    //R = Interest
    //T = Number of Payments
    //P = Principal amount
    //N = Compound Interest
    //A = Future Value
    
    //Number of payments(Monthly Conversion)-done
    func monthlyNumberOfPayments(principalValue: Double, futureValue: Double, compoundInterest: Double, interest: Double, monthlyPayment: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let N = Double(compoundInterest)
        let R = Double((interest) / 100)
        let PMT = Double(monthlyPayment)
        
        let T = Double((log(A + ((PMT * N) / R)) - log(((R * P) + (PMT * N)) / R)) / (N * log(1 + (R / N))))
        //        return (T*12).rounded()
        let decimalX = ((T*12) * 100).rounded()/100 //rounded 2 decimal point
        
        return decimalX
    }
    
    //Number of payments(Yearly Conversion)-done
    func yearlyNumberOfPayments(principalValue: Double, futureValue: Double, compoundInterest: Double, interest: Double, monthlyPayment: Double) throws -> Double {
        let A = Double(futureValue)
        let P = Double(principalValue)
        let N = Double(compoundInterest)
        let R = Double(interest / 100)
        let PMT = Double(monthlyPayment)
        
        let T = Double((log(A + ((PMT * N) / R)) - log(((R * P) + (PMT * N)) / R)) / (N * log(1 + (R / N))))
        //        let T = Double(log(A/P) / (N * log(1+(R/N)))) //Formula for this Cal
        //        let Z = Double(round(1000 * T) / 1000) //To Convert into Years
        //        let Z = Double(round(1000 * T) / 1000) //To Convert into Years
        
        let decimalX = (T * 100).rounded()/100
        
        return decimalX
    }
    
    //-------------------------------------------------------------------------------------------------------------------
    //To calculate any emptyField
    func calculateEmptyField() {
        
        let A = Double(futureValueTextField.text!)
        let P = Double(principalAmountTextField.text!)
        let R = Double(interestTextField.text!)
        let N = 12.0
        let T = Double(numberOfPaymentsTextField.text!)
        let PMT = Double(monthlyPaymentTextField.text!)
        
        
        //To start at 0 for each of textfields
        var result : Double = 0.0
        
        //if textbox empty and in months use (X Formula) else use (Y Formula)
        
        
        // Principal Amount (Monthly and Yearly Conversion)
        if (principalAmountTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = monthlyCalculationPrincipalAmount(futureValue: A!, interest: R!, monthlyPayment: PMT!, compoundInterest: N, numberOfPayment: T!)
                    principalAmountTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = yearlyCalculationPrincipalAmount(futureValue: A!, interest: R!, monthlyPayment: PMT!, compoundInterest: N, numberOfPayment: T!)
                    principalAmountTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
        //-------------------------------------------------------------------------------------------------------------------
        
        // Monthly Payment (Monthly and Yearly Conversion)
        if (monthlyPaymentTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = calculateMissingMonthlyPayment(principalAmount: P!, futureValue: A!, compoundInterest: N, interest: R!, numberOfPayments: T!)
                    monthlyPaymentTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = calculateMissingYearlyPayment(principalAmount: P!, futureValue: A!, compoundInterest: N, interest: R!, numberOfPayments: T!)
                    monthlyPaymentTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
        //-------------------------------------------------------------------------------------------------------------------
        
        // Future Value (Monthly and Yearly Conversion)
        if (futureValueTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = calculateFutureValueMonthly(principalValue: P!, interest: R!, compoundInterest: N, numberOfPayments: T!, monthlyPayment: PMT!)
                    futureValueTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = calculateFutureValueYearly(principalValue: P!, interest: R!, compoundInterest: N, numberOfPayments: T!, monthlyPayment: PMT!)
                    futureValueTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
        
        //-----------------------------------------------------------------------------------------------------------
        
        // Number of Payments (Monthly and Yearly Conversion)
        if (numberOfPaymentsTextField.text?.isEmpty)! {
            if presentValueState == .months {
                do {
                    try result = monthlyNumberOfPayments(principalValue: P!, futureValue: A!, compoundInterest: N, interest: R!, monthlyPayment: PMT!)
                    numberOfPaymentsTextField.text = String(result)
                } catch let err {
                    print(err)
                }
            }else if presentValueState == .years {
                do {
                    try result = yearlyNumberOfPayments(principalValue: P!, futureValue: A!, compoundInterest: N, interest: R!, monthlyPayment: PMT!)
                    numberOfPaymentsTextField.text = String(result)
                }
                catch let err {
                    print (err)
                }
            }
            
        }
        
    }
    
    
}
