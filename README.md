# kist-rcg

This scaffolding sets up the basic dojo world connected to a React Vite application.

## Install using asdf

You can alternatively use the asdf package manager to install and manage your Dojo installation.

### Install asdf

Follow the asdf [installation instructions](https://asdf-vm.com/guide/getting-started.html).

### Add the asdf-dojo plugin

```bash
asdf plugin add dojo https://github.com/dojoengine/asdf-dojo
```

### Install the latest and a specific version for the project

```bash
asdf install dojo latest # For the latest version
asdf install dojo 0.7.0-alpha.5 # For this project use this specific version
```

### Set the global and then local version for project

```bash
asdf global dojo latest # Set globally
asdf local dojo 0.7.0-alpha.5 # Set locally in your project directory
```

### Client

The client uses the RECS library for state management and syncing and React with Tailwind for the UI.

### Run each command in an individual CLI window



```bash
cd client && pnpm i && pnpm dev
```

### Katana

```bash
cd contracts
katana --disable-fee --allowed-origins "*"
```

### Torii

```bash
cd contracts

sozo build

sozo migrate apply

torii --world 0x6457e5a40e8d0faf6996d8d0213d6ba2f44760606e110e03e3d239c5f769e87 --allowed-origins "*"
```

### Auth Script

```bash
cd contracts/scripts

./default_auth.sh
```
