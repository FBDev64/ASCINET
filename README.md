# ASCINET
Advanced SSH Computer Intranetwork
Roles : Server, Supervisor, Client
The Supervisor is the network and server Administrator.

## Needs
You need to have the following :

- Unix based server and supervisor
- The remote IP and username of server
- Sh or Bash, NetCat, Soft-Serve, Gum, Glow
- Port 8080, 8008 and 8800 unused

## Server Setup
```
cd ~
git clone https://github.com/fbdev64/ASCINET.git
cd ASCINET/src/server
chmod +x server.sh
```
To run, just type `./server.sh`
## Admin Setup
```
cd ~
git clone https://github.com/fbdev64/ASCINET.git
cd ASCINET/src/admin
chmod +x admin.sh
```
To run, just type `./admin.sh`

## Clien Setup
```
cd ~
git clone https://github.com/fbdev64/ASCINET.git
cd ASCINET/src/client
chmod +x client.sh
```
To run, just type `./client.sh`

## Configuring
- **Edit** the `config.yaml` in `/src/server/data` and write your server IP and hostname
- **Run** `server.sh` in the server computer
