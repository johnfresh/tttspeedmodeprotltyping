//
//  SpeedModeModel.swift
//  tttspeedmodeprotltyping
//
//  Created by Johnny on 4/19/18.
//  Copyright © 2018 Johnny. All rights reserved.
//

import Foundation
import UIKit

struct speedMode {

	var positionArray = [0,0,0,
						 0,0,0,
						 0,0,0]
/*
	var Button1,Button2,Button3,Button4,Button5,Button6,Button7,Button8,Button9 : UIButton
	lazy var matchingDic: [UIButton:Int] = [	Button1:0 , Button2:1, Button3:2,
												Button4:3, Button5:4, Button6:5,
												Button7:6, Button8:7, Button9:8]

	lazy var reMatchingDic: [Int:UIButton] = [	  0 :Button1, 1:Button2, 2:Button3,
													3 :Button4, 4:Button5, 5:Button6,
													6 :Button7, 7:Button8, 8:Button9]

*/



	mutating func clearBroad(){
		for i in 0...8 {
			positionArray[i] = 0
		}
	}

	func hasMovesleft()-> Bool{
		for i in 0...8{
			if (positionArray[i] == 0){
				return true
			}
		}
		return false
	}

	func isThereWinner()->Bool{
		if evaluate() == 0{
			return false
		}
		return true
	}

	func isGameFinshed()->Bool{
		if(hasMovesleft() == false || evaluate() != 0){
			return true
		}
		return false
	}

// Computer Player is 1   Human Player is -1
	func evaluate() -> Int{
		if(positionArray[0] != 0 && positionArray[0]==positionArray[1] && positionArray[1]==positionArray[2]){return positionArray[0]}
		if(positionArray[3] != 0 && positionArray[3]==positionArray[4] && positionArray[4]==positionArray[5]){return positionArray[3]}
		if(positionArray[6] != 0 && positionArray[6]==positionArray[7] && positionArray[7]==positionArray[8]){return positionArray[6]}
		if(positionArray[0] != 0 && positionArray[0]==positionArray[3] && positionArray[3]==positionArray[6]){return positionArray[0]}
		if(positionArray[1] != 0 && positionArray[1]==positionArray[4] && positionArray[4]==positionArray[7]){return positionArray[1]}
		if(positionArray[2] != 0 && positionArray[2]==positionArray[5] && positionArray[5]==positionArray[8]){return positionArray[2]}
		if(positionArray[0] != 0 && positionArray[0]==positionArray[4] && positionArray[4]==positionArray[8]){return positionArray[0]}
		if(positionArray[2] != 0 && positionArray[2]==positionArray[4] && positionArray[4]==positionArray[6]){return positionArray[2]}
		return 0
	}



// positionArray 0 to 8 is the position of each block，  1 stand for computer ，-1 stand for human, when each line of 3 position is the same, the line player is the winner


	var myTurn : Bool?

/*	mutating func play(_ sender: UIButton){
		if(isGameFinshed() == false){
			if(positionArray[matchingDic[sender]!] == 0){
				sender.setTitle("X", for: .normal)
				positionArray[matchingDic[sender]!] = -1


			}

		}

	}
*/


	mutating func findTheBestMoveForComputer()->Int{
		var thePositionNumberInPositionArray: Int?
		var bestValue = -2
		var MinimaxReturnedValue :Int?
		for i in 0...8{
			if positionArray[i] == 0{
				positionArray[i] = 1
				MinimaxReturnedValue = miniMax(false)
				if MinimaxReturnedValue! >= bestValue{
					bestValue = MinimaxReturnedValue!
					thePositionNumberInPositionArray = i
				}																// wrost case is lossing which is -1, it's always big the -2,  because lose the game is better than computer doesn't move
				positionArray[i] = 0
			}
		}
		return thePositionNumberInPositionArray!
	}


	mutating func miniMax(_ myMove: Bool)->Int{
		
		if isThereWinner(){
			return evaluate()
		}
		if hasMovesleft() == false{
			return 0
		}

		var miniMaxWinningValue : Int?
		if myMove {
			var bestValue = -2
			for i in 0...8 {
				if	positionArray[i] == 0{
					positionArray[i] = 1
					let newValue = miniMax(false)
					if newValue >= bestValue{
						bestValue = newValue
					}
					positionArray[i] = 0
				}
				miniMaxWinningValue = bestValue
			}
		}else{
			var bestValue = 2
			for i in 0...8 {
				if	positionArray[i] == 0{
					positionArray[i] = -1
					let newValue = miniMax(true)
					if newValue <= bestValue{
						bestValue = newValue
					}
					positionArray[i] = 0
				}
				miniMaxWinningValue = bestValue
			}
		}
		return miniMaxWinningValue!

	}

	func setAllButtonTittleToNil(dic:[Int:UIButton]){
		for i in 0...8{
			dic[i]?.setTitle(nil, for: .normal)
		}
	}
}





