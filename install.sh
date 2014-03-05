#!/bin/bash
echo "Checking dependencies..."

hash git 2>/dev/null || { echo >&2 "I require git but it's not installed.  Please install git."; exit 1; }
echo "Git found..."
hash ghc 2>/dev/null || { echo >&2 "I require ghc but it's not installed.  Please install ghc."; exit 1; }
echo "GHC found..."
hash python 2>/dev/null || { echo >&2 "I require python but it's not installed.  Please install python."; exit 1; }
echo "Python found..."
hash perl 2>/dev/null || { echo >&2 "I require perl but it's not installed.  Please install perl."; exit 1; }
echo "Perl found..."

if hash pandoc 2>/dev/null; then
  echo "Pandoc found..."
else 
  if hash cabal 2>/dev/null; then
    echo "Installing pandoc..."
    cabal update
    cabal install pandoc
    if hash pandoc 2>/dev/null; then
      echo "Apparently you don't have pandoc in your PATH. Do you wish to include the cabal binary directory ~/.cabal/bin in your path?"
      echo "This would add the line 'export PATH=\"\$HOME/.cabal/bin:\$PATH\"' to your .bashrc file.";
      echo "Please enter 1 or 2:";
      select yn in "Yes" "No"; do
        case $yn in
          Yes ) echo "export PATH=\"\$HOME/.cabal/bin:\$PATH\"" >> $HOME/.bashrc; export PATH="$HOME/.cabal/bin:$PATH"; break;;
          No ) echo "Please run install.sh again when you have put pandoc in your path" exit;;
        esac
      done
    fi
  else
    echo >&2 "I require cabal but it's not installed.  Please install cabal."; exit 1;
  fi
fi

echo "Cloning repository..."
git clone git@github.com:AdvancedKittenry/AdvancedKittenry.github.io.git
cd AdvancedKittenry.github.io
echo "Generating site..."
./make-navigation.sh
make && echo "Site generated. You can press make to regenerate modified files"
