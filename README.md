# ASCINET

Advanced SSH Computer Intranetwork

## Notes

The project will get some updates(mainly to be Cross-Platform), and will be re-written in C using [Airlib](https://GitHub.com/AdamOnAir/Airlib).

## Server Setup
```
cd ~
git clone https://github.com/AdamOnAir/ASCINET.git
cd ASCINET/src/server
chmod +x server.sh

```

To run, just type `./server.sh`, then edit the `config.yaml` file.

**For a complete detailed guide, check the SERVER.md**

## Admin Setup
```
cd ~
git clone https://github.com/AdamOnAir/ASCINET.git
cd ASCINET/src/admin
chmod +x admin.sh
```
To run, just type `./admin.sh`

## Clien Setup
```
cd ~
git clone https://github.com/AdamOnAir/ASCINET.git
cd ASCINET/src/client
chmod +x client.sh
```
To run, just type `./client.sh`

## Additionnal Setup notes
Instead of running `chmod +x ./the_file`, run the same command for launcher. It will ask you what type of user are you (Client, Admin or Server) and will run the file.

## Configuring
- **Edit** the `config.yaml` in `/src/server/data` and write your server IP and hostname

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[BSD 3-Clause “New” or “Revised” License](./LICENSE)
