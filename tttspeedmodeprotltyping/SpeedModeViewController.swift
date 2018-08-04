//
//  ViewController.swift
//  tttspeedmodeprotltyping
//
//  Created by Johnny on 4/19/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import UIKit

class SpeedModeViewController: UIViewController {
	@IBOutlet var SpeedInterFace: SpeedModeView!
	
	var speedModeInstance = speedMode()


	lazy var buttonToPosition:[UIButton:Int] = [SpeedInterFace.button1:0,SpeedInterFace.button2:1,SpeedInterFace.button3:2,
												SpeedInterFace.button4:3,SpeedInterFace.button5:4,SpeedInterFace.button6:5,
												SpeedInterFace.button7:6,SpeedInterFace.button8:7,SpeedInterFace.button9:8]

	lazy var positionToButton:[Int:UIButton] = [ 0:SpeedInterFace.button1,1:SpeedInterFace.button2,2:SpeedInterFace.button3,
												 3:SpeedInterFace.button4,4:SpeedInterFace.button5,5:SpeedInterFace.button6,
												 6:SpeedInterFace.button7,7:SpeedInterFace.button8,8:SpeedInterFace.button9]


	
	var countDown : Timer?

	func countDownTimer(){
		countDown = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(tip), userInfo: nil, repeats: false)
	}

	@objc func tip(){
		print("timer fired")
		SpeedInterFace.Rse.setTitle("o", for: .normal)
	}


	var humanMadeMoves = 0{
		didSet{
			print("did set called")
			if countDown != nil {
				countDown?.invalidate()
				print("invalidated a  timee")
			}
				countDownTimer()
				print("ut called")


		}
	}




	@IBAction func Move(_ sender: UIButton) {
		if speedModeInstance.isGameFinshed() == false{
			if sender.currentTitle == nil{
				sender.setTitle("O", for: .normal)
				self.humanSetPosition(sender)
				humanMadeMoves += 1



				DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.01){
				if self.speedModeInstance.isGameFinshed() == false{
					let positionNumberInarray =	self.speedModeInstance.findTheBestMoveForComputer()
					self.setButtonSymbol(positionNumberInarray)
					self.computerSetPosition(positionNumberInarray)


					}
				}

			}
		}
		if speedModeInstance.isGameFinshed(){
			if speedModeInstance.hasMovesleft() == false{
				SpeedInterFace.Rse.setTitle("it's a tie", for: .normal)
			}else{
				SpeedInterFace.Rse.setTitle("you lose", for: .normal)
			}

		}




	}

	func humanSetPosition(_ button:UIButton){
		let positionInt = buttonToPosition[button]
		speedModeInstance.positionArray[positionInt!] = -1

	}
	func computerSetPosition(_ positionNumber: Int){
		speedModeInstance.positionArray[positionNumber] = 1

	}

	func setButtonSymbol(_ positionNumber:Int){
		let buttonPosition = positionToButton[positionNumber]
		buttonPosition?.setTitle("X", for: .normal)
		speedModeInstance.positionArray[positionNumber] = 1

	}

	@IBAction func restartGame(_ sender: UIButton) {
		speedModeInstance.clearBroad()
		speedModeInstance.setAllButtonTittleToNil(dic:positionToButton)
		SpeedInterFace.Rse.setTitle(nil, for: .normal)
		humanMadeMoves = 0

	}






	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

