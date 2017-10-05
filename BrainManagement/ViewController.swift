//
//  ViewController.swift
//  BrainManagement
//
//  Created by eric yu on 5/9/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import AVFoundation


protocol MainViewDelegate{
    func setRoutines(routine: [String])
}


class ViewController: UIViewController,TimerBrainProtocol,RTTableViewControllerDelegate{
   
    var delegate: MainViewDelegate?
    fileprivate var tableViewBottomAnchor: NSLayoutConstraint!
    
    fileprivate var tableViewHeightAnchor: NSLayoutConstraint!
    
    fileprivate var startButtonHeightConstraint: NSLayoutConstraint!


    fileprivate var tableViewDownConstant: CGFloat!
    fileprivate var tableViewUpConstant: CGFloat!
    fileprivate var isTableTapped:Bool = false
    
    let gr:CGFloat = 34/55  //golden ratio
    let igr:CGFloat = 55/34 //inverse gold ratio
    
    var paddingWidth: CGFloat {
        return self.view.frame.width * self.gr
    }
    
   var paddingHeight: CGFloat {
        
        return self.paddingWidth * self.gr
    }

    
    
    var tableViewContainer:UIView = {
        let tv = UIView()
        tv.layer.cornerRadius = 5
        tv.layer.masksToBounds = true
        return tv
    }()
    
    //use to center label
    var bottomContainer: UIView = {
        let tv = UIView()
        return tv
    }()
    
    lazy var controller: RTTableViewController = {
        let vc = RTTableViewController(style: .plain)
        vc.delegate = self
      
        self.delegate = vc // rt set stuff back
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
       // vc.tableView.rowHeight = UITableViewAutomaticDimension
       // vc.tableView.estimatedRowHeight = 100
        self.addChildViewController(vc)
        return  vc
    }()
  
    lazy var segmentController:UISegmentedControl = {
        let sc = UISegmentedControl()
        
        
        sc.insertSegment(withTitle: "Morning", at: 0, animated: true)
        sc.insertSegment(withTitle: "Day", at: 1, animated: true)
        sc.insertSegment(withTitle: "Night", at: 2, animated: true)
        
       // sc.frame = CGRect(x: 0, y: 0, width: 180, height: 30)
        sc.tintColor = .orange
        sc.selectedSegmentIndex = 0
        
        
        sc.addTarget(self, action: #selector(segmentControllerTapped), for: .valueChanged)
        
        
        
        return sc
        
    }()

    var gestureCover:UIView = {
        let tv = UIView()
        tv.backgroundColor = .clear
        return tv
    }()

    lazy var timerView: ClockView = {
        let view = ClockView()
        
        view.backgroundColor = .green

  
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "00:00:00"
        label.backgroundColor = .green
        
       return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var timerBrain: TimerBrain = {
        let timerBrain = TimerBrain()
        timerBrain.delegate = self
        return timerBrain
    }()
    
    var soundPlayer: AVAudioPlayer?

    //set with coredata
    var routine: [String] = ["Clean Work Area,Clean Work Area,Clean Work Area","Workout 30 min","Meditation 15 min"]
  
 //MARK: -
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: not sure if this implimentation is good
        delegate?.setRoutines(routine: routine)
         // routineTableViewController.setRoutines(routine: routine)
   
        view.backgroundColor =  UIColor(white: 0.98, alpha: 0.98)
        
  
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        setUpTableView()
        setupContainerViewWithController()
        
        setupStartButton()
        setupNavigationTitleIcon()
      
   
    }
    
//MARK: -
    func viewTapped(){
        
        //if .ipad or already tapped don't do anything
        guard UIDevice.current.userInterfaceIdiom != .pad else {return}
        
        isTableTapped = false

        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            //self.tableViewHeightAnchor.constant = self.startButton.frame.height
             self.tableViewHeightAnchor.constant = self.view.frame.width * self.gr
        self.startButtonHeightConstraint.constant = self.paddingHeight
            //paddingHeight
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
       
     
        //original height
        
    }
    
       func didTouchTable() {
        
        //if ipad or table already tapped
        guard UIDevice.current.userInterfaceIdiom != .pad else {return}
        
        
        guard !isTableTapped else {return}
        
        isTableTapped = true
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
                        self.tableViewHeightAnchor.constant = self.view.bounds.width * self.gr * 2
                   
                        
                        
                        
                        
                        let bottomContainerHeight = self.bottomContainer.bounds.height - self.view.bounds.width * self.gr
                        
                        
                        if bottomContainerHeight < self.startButtonHeightConstraint.constant {
                            
                            self.startButtonHeightConstraint.constant = bottomContainerHeight
                        }
                

                        self.view.layoutIfNeeded()
                        
        },completion: nil)
        
    }
    
    func startButtonTapped(_ sender: Any) {
        if timerBrain.isPaused {
            timerBrain.resumeTimer()
        } else {
           timerBrain.setDurating(duration: TimeInterval(15 * 60))
            timerBrain.startTimer()
        }
        prepareSound()
    }
    func stopButtonTapped(_ sender: Any) {
        if timerBrain.isPaused {
            timerBrain.resumeTimer()
        } else {
           // timerBrain.duration = prefs.selectedTime
            timerBrain.startTimer()
        }
       
        prepareSound()
    }
    
    func resetButtonTapped(_ sender: Any) {
        if timerBrain.isPaused {
            timerBrain.resumeTimer()
        } else {
            //timerBrain.duration = prefs.selectedTime
            timerBrain.startTimer()
        }
       
        prepareSound()
    }
    
    //***********************************************//
    /*
    
    func timeCalculator(dateFormat: String, endTime: String, startTime: Date = Date()) -> DateComponents {
        formatter.dateFormat = dateFormat
        let _startTime = startTime
        let _endTime = formatter.date(from: endTime)
        
        let timeDifference = userCleander.dateComponents(requestedComponent, from: _startTime, to: _endTime!)
        return timeDifference
    }
    
    func timePrinter() -> Void {
        let time = timeCalculator(dateFormat: "MM/dd/yyyy hh:mm:ss a", endTime: "12/25/2017 12:00:00 a")
        timeLabel.text = "\(time.month!) Months \(time.day!) Days \(time.minute!) Minutes \(time.second!) Seconds"
    }
 */
    
   
    func timeRemainingOnTimer(_ timer: TimerBrain, timeRemaining: TimeInterval){
        
        let time = timeRemaining.stringFromTimeInterval(interval: timeRemaining)
       
       startButton.setTitle(time, for: .normal)
        
    }
    func timerHasFinished(_ timer: TimerBrain){
        
    }
    
    func addButtonTapped(){
        
    }
    func segmentControllerTapped(_ sender: UISegmentedControl){
        
        if let type = TableType(rawValue: sender.selectedSegmentIndex) {
            switch type {
            case .morning:
                self.delegate?.setRoutines(routine: ["a","b"])
                break
            case .day:
                 self.delegate?.setRoutines(routine: ["one","two","three"])
                break
            case .night:
                 self.delegate?.setRoutines(routine: ["a","b"])
                break
            }
        }
    }
    

}
// navigation
extension ViewController {
    
    func setupNavigationTitleIcon(){
        
        navigationController?.view.addSubview(segmentController)
        segmentController.anchor(x: navigationController?.view.centerXAnchor, y: navigationController?.view.centerYAnchor, offsetX: 0, offsetY: 0, width: 150, height: 30)
        navigationItem.titleView = segmentController

        
       // self.navigationItem.title = "Tell The Truth"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
    }
    
    
}

extension ViewController {
    // MARK: - Layout ViewController
    
    
    func setUpTableView() {
        view.addSubview(tableViewContainer)
        
        tableViewDownConstant = 0
        tableViewUpConstant = -((view.frame.height/2) - (view.frame.height / 2) * 1/2)
        
        
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        tableViewHeightAnchor = tableViewContainer.heightAnchor.constraint(equalToConstant: view.frame.width * gr)
        tableViewHeightAnchor.isActive = true
  
        tableViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

    }
    
    func setupContainerViewWithController(){
        
        tableViewContainer.addSubview(controller.view)
        
        controller.view.anchor(top: topLayoutGuide.topAnchor, left: tableViewContainer.leftAnchor, bottom: tableViewContainer.bottomAnchor, right: tableViewContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
     

    }
    
    func setupStartButton(){
        view.addSubview(bottomContainer)
       view.addSubview(startButton)
        //as a proprotion of frame
   
        //paddingWidhtxPaddingHeight
        
         bottomContainer.anchor(top: tableViewContainer.bottomAnchor, left: view.leftAnchor, bottom: bottomLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
       startButton.anchor(x: bottomContainer.centerXAnchor, y: bottomContainer.centerYAnchor, offsetX: 0, offsetY: 0, width: paddingWidth, height: 0)
        
       startButtonHeightConstraint = startButton.heightAnchor.constraint(equalToConstant: paddingHeight)
        startButtonHeightConstraint.isActive = true
        
        
     
      
        
        
    }


    
    
    
}


extension ViewController {
    
    // MARK: - Sound
    
    func prepareSound() {
        guard let audioFileUrl = Bundle.main.url(forResource: "ding", withExtension: "mp3") else { return }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
            soundPlayer?.prepareToPlay()
        } catch {
            print("Sound player not available: \(error)")
        }
    }
    
    func playSound() {
        soundPlayer?.play()
    }
    
}

extension ViewController {
    
    // MARK: - Display
    
    func updateDisplay(for timeRemaining: TimeInterval) {
        timeLabel.text = textToDisplay(for: timeRemaining)
        //eggImageView.image = imageToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
    /*
    private func imageToDisplay(for timeRemaining: TimeInterval) -> UIImage? {
        let percentageComplete = 100 - (timeRemaining / prefs.selectedTime * 100)
        
        if timerBrain.isStopped {
            let stoppedImageName = (timeRemaining == 0) ? "100" : "stopped"
            return NSImage(named: stoppedImageName)
        }
        
        let imageName: String
        switch percentageComplete {
        case 0 ..< 25:
            imageName = "0"
        case 25 ..< 50:
            imageName = "25"
        case 50 ..< 75:
            imageName = "50"
        case 75 ..< 100:
            imageName = "75"
        default:
            imageName = "100"
        }
        
        return NSImage(named: imageName)
    }*/
    
    func configureButtonsAndMenus() {
        let enableStart: Bool
        let enableStop: Bool
        let enableReset: Bool
        
        if timerBrain.isStopped {
            enableStart = true
            enableStop = false
            enableReset = false
        } else if timerBrain.isPaused {
            enableStart = true
            enableStop = false
            enableReset = true
        } else {
            enableStart = false
            enableStop = true
            enableReset = false
        }
        
        startButton.isEnabled = enableStart
        stopButton.isEnabled = enableStop
        resetButton.isEnabled = enableReset
        
    }
    
}


