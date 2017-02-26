# sms-bot

This is a small bot, meant to run in conjonction with a mobile phone number on a Twilio account.

Current only feature is the switch on/off of the wifi scheduling on the french SFR Box.

This allows me to:
- have a fairly strict wifi scheduling (turned on only few hours per day)
- force it to be turned on when I need to, simply by sending a hand-crafted SMS to my Twilio number, i.e. without having to connect with a cable to the box, etc...
- turn it back off when I don't need it anymore

Of course, the device on which the code is running must be:
- on my local network to be able to connect to the SFR Box admin panel
- connected to the box via an Ethernet cable (no wifi :o))