require_relative '../bcf'
require_relative '../common/common_blocks'
require 'json'
require 'json/add/struct'

# An example of using inheritance to specialise an object created in this manner
class ConventionalFlightPlan < BCF::FlightPlan
  def initialize
    super
    @total_length = 90
    @initial_time = -30
    @organisation = "Better Conversations"
  end
end

module_3 = ConventionalFlightPlan.build do
  module_title "Context"
  module_number 3

  learning_outcomes <<MD
Learners will be able to:

- Describe the elements of context in conversations
- Link context, assumptions and state

Suggested learning outcomes for further trainings/interventions

- Describe how social and cultural context affect conversations
    end
MD

  demo <<MD
No demo. 

Alternative example for context:

- Imagine you are watching TV and have muted it for the commercials. The first commercial you see shows a kitchen knife setting on a cutting board on the counter. Around it there are lots of different kinds of vegetables and a stock pot. Given that context, you would likely assume they were advertising a cooking show.
- The next commercial starts. You see the same kitchen knife. This time it is in the trunk (boot) of car along with some rope, duct tape, a tarp and a shovel.  That context brings up a completely different kind of show! Even though the kitchen knife is exactly the same.
MD

  block(BCF::CommonBlocks::PRE_FLIGHT)

  block(name: "Greeting", lead_by: [:fx1, :fx2]) do
    length 5

    facilitator do
      instruction "Greet people as they join – this is a chance to check their audio/video"
    end

    producer do
      instruction "Setup template Breakout Room for first breakout"
    end
  end

  block(name: "Welcome", lead_by: :fx1) do
    length 2

    resources do
      flipchart(
        :flip_1,
        "Flip#1 for agenda",
        description: "Use to explain the model",
        scribed_by: :fx1
      )
    end

    facilitator do
      instruction "Welcome people and introduce facilitator(s), producer and any observers and briefly explain their roles."
      spoken "Last time we looked at how quickly and easily we make assumptions, without being aware of them. We will do a quick review of that soon."
      # TODO: Rewrite **'s as an BCF call. This will involve moving into cmarker
      spoken "Then we will begin to explore the context around a conversation. **Context helps us make meaning of the world, and determines what assumptions we make.**"

      instruction "Go through agenda on flip"
    end
  end

  block(name: "Any Questions", lead_by: :fx1) do
    length 2

    facilitator do
      spoken "And is there anything you need to tell us before we begin? For example, if you need to leave early or if you are having any problems with Zoom."
      spoken "**And do you have anything you’d like to ask us about today’s topic?**"

      instruction "Respond to any questions/insights but keep it brief."
      instruction "Handover to Fx2 for state check-in."
    end
  end

  block(name: "State Check-In", lead_by: :fx2) do
    length 2

    facilitator do
      spoken "Now, let’s check-in with your state using the Traffic Light Model"
      spoken("Please put in the chat if you are green, amber/yellow or red", fixed: true)
      spoken("Green – you’re good to go!
Amber/Yellow – you need to proceed with caution
Red – you need to stop, break
", fixed: true)

      instruction "Accept whatever states are put in chat. Avoid saying that green state is best. If people are in red then ask them to take the time they need, switch their camera off and mute, and join when they are ready."
    end

    producer do
      chat <<CHAT
State check-in:

Green – you’re good to go!
Amber/Yellow – you need to proceed with caution
Red – you need to stop, break
CHAT

      instruction "Take note of states to help decide BOR participants"
    end
  end

  block(name: "Fieldwork reflections", lead_by: :fx2) do
    length 4

    facilitator do
      spoken "Let's have a quick recap of the fieldwork. Please share only what you’d like to and put your answers in the chat, so we hear from everyone quickly."
      spoken("Think of one conversation you had recently – maybe it was a good conversation, maybe it wasn't", fixed: true)
      spoken("Were your assumptions in that conversation accurate?", fixed: true)
      spoken("Just quickly put yes or no in the chat", fixed: true)

      instruction "If time permits, facilitator asks one person who answers “No” and one person who answers “Yes”:"
      spoken "Without adding too much detail, when your assumption was/wasn't accurate, then what happened?"
      instruction "Handover to Fx1 for Context model."
    end

    producer do
      chat <<CHAT
Think of one conversation you had recently – maybe it was a good conversation, maybe it wasn't.

- Were your assumptions in that conversation accurate?
- Please answer Yes or No in the chat.
CHAT
    end
  end

  block(name: "Context model", lead_by: :fx1) do
    length 7

    resources do
      flipchart(
        :flip_2,
        "use to explain the model",
        description: "Context diagram (as on handbook)",
        scribed_by: :fx1
      )
    end

    facilitator do
      spoken "There is an explanation in the handbook in Section 3 to help you remember the diagram."
      spoken "In Better Conversations, context means what surrounds the conversation, the setting for the conversation."
      spoken "Context is important because it defines our subjective experience."
      spoken "It helps us make meaning of our world. Each of us brings our own context to conversations. And we take it into our future conversations, so our context can change over time."
      spoken "Context also determines what assumptions we make. We can make different assumptions in different contexts."
      spoken "As an example, imagine you were in London and you saw people carrying umbrellas. You might think it was going to rain."
      spoken "Now imagine you are in a country in South Asia. If you saw people carrying umbrellas, they might be wanting to use them as parasols. If it was monsoon season, you might think the umbrella has a dual use."
      spoken "We have broken context down into 6 overlapping areas to help explain what it is."

      spoken <<TYPST_SPOKEN
Context can be:
- #underline[Psychological] (for example, your perception of your state, your personal values)
- #underline[Social] (for example, relationships and group behaviour)
- #underline[Cultural] (for example, cultural values and beliefs)
- #underline[Historical] (for example, what’s happened in the past, what’s documented or recorded)
- #underline[Environmental] (for example, what’s going in the physical space you are in)
- #underline[Time]-based (for example, temporal - time zone, whether it’s day or night)
TYPST_SPOKEN

      spoken <<MD
Some examples of your context we have already covered so far in this course are:
- Asking where in the world you are and what time zone you are in (environmental, cultural and time-based context)
- Asking how you are feeling, when we do the state check-in (psychological context)
MD

      spoken "We look at psychological, time-based, historical, environmental context in this course."
      spoken "We aren’t covering social or cultural context in this course in depth – these are beyond the scope of what we are doing here."
      spoken "What we are going to do now is put you in breakout rooms to find out more about  the impact of knowing someone’s context."
      instruction "Handover to Fx2 for context exercise."
    end

    producer do
      instruction "Prepare BORs in 2/3s for **6 minutes** if not already done"
    end
  end

  # TODO: Escape the in strings, Typst uses it as a control character
  block(name: "Breakout#1", lead_by: :fx2) do
    length 8

    resources do
      breakout_room(:bor_1)
    end

    facilitator do
      spoken "You will have 6 minutes to do this exercise in breakout rooms."
      spoken "We are going to explore what happens when we share our context."
      spoken "Please only ask what is appropriate for this setting and share only what you feel comfortable sharing in the group when we come back into the main room."

      spoken("One person will choose ONE of the starter questions below to ask your partner. " \
             "Continue the conversation and ask more questions to improve your understanding of the other person’s context.",
             fixed: true)
      spoken("Starter questions:
-	Psychological: What would you like to have happen after attending this course?
-	Historical: What have you learned so far on this course?
-	Time: What were you doing before you came to the course today? What else do you have on today?
-	Environmental: Where are you in the world?
", fixed: true)

      spoken("Manage the time so everyone gets a chance to try out one of the starter questions. ", fixed: true)

      spoken "We will send a message into the rooms to let you know when you are halfway through the time"
      spoken "When you come back we will talk about what it’s like when you are asked about your context and know more context about the other person"
      spoken "Any questions before we send you in?"
    end

    producer do
      instruction "Copy this to chat when you hear the facilitator introduce the questions:"

      # TODO: Add support for messages that are supposed to be copied piecemeal.
      chat <<CHAT
We are going to explore what happens when we share our context.

One person will choose ONE of the starter questions below to ask your partner. 

Continue the conversation and ask more questions to improve your understanding of the other person’s context. 

Starter questions:

- Psychological: What would you like to have happen after attending this course? 

- Historical: What have you learned so far on this course?

- Time: What were you doing before you came to the course today? What else do you have on today?

- Environmental: Where are you in the world?

Manage the time so everyone gets a chance to try out one of the starter questions.
CHAT

      instruction "When the facilitator has finished giving the instructions/answering questions." \
                    "Tell the group you are going to send them into BORs for 6 minutes"

      instruction "Send into BORs"
      instruction "Broadcast halfway message:"

      # TODO: Parameterize the time of a breakout room
      chat "Halfway, 3 minutes remaining"
    end
  end

  block(name: "Unpack Breakout activity", lead_by: :fx2) do
    length 6
    section_comment "Fx1 scribes"

    resources do
      flipchart(
        :flip_3,
        "Add to Flip#3 for up to 3 people and/or use chat.",
        description: "Learnings on context",
        scribed_by: :fx2
      )

      breakout_room(:bor_1)
    end

    facilitator do
      spoken "Let’s find out what you discovered:"
      spoken_fixed "What happened when you knew more about the other person’s context "
      spoken_fixed "What was it like for you, when you were asked about your context?"

      instruction "Facilitate brief discussion suggesting people can also put their answers in the chat." \
                    "Aim for 2-3 examples, with one from the chat."

      instruction "Handover to Fx1 for exercise on improving conversations."
    end

    producer do
      instruction "Prepare BORs in same 2/3s for 6 minutes"

      chat <<CHAT
What happened when you knew more about the other person’s context?

What was it like for you, when you were asked about your context?
CHAT
    end
  end

  block(name: "Breakout#2", lead_by: :fx1) do
    length 8

    resources do
      breakout_room(:bor_2)
    end

    facilitator do
      spoken "We are going to put you in breakouts again for 6 minutes to talk about this."
      spoken_fixed "We are going to consider improving a conversation using the 6 elements of context: "
      spoken_fixed "Historical, psychological, social, cultural, environmental, and time-based (temporal). "
      spoken_fixed "Remember that context helps determine the assumptions we make."
      spoken_fixed "For a conversation that you want to be better in the future,  "
      spoken "Take a moment to think about what you would like to have happen in that conversation. "

      instruction "[pause for thinking]"

      spoken_fixed "
- What might you have to consider about the other persons’ context when preparing for your conversation with them?
- How would you find out about their context before and during the conversation?
"

      spoken_fixed "Manage the time so everyone has a chance to answer the questions."
      spoken "When you’re in your breakout rooms, you don’t need to tell your partner what the conversation is about or who it’s with. "
      spoken "Keep your answers brief. Please only share what you are comfortable sharing."
      spoken "Any questions before we send you in? "
    end

    producer do
      instruction "Copy to chat when you hear the facilitator giving the instructions:"

      chat <<CHAT
We are going to consider improving a conversation using the 6 elements of context:

Historical, psychological, social, cultural, environmental, and time-based (temporal)

For a conversation that you want to be better in the future:

- What might you have to consider about the other persons’ context when preparing for your conversation with them?
- How would you find out about their context before and during the conversation?

Manage the time so everyone has a chance to answer the questions.
CHAT

      instruction "When the facilitator has finished giving the instructions/answering questions." \
                  "tell the group you are going to send them into BORs for 6 minutes"

      instruction "Send into BORs"
      instruction "Broadcast halfway message:"
      chat "Halfway, 3 minutes remaining"
    end
  end

  block(name: "Unpack Breakout#2 activity", lead_by: :fx1) do
    length 7
    section_comment "Fx2 scribes"

    resources do
      flipchart(
        :flip_4,
        "Add to Flip#4 for up to 3 people and/or use chat.",
        description: "Learnings on context",
        scribed_by: :fx2
      )
      breakout_room(:bor_2)
    end

    facilitator do
      spoken "Let’s find out what you just noticed."
      spoken_fixed "
When preparing for your conversation:
- What might you have to consider about another person and their context?
- How might you find out about their context before and during the conversation?
"

      instruction "Facilitate brief discussion suggesting people can also put their answers in the chat. Aim for 2-3 examples, with one from the chat."

      instruction "If there is time extend the discussion e.g.:"

      spoken "Do you think it is easier to make assumptions about a someone you know well or someone you don’t know?"
      spoken "What kind of assumptions might you make?"
      spoken "How easy it to correct your assumptions?"
      spoken "Just to recap, there are six elements to context that affect each of us in our conversations:  Historical, psychological, social, cultural, environmental, and time-based (temporal)."
      spoken "State is an important aspect of psychological context."
      spoken "Context gives us a way of making meaning and understanding a situation.  It helps determine the assumptions we make."
      spoken "
We’d like you to consider these questions, *thinking about what you know about state, assumptions and context*:
- *What will you do to manage your state before a conversation?*
- *How might your context affect your state*
"

      instruction "Ask people to put answers in chat. Facilitate brief discussion if time."
      instruction "Handover to Fx2 for reflection, fieldwork and close."
    end

    producer do
      instruction "Copy in chat (when you hear facilitator say these):"

      chat <<CHAT
When preparing for your conversation:

- What might you have to consider about another person and their context?

- How might you find out about their context before and during the conversation?
CHAT
    end
  end

  block(name: "Link to state", lead_by: :fx1) do
    length 5

    facilitator do
      spoken "Just to recap, there are six elements to context that affect each of us in our conversations:  Historical, psychological, social, cultural, environmental, and time-based (temporal)."
      spoken "State is an important aspect of psychological context."
      spoken "Context gives us a way of making meaning and understanding a situation.  It helps determine the assumptions we make."

      spoken <<MD
We’d like you to consider these questions, *thinking about what you know about state, assumptions and context*:
-	*What will you do to manage your state before a conversation?*
-	*How might your context affect your state* 
MD

      instruction "Ask people to put answers in chat. Facilitate brief discussion if time."
      instruction "Handover to Fx2 for reflection, fieldwork and close."
    end

    producer do
      instruction "Copy in chat (when you hear facilitator say these):"

      chat <<CHAT
6 elements of context: Historical, psychological, social, cultural, environmental, and time-based (temporal)

Thinking about what you know about state, assumptions and context:

- What will you do to manage your state before a conversation?

- How might your context affect your state?
CHAT
    end
  end

  block(name: "Reflect on the learning in this session", lead_by: :fx2) do
    length 5

    section_comment "Gather comments in chat and pick out some examples"

    facilitator do
      spoken "We have covered the context in which our conversations take place today. Let’s reflect on what you know now."
      spoken("
Thinking about the conversations you are going to have in the next week, and what we have just learned on this module, please put in the chat:
- What difference does understanding context make to having Better Conversations?
- What you will do differently now you know this?
", fixed: true)

      spoken "There is space in the Course Handbook to capture any more thoughts you might have from today."
    end

    producer do
      chat <<CHAT
Thinking about the conversations you are going to have in the next week, and what we have just learned on this module…

- What difference does understanding context make to having Better Conversations?
- What will you do differently now you know this?
CHAT
    end
  end

  block(BCF::CommonBlocks::Fieldwork.new(
    [
      "Try noticing what context you bring to a conversation",
      "What do you know about the other person’s context?",
      "What impact does that have on the conversation?",
    ],
    id: :context_fieldwork,
    description: "",
    length: 2
  ), lead_by: :fx2)

  block(lead_by: :fx2) do
    length 1
    name "Close"

    facilitator do
      spoken "If you have any further questions or anything you’d like to share, we will stay on the Zoom call for a few minutes after the session finished."
      spoken "Otherwise, we will see you next time where we will be exploring listening."
      instruction "Handover to Sponsor"
    end

    producer do
      instruction "If leaving the session early, make facilitator a host first."
    end
  end

  block(BCF::CommonBlocks::SPONSOR_CLOSE)
  block(BCF::CommonBlocks::SPONSOR_DEBRIEF)
end
