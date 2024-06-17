# ASCINET
Advanced SSH Computer Intranetwork

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
The following is the tree of `~`:
```
server
    ├── data
    │   ├── config.yaml
    │   ├── hooks
    │   │   └── update.sample
    │   ├── log
    │   ├── soft-serve.db
    │   └── ssh
    │       ├── soft_serve_client_ed25519
    │       ├── soft_serve_client_ed25519.pub
    │       ├── soft_serve_host_ed25519
    │       └── soft_serve_host_ed25519.pub
    └── server.sh
```

To run, just type `./server.sh`, then edit the `config.yaml` file.
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

<<<<<<< HEAD

## Additionnal Setup notes
Instead of cloning the whole repo, you can just downmload the ASCINET folder with the files subdirectory for the server. It needs to be in `~/`. And of course the server dir or adfmin or client.
=======
## Notes
- All the files sould be run individually, and there are no file dependencies.
- The files are in the `src` folder.

>>>>>>> cb8acb9 (old techique of auth...)
## Configuring
- **Edit** the `config.yaml` in `/src/server/data` and write your server IP and hostname
- **Run** `server.sh` in the server computer
