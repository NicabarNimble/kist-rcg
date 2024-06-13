# kist-rcg

This scaffolding sets up the basic dojo world connected to a React Vite application.


### Client

The client uses the RECS library for state management and syncing and React with Tailwind for the UI.

### Run each command in an individual CLI window

```bash
cd client && pnpm i && pnpm dev
```

```bash
cd contracts
katana --disable-fee --allowed-origins "*"
```

```bash
cd contracts

sozo build

sozo migrate apply

torii --world 0x6457e5a40e8d0faf6996d8d0213d6ba2f44760606e110e03e3d239c5f769e87 --allowed-origins "*"
```
