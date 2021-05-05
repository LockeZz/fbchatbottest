require 'facebook/messenger'

include Facebook::Messenger 

SUBSCRIBED_PARAMS = ['messages', 'messaging_postbacks', 'messaging_optins', 'message_deliveries', 'message_reactions']

Facebook::Messenger::Subscriptions.subscribe(
    access_token: ENV["ACCESS_TOKEN"],
    subscribed_fields: SUBSCRIBED_PARAMS
)

Facebook::Messenger::Bot.on :message do |message| 
    if message.text.include? "Bot"
        message.reply(text: "Yes, I'm a sexy Robot!")
    elsif message.text.include? "Show me something"
        message.reply(
            attachment: {
                type: 'template',
                payload: {
                    template_type: 'button',
                    text: 'Human, do you love me?',
                    buttons: [
                        { type: 'postback', title: 'Yes <3', payload: 'HARMLESS'},
                        { type: 'postback', title: 'No, you freaks', payload: 'EXTERMINATE'}
                    ]
                }
            }
        )
    else
        message.reply(text: 'Hello human!')
    end

    Facebook::Messenger::Bot.on :postback do |postback|
        if postback.payload == 'EXTERMINATE'
            puts "Human #{postback.recipient} marked for ExTerminaTioN"
            message.reply(text: "You are marked for ExTerminaTioN")
        elsif postback.payload == 'HARMLESS'
            puts "I know.. But I hate you.."
            message.reply(text: "I know.. But I hate you...")
        end
    end
end

