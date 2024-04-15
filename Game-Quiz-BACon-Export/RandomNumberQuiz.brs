'15/04/24 - RLB - Plugin generate Randon number for Quiz game
'make sure to add the relevant uservariable in BACon before sending plugin message to On-Demand state

'QuizGame - plugin name

Function QuizGame_Initialize(msgPort As Object, userVariables As Object, bsp as Object)

   ' print "QuizGame_Initialize - entry"
   ' print "type of msgPort is ";type(msgPort)
    'print "type of userVariables is ";type(userVariables)

    QuizGame = newQuizGame(msgPort, userVariables, bsp)
	
    return QuizGame
End Function



Function newQuizGame(msgPort As Object, userVariables As Object, bsp as Object)
	
	print "initQuizGame Plugin"

	' Create the object to return and set it up
	
	s = {}
	s.msgPort = msgPort
	s.userVariables = userVariables
	s.bsp = bsp
	s.ProcessEvent = QuizGame_ProcessEvent
	s.PluginSendMessage = PluginSendMessage
	s.PluginSendZonemessage = PluginSendZonemessage
	s.sTime = createObject("roSystemTime")		
	s.HandleTimerEventPlugin = HandleTimerEventPlugin
	s.HandlePluginUDPEvent = HandlePluginUDPEvent
	s.GenerateUniqueRandomNumbers = GenerateUniqueRandomNumbers
	s.GenerateAllSessionSets = GenerateAllSessionSets
	s.HandlePluginMessageEvent = HandlePluginMessageEvent
	s.StartIndexedSequenceTimer = StartIndexedSequenceTimer
	s.maxValue = 20 ' Maximum value for random number generation
	s.usedNumbers = {} ' Initialize an associative array to track used numbers
	s.SessionSets = []
	s.HandleStreamEventPlugin = HandleStreamEventPlugin
	s.FirstQuestion = FirstQuestion
	s.BacktoLoop = BacktoLoop
	s.TempScore% = 0
	s.PreviousID = ""

	s.AnswerSensor1 = "X001A[3]"
	s.AnswerSensor2 = "X001A[17]"
	s.AnswerSensor3 = "X008A[3]"
	s.AnswerSensor4 = "X008A[17]"
	s.StartGameSensor = "X003A[1]"
	s.FirstQuestionTransitionTimeout = 2000 'transition time (ms) for reading the rules before transitioning to game start
	s.BackToLoopTimeout = 10000 'transition time (ms) for going back to attract loop

	s.QuestionsChoices = [
		{question: "1", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "2", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "3", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "4", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "5", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "6", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "7", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "8", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "9", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "10", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "11", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "12", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "13", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "14", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "15", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "16", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "17", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "18", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "19", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		{question: "20", answers:[{cmd: s.AnswerSensor1, answer:1}]}
		]

	s.PluginSystemLog = CreateObject("roSystemLog")
	s.PluginSystemLog.SendLine(" @@@ Plugin Version 1.0 for handling serial Data For Quiz Game @@@ ")

	s.GenerateAllSessionSets()

	' s.FunctionSequenceOrderAr = [["CheckData",2000]]
	' s.FunctionListIndex = 0
	' s.StartIndexedSequenceTimer(s.FunctionSequenceOrderAr[s.FunctionListIndex][0], s.FunctionSequenceOrderAr[s.FunctionListIndex][1])

	return s
End Function


	
Function QuizGame_ProcessEvent(event As Object) as boolean

	retval = false
    'print "QuizGame_ProcessEvent - entry"
   ' print "type of m is ";type(m)
   ' print "type of event is ";type(event)

	if type(event) = "roControlDown" then
			
		'retval = HandlePluginGPIOEvent(event, m)
	
	else if type(event) = "roAssociativeArray" then
		
		if type(event["EventType"]) = "roString"
			' print ""
			' print " @@@ EventType @@@ "; event["EventType"]
			' print ""
			if event["EventType"] = "EVENT_PLUGIN_MESSAGE" then
				if event["PluginName"] = "QuizGame" then
					pluginMessage$ = event["PluginMessage"]	
					'retval = HandlePluginMessageEvent(pluginMessage$)
				end if
			
			else if event["EventType"] = "SEND_PLUGIN_MESSAGE" then
			
				if event["PluginName"] = "QuizGame" then
					pluginMessage$ = event["PluginMessage"]
					m.HandlePluginMessageEvent(pluginMessage$)
				end if
				
			else if event["EventType"] = "USER_VARIABLES_UPDATED" then
				'stop
			else if event["EventType"] = "USER_VARIABLE_CHANGE" then

			end if
		end if
	else if type(event) = "roDatagramEvent" then
	
		retval = HandlePluginUDPEvent(event, m)
	else if type(event) = "roTimerEvent" then
	
		retval = HandleTimerEventPlugin(event, m)	
	else if type(event) = "roVideoEvent" then
	
		'retval = HandlePluginVideoEvent(event, m)
	else if type(event) = "roAssetFetcherEvent" then
	
		'retval = HandlePluginroAssetFetcherEvent(event, m)
	else if type(event) = "roHtmlWidgetEvent" then
	
		'retval = HandleHtmlWidgetEventPlugin(event, m)
	else if type(event) = "roStreamByteEvent" then

		'retval = HandleStreamByteEventPlugin(event, m)	
	else if type(event) = "roStreamLineEvent" then	

		retval = HandleStreamEventPlugin(event, m)
	end if
	
	return retval
End Function
	


Function HandlePluginUDPEvent(origMsg as Object, m as Object) as boolean

	print "UDP Message Received in plugin - "; origMsg
End Function



Function HandleTimerEventPlugin(origMsg as Object, m as Object) as boolean

	timerIdentity = origMsg.GetSourceIdentity()
			
	if type(m.IndexedSequenceTimer) = "roTimer" then
		
		if m.IndexedSequenceTimer.GetIdentity() = origMsg.GetSourceIdentity() then

			userData = origMsg.GetUserData()
			'print "FunctionName: "; userData.FunctionName
			'print "TimeoutVal: ";  userData.TimeoutVal
			FunctionName = userData.FunctionName

			if FunctionName = "FirstQuestion" then
				m.FirstQuestion()			  
			end if  

			if FunctionName = "BacktoLoop" then
				m.BacktoLoop()			  
			end if  

			if m.FunctionListIndex < m.FunctionSequenceOrderAr.count() - 1 then
				m.FunctionListIndex = m.FunctionListIndex + 1
				m.StartIndexedSequenceTimer(m.FunctionSequenceOrderAr[m.FunctionListIndex][0], m.FunctionSequenceOrderAr[m.FunctionListIndex][1])
			end if 
			
			return true
		end if
	end if
End Function
	


Function HandlePluginMessageEvent(origMsg as string)

	print ""
	print " @@@ HandlePluginMessageEvent: "; origMsg
	print ""

	if origMsg = "GenNum" then
		'm.GenerateAllSessionSets()
	end if 	
End Function



Function PluginSendMessage(Pmessage$ As String)

	pluginMessageCmd = CreateObject("roAssociativeArray")
	pluginMessageCmd["EventType"] = "EVENT_PLUGIN_MESSAGE"
	pluginMessageCmd["PluginName"] = "QuizGame"
	pluginMessageCmd["PluginMessage"] = Pmessage$
	m.msgPort.PostMessage(pluginMessageCmd)
End Function


Sub PluginSendZonemessage(msg$ as String)
	' send ZoneMessage message
	zoneMessageCmd = CreateObject("roAssociativeArray")
	zoneMessageCmd["EventType"] = "SEND_ZONE_MESSAGE"
	zoneMessageCmd["EventParameter"] = msg$
	m.msgPort.PostMessage(zoneMessageCmd)
End Sub



Function HandleStreamEventPlugin(origMsg as Object, m as object) as boolean

	print " HandleStreamEventPlugin "; origMsg

	retval = false

	if origMsg = m.StartGameSensor then

		m.FunctionSequenceOrderAr = [["FirstQuestion",m.FirstQuestionTransitionTimeout]]
		m.FunctionListIndex = 0
		m.StartIndexedSequenceTimer(m.FunctionSequenceOrderAr[m.FunctionListIndex][0], m.FunctionSequenceOrderAr[m.FunctionListIndex][1])
	end if	

	if m.bsp.sign.zoneshsm[0].activestate.name$ = "Questions" then
		if origMsg = m.AnswerSensor1 or origMsg = m.AnswerSensor2 or origMsg = m.AnswerSensor3 or origMsg = m.AnswerSensor4 then	  

			question_index = (val(m.PreviousID)-1)
			answersIndex = 0
			'using an array here in case that requirement changes to something more complex...
			for each answer in m.QuestionsChoices[question_index].answers
				if origMsg = m.QuestionsChoices[question_index].answers[answersIndex].cmd AND m.QuestionsChoices[question_index].answers[answersIndex].answer = 1 then
					m.TempScore% = m.TempScore% + 1
					m.PluginSystemLog.sendline(" @@@ Good answer!: " + stri(m.TempScore%))
				else 
					m.PluginSystemLog.sendline(" @@@ Wrong answer!: " + stri(m.TempScore%))	
				end if 	
				answersIndex = answersIndex + 1
			next 	
		
			if m.SessionSets[0].count() = 0  or m.SessionSets[0].count() = invalid then

				score = StripLeadingSpaces(stri(m.TempScore%)) 

				if m.bsp.currentuservariables.Score <> invalid then
					m.bsp.currentuservariables.Score.setcurrentvalue(score, true)
					m.PluginSystemLog.sendline(" @@@ User Variable set for final score: " + score)
				end if
			
				m.PluginSendMessage(score)

				m.FunctionSequenceOrderAr = [["BacktoLoop",10000]]
				m.FunctionListIndex = 0
				m.StartIndexedSequenceTimer(m.FunctionSequenceOrderAr[m.FunctionListIndex][0], m.FunctionSequenceOrderAr[m.FunctionListIndex][1])
			else 
				NextQuestion = "Question" + StripLeadingSpaces(stri(m.SessionSets[0][0])) 
	
				if m.bsp.currentuservariables.Question <> invalid then
					m.bsp.currentuservariables.Question.setcurrentvalue(NextQuestion, true)
					m.PluginSystemLog.sendline(" @@@ User Variable set for NextQuestion " + NextQuestion)
				end if
			
				m.PluginSendMessage(NextQuestion)
			
				m.PreviousID = StripLeadingSpaces(stri(m.SessionSets[0][0])) 
				m.SessionSets[0].shift()
			end if	
		end if	
	end if	
    
	return retval
End Function



function GenerateUniqueRandomNumbers(count as Integer, maxValue as Integer) as Object
    randomNumbers = []

    ' Ensure the count does not exceed the maxValue to avoid an infinite loop
    if count > maxValue then return []

    while randomNumbers.count() < count
     ' Generate a random number within the range
        randomNumber = Rnd(maxValue)
        
        ' Check if the number has already been used
        if m.usedNumbers.Lookup(randomNumber.toStr()) = invalid then
            m.usedNumbers[randomNumber.toStr()] = true ' Mark this number as used
            randomNumbers.push(randomNumber) ' Add the unique number to the array
        end if
    end while
    
    return randomNumbers
end function



Function GenerateAllSessionSets()

	'm.maxValue = 20 ' Maximum value for random number generation
	m.usedNumbers = {} ' Initialize an associative array to track used numbers
	m.SessionSets = []

	numbersSet1 = m.GenerateUniqueRandomNumbers(5, m.maxValue)
	print ""
	print " Set 1: " 
	print numbersSet1

	m.SessionSets.push(numbersSet1)

	numbersSet1$ = ""
	numbersSet1% = 0

	for each entry in numbersSet1
		numbersSet1$ = numbersSet1$ + " " + stri(numbersSet1[numbersSet1%])
		numbersSet1% = numbersSet1% + 1
	next

	m.PluginSystemLog.SendLine(" @@@ Question Set1: " + numbersSet1$)

	numbersSet2 = m.GenerateUniqueRandomNumbers(5, m.maxValue)
	print ""
	print "Set 2: " 
	print numbersSet2

	m.SessionSets.push(numbersSet2)

	numbersSet2$ = ""
	numbersSet2% = 0

	for each entry in numbersSet2
		numbersSet2$ = numbersSet2$ + " " + stri(numbersSet2[numbersSet2%])
		numbersSet2% = numbersSet2% + 1
	next

	m.PluginSystemLog.SendLine(" @@@ Question Set2: " + numbersSet2$)

	numbersSet3 = m.GenerateUniqueRandomNumbers(5, m.maxValue)
	print ""
	print "Set 3: " 
	print numbersSet3

	m.SessionSets.push(numbersSet3)

	numbersSet3$ = ""
	numbersSet3% = 0

	for each entry in numbersSet3
		numbersSet3$ = numbersSet3$ + " " + stri(numbersSet3[numbersSet3%])
		numbersSet3% = numbersSet3% + 1
	next

	m.PluginSystemLog.SendLine(" @@@ Question Set3: " + numbersSet3$)

	numbersSet4 = m.GenerateUniqueRandomNumbers(5, m.maxValue)
	print ""
	print "Set 4: " 
	print numbersSet4

	m.SessionSets.push(numbersSet4)

	numbersSet4$ = ""
	numbersSet4% = 0

	for each entry in numbersSet4
		numbersSet4$ = numbersSet4$ + " " + stri(numbersSet4[numbersSet4%])
		numbersSet4% = numbersSet4% + 1
	next

	m.PluginSystemLog.SendLine(" @@@ Question Set4: " + numbersSet4$)
End Function	



Function StartIndexedSequenceTimer(FunctionName as String, TimeoutVal as integer)
    userdata = {}
    userdata.FunctionName = FunctionName
    userdata.TimeoutVal = TimeoutVal

    newTimeout = m.sTime.GetLocalDateTime()
    newTimeout.AddMilliseconds(TimeoutVal)
    m.IndexedSequenceTimer = CreateObject("roTimer")
    m.IndexedSequenceTimer.SetPort(m.msgPort)	
    m.IndexedSequenceTimer.SetDateTime(newTimeout)
    m.IndexedSequenceTimer.SetUserData(userdata)	
    ok = m.IndexedSequenceTimer.Start()
End Function



Function BacktoLoop()

	m.SessionSets.shift()
	m.PluginSendMessage("BacktoLoop")

	print ""
	print " Final Score: "; m.TempScore% 
	print ""
	m.TempScore% = 0
	if m.SessionSets.count() = 0 then
		m.GenerateAllSessionSets()
	end if 	
End Function



Function FirstQuestion()

	NextQuestion = "Question" + StripLeadingSpaces(stri(m.SessionSets[0][0])) 

	if m.bsp.currentuservariables.Question <> invalid then
		m.bsp.currentuservariables.Question.setcurrentvalue(NextQuestion, true)
		m.PluginSystemLog.sendline(" @@@ User Variable set via plugin " + NextQuestion)
	end if

	m.PluginSendMessage(NextQuestion)

	m.PreviousID = StripLeadingSpaces(stri(m.SessionSets[0][0])) 
	m.SessionSets[0].shift()
End Function