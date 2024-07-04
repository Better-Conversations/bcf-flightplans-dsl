#import "styles.typ": flight-plan, flight-plan-table, info-table
#import "helpers.typ": *
#import "@preview/cmarker:0.1.0"

#show: flight-plan

= Module 3: Context

== Overview

#info-table(
  date: "19 June 2024",
  time: "0900 UTC",
  duration: 90,
  organisation: "Better Conversations",
)

BOR = breakout rooms, Fx = facilitator, Px = producer

#bcf-nom[Yellow highlighted text] indicates where names, contact details, examples, timings etc. might need to be changed

#bcf-mod[Green highlighted text] indicates modifications to the live/master version for the session

#bcf-atten[Bold text] in time plan draws attention to facilitator script

#bcf-cue[Bold highlighted text] helps provide cues for producer to paste chat text

#pagebreak()

= Flight Plan

== Learning Outcomes

#cmarker.render("")

== Flipcharts

#[
  // Bold titles.
  #show table.cell.where(y: 0): set text(weight: "bold")

  #table(
    columns: (auto, auto, 1fr),
    rows: 4,
    align: (x, y) => if y > 0 and x == 2 {
      left
    } else {
      center
    },
    [Reference], [Who is scribing?], [Contents],
    [#("Flip#1")], [Fx1], [Use to explain the model],
    [#("Flip#2")], [Fx1], [Context diagram (as on handbook)],
    [#("Flip#3")], [Fx2], [Learnings on context],
    [#("Flip#4")], [Fx2], [Learnings on context],
  )
]

== Demo

#cmarker.render("")

#pagebreak()

== Time Plan

#flight-plan-table(





  [-30],
  [25],
  [Pre-Flight checklist#linebreak()#bcf-nom[]#linebreak()#linebreak()],
  [],
  [#instruction(
      cmarker.render("Sponsor and producer run through the pre-flight checklist (above)"),
    )],





  speaker-swap[Fx1 and Fx2],



  [-5],
  [5],
  [Greeting#linebreak()#bcf-nom[Fx1 and Fx2]#linebreak()#linebreak()],
  [#instruction(
      cmarker.render("Greet people as they join – this is a chance to check their audio/video"),
    )],
  [#instruction(
      cmarker.render("Setup template Breakout Room for first breakout"),
    )],





  speaker-swap[Switch to Fx1],



  [00],
  [2],
  [Welcome#linebreak()#bcf-nom[Fx1]#linebreak()flip_1 Flip#1 for agenda#linebreak()],
  [#instruction(
      cmarker.render("Welcome people and introduce facilitator(s), producer and any observers and briefly explain their roles."),
    )

    #spoken(
      cmarker.render("Last time we looked at how quickly and easily we make assumptions, without being aware of them. We will do a quick review of that soon."),
      cmarker.render("Then we will begin to explore the context around a conversation. **Context helps us make meaning of the world, and determines what assumptions we make.**"),
    )

    #instruction(cmarker.render("Go through agenda on flip"))],
  [],





  [02],
  [2],
  [Any Questions#linebreak()#bcf-nom[Fx1]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("And is there anything you need to tell us before we begin? For example, if you need to leave early or if you are having any problems with Zoom."),
      cmarker.render("**And do you have anything you’d like to ask us about today’s topic?**"),
    )

    #instruction(
      cmarker.render("Respond to any questions/insights but keep it brief."),
    )

    #instruction(cmarker.render("Handover to Fx2 for state check-in."))],
  [],





  speaker-swap[Switch to Fx2],



  [04],
  [2],
  [State Check-In#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("Now, let’s check-in with your state using the Traffic Light Model"),
      bcf-cue(
        cmarker.render("Please put in the chat if you are green, amber/yellow or red"),
      ),
      bcf-cue(
        cmarker.render("Green – you’re good to go!
Amber/Yellow – you need to proceed with caution
Red – you need to stop, break
"),
      ),
    )

    #instruction(
      cmarker.render("Accept whatever states are put in chat. Avoid saying that green state is best. If people are in red then ask them to take the time they need, switch their camera off and mute, and join when they are ready."),
    )],
  [#chat(
      cmarker.render("State check-in:

Green – you’re good to go!
Amber/Yellow – you need to proceed with caution
Red – you need to stop, break
"),
    )

    #instruction(
      cmarker.render("Take note of states to help decide BOR participants"),
    )],





  [06],
  [4],
  [Fieldwork reflections#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("Let’s have a quick recap of the fieldwork. Please share only what you’d like to and put your answers in the chat, so we hear from everyone quickly."),
      bcf-cue(
        cmarker.render("Think of one conversation you had recently – maybe it was a good conversation, maybe it wasn't"),
      ),
      bcf-cue(
        cmarker.render("Were your assumptions in that conversation accurate?"),
      ),
      bcf-cue(cmarker.render("Just quickly put yes or no in the chat")),
    )

    #instruction(
      cmarker.render("If time permits, facilitator asks one person who answers “No” and one person who answers “Yes”:"),
    )

    #spoken(
      cmarker.render("Without adding too much detail, when your assumption was/wasn't accurate, then what happened?"),
    )

    #instruction(cmarker.render("Handover to Fx1 for Context model."))],
  [#chat(
      cmarker.render("Think of one conversation you had recently – maybe it was a good conversation, maybe it wasn't.

- Were your assumptions in that conversation accurate?
- Please answer Yes or No in the chat.
"),
    )],





  speaker-swap[Switch to Fx1],



  [10],
  [7],
  [Context model#linebreak()#bcf-nom[Fx1]#linebreak()flip_2 use to explain the model#linebreak()],
  [#spoken(
      cmarker.render("There is an explanation in the handbook in Section 3 to help you remember the diagram."),
      cmarker.render("In Better Conversations, context means what surrounds the conversation, the setting for the conversation."),
      cmarker.render("Context is important because it defines our subjective experience."),
      cmarker.render("It helps us make meaning of our world. Each of us brings our own context to conversations. And we take it into our future conversations, so our context can change over time."),
      cmarker.render("Context also determines what assumptions we make. We can make different assumptions in different contexts."),
      cmarker.render("As an example, imagine you were in London and you saw people carrying umbrellas. You might think it was going to rain."),
      cmarker.render("Now imagine you are in a country in South Asia. If you saw people carrying umbrellas, they might be wanting to use them as parasols. If it was monsoon season, you might think the umbrella has a dual use."),
      cmarker.render("We have broken context down into 6 overlapping areas to help explain what it is."),
      cmarker.render("Context can be:
- #underline[Psychological] (for example, your perception of your state, your personal values)
- #underline[Social] (for example, relationships and group behaviour)
- #underline[Cultural] (for example, cultural values and beliefs)
- #underline[Historical] (for example, what’s happened in the past, what’s documented or recorded)
- #underline[Environmental] (for example, what’s going in the physical space you are in)
- #underline[Time]-based (for example, temporal - time zone, whether it’s day or night)
"),
      cmarker.render("Some examples of your context we have already covered so far in this course are:
- Asking where in the world you are and what time zone you are in (environmental, cultural and time-based context)
- Asking how you are feeling, when we do the state check-in (psychological context)
"),
      cmarker.render("We look at psychological, time-based, historical, environmental context in this course."),
      cmarker.render("We aren’t covering social or cultural context in this course in depth – these are beyond the scope of what we are doing here."),
      cmarker.render("What we are going to do now is put you in breakout rooms to find out more about  the impact of knowing someone’s context."),
    )

    #instruction(cmarker.render("Handover to Fx2 for context exercise."))],
  [#instruction(
      cmarker.render("Prepare BORs in 2/3s for **6 minutes** if not already done"),
    )],





  speaker-swap[Switch to Fx2],



  [17],
  [8],
  [Breakout#1#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("You will have 6 minutes to do this exercise in breakout rooms."),
      cmarker.render("We are going to explore what happens when we share our context."),
      cmarker.render("Please only ask what is appropriate for this setting and share only what you feel comfortable sharing in the group when we come back into the main room."),
      bcf-cue(
        cmarker.render("One person will choose ONE of the starter questions below to ask your partner. Continue the conversation and ask more questions to improve your understanding of the other person’s context."),
      ),
      bcf-cue(
        cmarker.render("Starter questions:
-	Psychological: What would you like to have happen after attending this course?
-	Historical: What have you learned so far on this course?
-	Time: What were you doing before you came to the course today? What else do you have on today?
-	Environmental: Where are you in the world?
"),
      ),
      bcf-cue(
        cmarker.render("Manage the time so everyone gets a chance to try out one of the starter questions. "),
      ),
      cmarker.render("We will send a message into the rooms to let you know when you are halfway through the time"),
      cmarker.render("When you come back we will talk about what it’s like when you are asked about your context and know more context about the other person"),
      cmarker.render("Any questions before we send you in?"),
    )],
  [#instruction(
      cmarker.render("Copy this to chat when you hear the facilitator introduce the questions:"),
    )

    #chat(
      cmarker.render("We are going to explore what happens when we share our context.

One person will choose ONE of the starter questions below to ask your partner.

Continue the conversation and ask more questions to improve your understanding of the other person’s context.

Starter questions:

- Psychological: What would you like to have happen after attending this course?

- Historical: What have you learned so far on this course?

- Time: What were you doing before you came to the course today? What else do you have on today?

- Environmental: Where are you in the world?

Manage the time so everyone gets a chance to try out one of the starter questions.
"),
    )

    #instruction(
      cmarker.render("When the facilitator has finished giving the instructions/answering questions.Tell the group you are going to send them into BORs for 6 minutes"),
    )

    #instruction(cmarker.render("Send into BORs"))

    #instruction(cmarker.render("Broadcast halfway message:"))

    #chat(cmarker.render("Halfway, 3 minutes remaining"))],





  [25],
  [6],
  [Unpack Breakout activity#linebreak()#bcf-nom[Fx2]#linebreak()flip_3 Add to Flip#3 for up to 3 people and/or use chat.#linebreak()Fx1 scribes],
  [#spoken(
      cmarker.render("Let’s find out what you discovered:"),
      bcf-cue(
        cmarker.render("What happened when you knew more about the other person’s context "),
      ),
      bcf-cue(
        cmarker.render("What was it like for you, when you were asked about your context?"),
      ),
    )

    #instruction(
      cmarker.render("Facilitate brief discussion suggesting people can also put their answers in the chat.Aim for 2-3 examples, with one from the chat."),
    )

    #instruction(
      cmarker.render("Handover to Fx1 for exercise on improving conversations."),
    )],
  [#instruction(cmarker.render("Prepare BORs in same 2/3s for 6 minutes"))

    #chat(
      cmarker.render("What happened when you knew more about the other person’s context?

What was it like for you, when you were asked about your context?
"),
    )],





  speaker-swap[Switch to Fx1],



  [31],
  [8],
  [Breakout#2#linebreak()#bcf-nom[Fx1]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("We are going to put you in breakouts again for 6 minutes to talk about this."),
      bcf-cue(
        cmarker.render("We are going to consider improving a conversation using the 6 elements of context: "),
      ),
      bcf-cue(
        cmarker.render("Historical, psychological, social, cultural, environmental, and time-based (temporal). "),
      ),
      bcf-cue(
        cmarker.render("Remember that context helps determine the assumptions we make."),
      ),
      bcf-cue(
        cmarker.render("For a conversation that you want to be better in the future,  "),
      ),
      cmarker.render("Take a moment to think about what you would like to have happen in that conversation. "),
    )

    #instruction(cmarker.render("[pause for thinking]"))

    #spoken(
      bcf-cue(
        cmarker.render("
- What might you have to consider about the other persons’ context when preparing for your conversation with them?
- How would you find out about their context before and during the conversation?
"),
      ),
      bcf-cue(
        cmarker.render("Manage the time so everyone has a chance to answer the questions."),
      ),
      cmarker.render("When you’re in your breakout rooms, you don’t need to tell your partner what the conversation is about or who it’s with. "),
      cmarker.render("Keep your answers brief. Please only share what you are comfortable sharing."),
      cmarker.render("Any questions before we send you in? "),
    )],
  [#instruction(
      cmarker.render("Copy to chat when you hear the facilitator giving the instructions:"),
    )

    #chat(
      cmarker.render("We are going to consider improving a conversation using the 6 elements of context:

Historical, psychological, social, cultural, environmental, and time-based (temporal)

For a conversation that you want to be better in the future:

- What might you have to consider about the other persons’ context when preparing for your conversation with them?
- How would you find out about their context before and during the conversation?

Manage the time so everyone has a chance to answer the questions.
"),
    )

    #instruction(
      cmarker.render("When the facilitator has finished giving the instructions/answering questions.tell the group you are going to send them into BORs for 6 minutes"),
    )

    #instruction(cmarker.render("Send into BORs"))

    #instruction(cmarker.render("Broadcast halfway message:"))

    #chat(cmarker.render("Halfway, 3 minutes remaining"))],





  [39],
  [7],
  [Unpack Breakout#2 activity#linebreak()#bcf-nom[Fx1]#linebreak()flip_4 Add to Flip#4 for up to 3 people and/or use chat.#linebreak()Fx2 scribes],
  [#spoken(
      cmarker.render("Let’s find out what you just noticed."),
      bcf-cue(
        cmarker.render("
When preparing for your conversation:
- What might you have to consider about another person and their context?
- How might you find out about their context before and during the conversation?
"),
      ),
    )

    #instruction(
      cmarker.render("Facilitate brief discussion suggesting people can also put their answers in the chat. Aim for 2-3 examples, with one from the chat."),
    )

    #instruction(cmarker.render("If there is time extend the discussion e.g.:"))

    #spoken(
      cmarker.render("Do you think it is easier to make assumptions about a someone you know well or someone you don’t know?"),
      cmarker.render("What kind of assumptions might you make?"),
      cmarker.render("How easy it to correct your assumptions?"),
      cmarker.render("Just to recap, there are six elements to context that affect each of us in our conversations:  Historical, psychological, social, cultural, environmental, and time-based (temporal)."),
      cmarker.render("State is an important aspect of psychological context."),
      cmarker.render("Context gives us a way of making meaning and understanding a situation.  It helps determine the assumptions we make."),
      cmarker.render("
We’d like you to consider these questions, *thinking about what you know about state, assumptions and context*:
- *What will you do to manage your state before a conversation?*
- *How might your context affect your state*
"),
    )

    #instruction(
      cmarker.render("Ask people to put answers in chat. Facilitate brief discussion if time."),
    )

    #instruction(
      cmarker.render("Handover to Fx2 for reflection, fieldwork and close."),
    )],
  [#instruction(
      cmarker.render("Copy in chat (when you hear facilitator say these):"),
    )

    #chat(
      cmarker.render("When preparing for your conversation:

- What might you have to consider about another person and their context?

- How might you find out about their context before and during the conversation?
"),
    )],





  [46],
  [5],
  [Link to state#linebreak()#bcf-nom[Fx1]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("Just to recap, there are six elements to context that affect each of us in our conversations:  Historical, psychological, social, cultural, environmental, and time-based (temporal)."),
      cmarker.render("State is an important aspect of psychological context."),
      cmarker.render("Context gives us a way of making meaning and understanding a situation.  It helps determine the assumptions we make."),
      cmarker.render("We’d like you to consider these questions, *thinking about what you know about state, assumptions and context*:
-	*What will you do to manage your state before a conversation?*
-	*How might your context affect your state*
"),
    )

    #instruction(
      cmarker.render("Ask people to put answers in chat. Facilitate brief discussion if time."),
    )

    #instruction(
      cmarker.render("Handover to Fx2 for reflection, fieldwork and close."),
    )],
  [#instruction(
      cmarker.render("Copy in chat (when you hear facilitator say these):"),
    )

    #chat(
      cmarker.render("6 elements of context: Historical, psychological, social, cultural, environmental, and time-based (temporal)

Thinking about what you know about state, assumptions and context:

- What will you do to manage your state before a conversation?

- How might your context affect your state?
"),
    )],





  speaker-swap[Switch to Fx2],



  [51],
  [5],
  [Reflect on the learning in this session#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()Gather comments in chat and pick out some examples],
  [#spoken(
      cmarker.render("We have covered the context in which our conversations take place today. Let’s reflect on what you know now."),
      bcf-cue(
        cmarker.render("
Thinking about the conversations you are going to have in the next week, and what we have just learned on this module, please put in the chat:
- What difference does understanding context make to having Better Conversations?
- What you will do differently now you know this?
"),
      ),
      cmarker.render("There is space in the Course Handbook to capture any more thoughts you might have from today."),
    )],
  [#chat(
      cmarker.render("Thinking about the conversations you are going to have in the next week, and what we have just learned on this module…

- What difference does understanding context make to having Better Conversations?
- What will you do differently now you know this?
"),
    )],





  [56],
  [2],
  [Fieldwork#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("We will send out the fieldwork by email. The suggested fieldwork for this module is to..."),
      bcf-cue(
        cmarker.render("- Try noticing what context you bring to a conversation
- What do you know about the other person’s context?
- What impact does that have on the conversation?"),
      ),
    )],
  [#chat(
      cmarker.render("Fieldwork:
 - Try noticing what context you bring to a conversation
- What do you know about the other person’s context?
- What impact does that have on the conversation?"),
    )],





  [58],
  [1],
  [Close#linebreak()#bcf-nom[Fx2]#linebreak()#linebreak()],
  [#spoken(
      cmarker.render("If you have any further questions or anything you’d like to share, we will stay on the Zoom call for a few minutes after the session finished."),
      cmarker.render("Otherwise, we will see you next time where we will be exploring listening."),
    )

    #instruction(cmarker.render("Handover to Sponsor"))],
  [#instruction(
      cmarker.render("If leaving the session early, make facilitator a host first."),
    )],





  speaker-swap[Switch to Sponsor],



  [59],
  [16],
  [Sponsor Close#linebreak()#bcf-nom[Sponsor]#linebreak()#linebreak()],
  [#instruction(cmarker.render("Thank the facilitators and producer"))

    #instruction(
      cmarker.render("Mention to attendees that they are here to learn to deliver the course, as well as experience it as an attendee"),
    )

    #instruction(
      cmarker.render("Let attendees know that the session is finished and thank them."),
    )

    #instruction(
      cmarker.render("Say they are welcome to stay for 15 minutes or so if they have any questions for the team or any insights they’d like to share. After that the delivery team will debrief."),
    )

    #instruction(
      cmarker.render("Sponsor to facilitate discussion with attendees"),
    )],
  [],





  [75],
  [15],
  [Debrief#linebreak()#bcf-nom[Sponsor]#linebreak()#linebreak()],
  [#instruction(
      cmarker.render("Sponsor to facilitate debrief with delivery team on how session has gone and note any further observations, learnings etc."),
    )],
  [],
)
