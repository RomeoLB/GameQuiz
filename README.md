**How to use get and use this package?**

Click on "Code" and select "Download Zip"

<img width="868" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/cb0b1645-fcea-4add-96c9-8b27aa0eb3ea">


**Game Quiz - What is the purpose of this Presentation/plugin?**

This presentation/plugin was created to allow the use of a Nexmosphere controller to interact with the Brightsign player using serial commands to take part in a Game Quiz.

In the plugin, s.maxValue = 20 is used to specify that 20 questions will be used to generate 4 sets of random questions for each game. The 20 questions from each game will only be used once until 4 new sets of 5 random questions are re-generated. Each game will include 5 questions. After all, 5 questions have been answered an image will be displayed with the game score.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/2a19987b-ba67-4091-9c18-b208a523405e">


In the plugin, you will need to specify the serial commands that will allow to select answer 1-4 in the Game Quiz (s.AnswerSensor1, s.AnswerSensor2, s.AnswerSensor3 and s.AnswerSensor4). You will need to ensure that you replace the current values with the relevant serial values for your specific Nexmosphere setup.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/4c7745c6-e5b4-4e94-9461-3b2d67ffb2b4">


s.StartGameSensor = "X003A[1]", is used to transition from the attract loop to the state that explains the Game rules. This value should adjusted in the plugin and

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/a4eac961-ace6-466d-aa24-e18bfec71cf0">


In the BACon presentation

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/3a6ccad6-b708-43da-903f-0fd56d179fe1">


s.FirstQuestionTransitionTimeout = 2000 is used is specify the timeout for displaying the game's rules and the transition to the first question should be.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/2eac445b-1f1a-4323-a313-2ef04a4841fd">


In Bacon, the transition event is a "Plugin Message" event that allow transitioning from "GameRules.png" to the "Questions" state.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/45ae2ef9-146a-4fc3-ba60-fef4bc6f8ccc">


s.BackToLoopTimeout = 10000 is used to specify the timeout transition to display the game results before returning to the AttractLoop.mp4 video state

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/0120882d-4ed8-4a52-8ce6-5aa6fa14da08">

In the BACon presentation:

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/888e0e24-06e4-471b-a617-16db50be70e8">


The array s.QuestionsChoices allows to specify and match the question number and the sensor trigger that corresponds to the right answer.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/77df6c54-c71f-42a9-b336-ed625f2a758a">


You can adjust the s.AnswerSensor1 listed in that array to another sensor like s.AnswerSensor2, s.AnswerSensor3 or s.AnswerSensor4. Currently s.AnswerSensor1 is the correct answer for all 20 questions in the quiz. Each question answered correctly is equal to 1 point ("answer:1").

The On Demand "Questions" state should include a file for each question. For example, the "Key" for loading the "Question1.png" file should be "Question1" for loading "Question2.png" the key should be "Question2" etc.

<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/afc1327b-5f1d-4ff3-b411-513b0a780640">

The On-Demand "Results" state should contain the images to be displayed at the end of the game that shows the game score. The "Key" for loading the files in that state should be 0, 1,2, 3, 4, or 5.


<img width="452" alt="image" src="https://github.com/RomeoLB/GameQuiz/assets/136584791/af3c52d5-3569-45ff-9c03-2f2b8ded44a6">


In summary, this Presentation/plugin allows to do the following:

1.  Play an attract loop until the serial command "X003A[1]" is triggered by the Nexmosphre controller. The serial command "X003A[1]" will need to be changed in the BACon interactive playlist and in the plugin.

2.  Display the game's rules for 2 seconds (this time value can be changed in the plugin - s.FirstQuestionTransitionTimeout = 2000)

3.  Display 5 random questions out of 20 and ensures that the same question is never displayed in the next game and until 4 new sets of 5 random questions are re-generated.

4.  Process the serial commands generated from the Nexmosphere controller to assess if the selected answers via the specific Nexmosphere sensor is correct for all 5 questions, in the current game.

5.  Display the current game score for 10 seconds before returning to the AttractLoop. This timeout can be adjusted in the plugin (s.BackToLoopTimeout = 10000)

