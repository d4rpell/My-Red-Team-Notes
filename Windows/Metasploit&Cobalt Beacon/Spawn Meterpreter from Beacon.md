# Spawn Meterpreter from Beacon

#### Cobalt Strike’s session passing features target listeners. A [listener](https://www.cobaltstrike.com/help-listener-management) is a name tied to a payload handler and its configuration information. A foreign listener is an alias for a payload handler located elsewhere. Cobalt Strike can pass sessions to the Metasploit Framework with foreign listeners. To create a foreign listener for Meterpreter:

1. Go to Cobalt Strike -> Listeners

2. Press Add

3. Set the Payload type to windows/foreign/reverse_https for HTTPS Meterpreter. Cobalt Strike also has reverse_http and reverse_tcp foreign listeners too.

4. Set The Host and Port of the listener to the LHOST and LPORT of your Meterpreter handler.

5. Press Save

#### You now have a Cobalt Strike listener that refers to your Metasploit Framework payload handler. You can use this listener with any of Cobalt Strike’s features. To pass a session from Beacon, go to [beacon] -> Spawn and choose your foreign listener.

[POC VIDEO](https://youtu.be/Z4FKD8CvWo8)