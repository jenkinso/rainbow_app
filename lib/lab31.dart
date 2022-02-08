import 'dart:io';
import 'dart:math';

void main() {
  var keepPlaying = true;

  do {
    guessingGame();

    stdout.write("Would you like to keep playing? Enter y for yes: ");
    var userInput = stdin.readLineSync();

    keepPlaying = userInput == "y" ? true : false;

  } while (keepPlaying);

}

void guessingGame() {
  const maxAnswer = 101;
  var randomGenerator = Random();
  final answer = randomGenerator.nextInt(maxAnswer);

  stdout.writeln("Guessing game! Please guess a number between 0 and ${maxAnswer}.");

  var gameOver = false;

  while (!gameOver) {
    stdout.write("Enter your guess: ");

    var guessString = stdin.readLineSync();
    var guess;

    if (guessString != null) {
      guess = int.tryParse(guessString);
    }

    if (guess == null) {
      stdout.writeln("Your guess was invalid. Please enter a valid number between 0 and ${maxAnswer}.");
      continue;
    }

    if (guess < answer) {
      stdout.writeln("Too low!");
    }
    else if (guess > answer) {
      stdout.writeln("Too high");
    }
    else {
      stdout.writeln("You got it!");
      gameOver = true;
    }
  }

}