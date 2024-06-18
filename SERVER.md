## Server Setup : A complete guide

## Preface
My server code is very handy to setup, that's why I'm doing a how-to guide.
Initially, I had my own little server, that launches when the `server.sh` is executed. Now, I switched to [Soft Serve](https://github.com/charmbracelet/soft-serve).

## Command Running
Do not run any other command between code blocks. Do not cd into another dir or anything.

## 1. Downloading
```bash
cd $HOME 
git clone https://github.com/FBDev64/ASCINET.git
cd ASCINET/src/server
chmod +x server.sh
```

## 2. Configuring
You need to configure the Soft Serve server by editing the `config.yaml` in the data subdirectory.
Replace the `remote_ip` and `remote_user` to match you server's IP and username.

```bash
cd data
$EDITOR config.yaml
```

## 3. Launching
You can use the `launcher.sh` tool in the root of the git repository, but here, it's manually.
```bash
cd ..       # CD into /server/
./server.sh # Launch server.sh
```
