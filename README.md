# ASCINET
Advanced SSH Computer Intranetwork
Roles : Server, Supervisor, Client
The Supervisor is the network and server Administrator.

## Configuration
You need to have the following :

- Unix based server and supervisor
- The remote IP and username of server
- The `server.sh` file running in server
- Sh or Bash and Gum

## Server Setup
Download server.sh then :
```
cd /
mkdir ASCINET
cp server.sh ASCINET/
cd ASCINET/
chmod +x server.sh
```
To run, just type `./server.sh` 

## Supervisor Setup
Download supervisor.sh then :
```
chmod +x suprvisor.sh
```
To run, just type `./supervisor.sh`

## Client Setup
Download vlient.sh then :
```
chmod +x client.sh
```
To run, just type `./client.sh`


