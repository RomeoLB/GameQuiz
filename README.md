

**Game Quiz - What is the purpose of this Presentation/plugin**

This presentation/plugin was created to allow the use of a Nexmosphere controller to interact with the Brightsign player using serial commands to take part in a Game Quiz.

In the plugin, s.maxValue = 20 is used to specify that 20 questions will be used to generate 4 sets of random questions for each game. The 20 questions from each game will only be used once until 4 new sets of 5 random questions are re-generated. Each game will include 5 questions. After all, 5 questions have been answered an image will be displayed with the game score.

![](adb9824cbfb27a7125190b966630aa48.png)

In the plugin, you will need to specify the serial commands that will allow to select answer 1-4 in the Game Quiz (s.AnswerSensor1, s.AnswerSensor2, s.AnswerSensor3 and s.AnswerSensor4). You will need to ensure that you replace the current values with the relevant serial values for your specific Nexmosphere setup.

![](6f02bf2a7bef54e299420501650b7e81.png)

s.StartGameSensor = "X003A[1]", is used to transition from the attract loop to the state that explains the Game rules. This value should adjusted in the plugin and

![A screen shot of a computer Description automatically generated](f2bd9c5b8d701d99e38ff584b494c370.png)

In the BACon presentation

![A screenshot of a presentation Description automatically generated](a4c1fd244695c5edebded7b3008ec6e0.png)

s.FirstQuestionTransitionTimeout = 2000 is used is specify the timeout for displaying the game’s rules and the transition to the first question should be.

![A black screen with red text Description automatically generated](7a4b99b5cff77efc0e999d9ded4ed44a.png)

In Bacon, the transition event is a “Plugin Message” event that allow transitioning from “GameRules.png” to the “Questions” state.

![A screenshot of a computer Description automatically generated](4e3c1ffd8eaa714b8c8d352ba7919e7a.png)

s.BackToLoopTimeout = 10000 is used to specify the timeout transition to display the game results before returning to the AttractLoop.mp4 video state

![](4b5dbccfaeab4c6afc9ed00ad7a7cf41.png)

![A screenshot of a computer Description automatically generated](88400701b8c1779e665c20a36b662197.png)

The array s.QuestionsChoices allows to specify and match the question number and the sensor trigger that corresponds to the right answer.

![A screen shot of a computer code Description automatically generated](a104f96182448e7091b444c4dc706d6c.png)

You can adjust the s.AnswerSensor1 listed in that array to another sensor like s.AnswerSensor2, s.AnswerSensor3 or s.AnswerSensor4. Currently s.AnswerSensor1 is the correct answer for all 20 questions in the quiz. Each question answered correctly is equal to 1 point (“answer:1”).

The On Demand “Questions” state should include a file for each question. For example, the “Key” for loading the “Question1.png” file should be “Question1” for loading “Question2.png” the key should be “Question2” etc.

![A screenshot of a computer Description automatically generated](9efb92ae791a7b84e70bf6537c700bdc.png)

The On-Demand “Results” state should contain the images to be displayed at the end of the game that shows the game score. The “Key” for loading the files in that state should be 0, 1,2, 3, 4, or 5.

![A screenshot of a computer Description automatically generated](e9613e16e44addbaaf8ddb2a159cfe83.png)

In summary, this Presentation/plugin allows to do the following:

1.  Play an attract loop until the serial command “X003A[1]” is triggered by the Nexmosphre controller. The serial command “X003A[1]” will need to be changed in the BACon interactive playlist and in the plugin.

2.  Display the Game’s rules for 2 seconds (this time value can be changed in the plugin - s.FirstQuestionTransitionTimeout = 2000)

3.  Display 5 random questions out of 20 and ensures that the same question is never displayed in the next game and until 4 new sets of 5 random questions are re-generated.

4.  Process the serial commands generated from the Nexmosphere controller to assess if the selected answers via the specific Nexmosphere sensor is correct for all 5 questions, in the current game.

5.  Display the current game score for 10 seconds before returning to the AttractLoop. This timeout can be adjusted in the plugin (s.BackToLoopTimeout = 10000)

