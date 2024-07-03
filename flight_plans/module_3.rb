require_relative '../bcf'
require_relative './common_blocks'

# An example of using inheritance to specialise an object created in this manner
class ConventionalFlightPlan < BCF::FlightPlan
  def initialize(&block)
    @total_length = 90
    @initial_time = -30

    super(&block)
  end
end

module_3 = ConventionalFlightPlan.new do
  module_title "Context"
  module_number 3

  block(BCF::CommonBlocks::PRE_FLIGHT)

  block(lead_by: [:fx1, :fx2]) do
    name "Greeting"
    length 5

    facilitator do
      instruction "Greet people as they join – this is a chance to check their audio/video"
    end

    producer do
      instruction "Setup template Breakout Room for first breakout"
    end
  end

  block(lead_by: :fx1) do
    name "Welcome"
    length 2

    resources do
      flipchart(:flip_1, "Agenda")
    end

    facilitator do
      instruction "Welcome people and introduce facilitator(s), producer and any observers and briefly explain their roles."
      spoken "Last time we looked at how quickly and easily we make assumptions, without being aware of them. We will do a quick review of that soon."
      spoken "Then we will begin to explore the context around a conversation. #bcf-mod[Context helps us make meaning of the world, and determines what assumptions we make.]"

      instruction "Go through agenda on flip"
    end
  end

  block(lead_by: :fx1) do
    name "Any Questions?"
    length 2

    facilitator do
      spoken "And is there anything you need to tell us before we begin? For example, if you need to leave early or if you are having any problems with Zoom."
      spoken "#bcf-mod[And do you have anything you’d like to ask us about today’s topic?]"

      instruction "Respond to any questions/insights but keep it brief."
      instruction "Handover to Fx2 for state check-in."
    end
  end

  block(lead_by: :fx2) do
    name "State Check-In"
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

  block(lead_by: :fx2) do
    name "Fieldwork reflections"
    length 4

    facilitator do
      spoken "Let’s have a quick recap of the fieldwork. Please share only what you’d like to and put your answers in the chat, so we hear from everyone quickly."
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

  block(lead_by: :fx1) do
    name "Context model"
    length 7

    resources do
      flipchart(:flip_2, "use to explain the model")
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

      spoken <<TYPST_SPOKEN
Some examples of your context we have already covered so far in this course are:
- Asking where in the world you are and what time zone you are in (environmental, cultural and time-based context)
- Asking how you are feeling, when we do the state check-in (psychological context)
TYPST_SPOKEN

      spoken "We look at psychological, time-based, historical, environmental context in this course."
      spoken "We aren’t covering social or cultural context in this course in depth – these are beyond the scope of what we are doing here."
      spoken "What we are going to do now is put you in breakout rooms to find out more about  the impact of knowing someone’s context."
      instruction "Handover to Fx2 for context exercise."
    end

    producer do
      instruction "Prepare BORs in 2/3s for #bcf-nom[6 minutes] if not already done"
    end
  end

  block(lead_by: :fx2) do
    length 8
    name "Breakout#1"

    resources do
      breakout_room(:bor_1)
    end
  end

  block(lead_by: :fx2) do
    length 6
    name "Unpack Breakout activity"
    section_comment "Fx2 scribes"

    resources do
      flipchart(:flip_3, "Add to Flip#3 for up to 3 people and/or use chat.")
      breakout_room(:bor_1)
    end
  end

  block(lead_by: :fx1) do
    length 8
    name "Breakout#2"

    resources do
      breakout_room(:bor_2)
    end
  end

  block(lead_by: :fx2) do
    length 7
    name "Unpack Breakout#2 activity"
    section_comment "Fx2 scribes"

    resources do
      flipchart(:flip_3, "Add to Flip#3 for up to 3 people and/or use chat.")
      breakout_room(:bor_2)
    end
  end

  block(lead_by: :fx1) do
    length 5
    name "Link to state"

    producer do
      chat <<CHAT
6 elements of context: Historical, psychological, social, cultural, environmental, and time-based (temporal)

Thinking about what you know about state, assumptions and context:

- What will you do to manage your state before a conversation?

- How might your context affect your state?
CHAT
    end
  end

  block(lead_by: :fx2) do
    length 5
    name "Reflect on the learning in this session"

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

module_3.validate
module_3.render_pdf('module_3.pdf', "module_3.typ")
