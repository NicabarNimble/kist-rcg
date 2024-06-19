# DUMB QUESTIONS

This is a list of some of the dumb questions I have working in dojo. I'll try to answer them in the future.

1. How can I persist state between sessions? When I close out katana and reopen it clears the state.

2. How do I get scarb language server working? How do I make it so I can turn on or off?
   a: create .vcsode/settings.json and add the following:
   {
   "cairo1.languageServerPath": "/Users/nicabar/.asdf/installs/scarb/2.5.4/bin/scarb",
   "cairo1.preferScarbLanguageServer": true,
   "cairo1.languageServerExtraEnv": {
   "SCARB": "/Users/nicabar/.asdf/installs/scarb/2.5.4/bin/scarb",
   "CAIRO_LS_LOG": "cairo_lang_language_server=debug"
   }
   }

use true or false to turn on or off and use asdf where scarb to find current version path. make sure to add /bin/scarrb after asdf path to point to bin file.
