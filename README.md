# What is this ?

A containerised debian node dev environment.
I has all the needed tools to work in this container as is was your main computer.
It is meant to be used with vscode. You can simply run `code ./dev` to start developping

## Features:

* mirror your local ~/.ssh/ to have same git access from the container
* has oh-my-zsh with plugins installed
* you can easily changes dns/ports/etc. in `docker-compose.yml` to fit your needs
* you can add your aliases and more in .zshrc (it will be append to your .zshrc when running `$ make install`)
* the home directory is reflected between the container (~ = /home/dev) and your host (./dev)

## Usecase:

You want a fully isolated development environment to pop any instance and start developping.
You can fork this project and customize it to your needs so it become your own dev environment with all your known aliases and tools and start developping right await from any computer having the few prequisites installed.

It can also be used too kick-start some educational projects where you don't have time to spend on installing a consistent dev stack on all different computers.

## Compatibility:

It should run seemlessly on any linux distribution / windows >=10 (via any wsl linux distrib) / macos (as long as you have docker installed)

# Prerequisites

* if on windows: [wsl](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/install/)
* [make](https://www.gnu.org/software/make/)

# Install dev env

```bash
$ make install
```

# Boot dev env

```bash
$ make start
```

# Debug nodejs app in vscode
To debug node run your app like so

* `$ node --inspect=0.0.0.0:9229 index.js` **(mind param order)**
* OR: `$ yarn ts-node --inspect=0.0.0.0:9229 index.ts` **(mind param order)**
* OR:  `$ pm2-dev index.js --node-args='--inspect=0.0.0.0:9229`

Then hit F5 in vscode to start debugging