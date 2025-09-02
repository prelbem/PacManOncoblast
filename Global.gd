extends Node
const questions = [
	"What's 9 + 10?",
	"What's the square root of 64?",
	"What's the capital of Washington?",
	"What's 1 + 1?",
	"What's 2 * 7?",
	"What makes balloons float?"
]

const trueAnswers = [
	["19", "21"],
	["8"],
	["Olympia"],
	["2", "Window"],
	["14"],
	["Helium"]
]

const falseAnswers = [
	["10", "15"],
	["10", "32"],
	["Seattle", "Washington D.C"],
	["3", "-1"],
	["9", "7", "2"],
	["AIR", "IDK"]
]

var visible_joystick = true
