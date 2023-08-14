### Cobalt Strike’s Beacon payload has had [SOCKS proxy pivoting](https://www.cobaltstrike.com/help-socks-proxy-pivoting) since 2013. This form of pivoting makes it easy to tunnel many tools through Beacon. To tunnel the Metasploit Framework through Beacon:

1. Interact with a Beacon and type socks 1234 to create a SOCKS proxy server on port 1234 of your Cobalt Strike team server system.

2. Type sleep 0 in the Beacon console to request that the Beacon become interactive. Tunneling traffic with minimal latency requires that Beacon regularly connects to your controller to exchange read, write, and connect information.

3. Go to View -> Proxy Pivots in Cobalt Strike. This will open a tab that presents all SOCKS proxy servers on your Cobalt Strike team server.

4. Highlight the desired SOCKS pivot and press Tunnel. This will open a dialog that contains a one-liner to paste into the Metasploit Framework.

5. Go to msfconsole and paste in that one-liner. This one-liner will globally set the Metasploit Framework’s Proxies option. This option lets you specify a SOCKS proxy server to send the Metasploit Framework module through.

#### Use the Metasploit Framework. The exploits and modules you run will tunnel through your Beacon.

[POC VIDEO](https://www.youtube.com/watch?v=x60toeJRMe4)

#### If you want to stop tunneling Metasploit through your Beacon, type unsetg Proxies in the Metasploit Framework console.

