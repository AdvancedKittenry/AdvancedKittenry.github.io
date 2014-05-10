AdvancedKittenry.github.io
===============================

Asennusohjeet:

Sinulla tulee olla asennettuna tuoreet versiot seuraavista ohjelmistoista:
cabal, ghc, perl, python

Asenna pandoc:

cabal update
cabal install pandoc

Vaihtoehtoisesti voit ajaa skripin install.sh, joka tekee tämän puolestasi ja valittaa mikäli jotain ei löydy.

Jos pandoc ei asennu saata joutua ajamaan asentajan seuraavalla tavalla:
cabal install pandoc --constraint='exceptions < 0.6'
