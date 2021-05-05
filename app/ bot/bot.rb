require 'facebook/messenger'

include Facebook::Messenger 

SUBSCRIBED_PARAMS = ['messages']

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
end