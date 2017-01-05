# Machine specific aliases/functions are at the bottom.

### General
   alias addGoPath="export GOPATH=\$GOPATH:\`pwd\`"
   # Clean a directory of all latex compilation artifacts.
   alias cleanLatex='rm *.aux *.bbl *.blg *.dvi *.log *.pdf *.ps'
   alias clear="clear;clear"
   alias clipboard="xclip -sel clip"
   alias gcc101='gcc -lm -std=c99 -Wall -pedantic'
   alias myip="wget -qO - http://cfaj.freeshell.org/ipaddr.cgi"
   alias noSleep="xset s off; xset -dpms"
   alias quit="exit"
   alias rmsvn="find . -name .svn -print0 | xargs -0 rm -rf"
   alias sw="setWork"
   alias unzipall='for z in *.zip; do unzip -q -u -d "`basename "$z" .zip`" "$z"; done'
   alias utf8ToAscii='iconv -c -f utf-8 -t ascii'
   alias valgrindfull="valgrind --leak-check=full --show-reachable=yes --track-origins=yes"
   alias wbq="work; back; quit;"
   alias work="cd $WORKINGDIR"

   ## Java stuff
      alias fulldoc="find . -name *.java | xargs javadoc -d docs -version -author -classpath ./target/classes:\`cat classpath.out\` -link https://docs.oracle.com/javase/7/docs/api/"
      # no assertions
      alias javanoa="java -da"
      # assertions (default)
      alias javaa="java -ea"
      alias java="java -ea"
      alias javaXmem="java -Xmx12G -Xms12G"
      alias javacp="java -cp ./target/classes:\`cat classpath.out\`"
      alias mvncp="mvn dependency:build-classpath -Dmdep.outputFile=classpath.out"

   ## Vim
      # "VIM No O"
      alias vimno="vim -O1"
      # Readonly
      alias vimr="vim -R"
      # Always open multiple files in multiple windows.
      alias vim="vim -O"

   ## Volume Control
      alias mute="amixer -D pulse set Master mute"
      alias unmute="amixer -D pulse set Master unmute"

      alias mutetoggle="amixer -D pulse set Master toggle"
      alias voltoggle="amixer -D pulse set Master toggle"

      alias voldown="amixer -D pulse set Master 5%-"
      alias "vol-"="amixer -D pulse set Master 5%-"

      alias volup="amixer -D pulse set Master 5%+"
      alias "vol+"="amixer -D pulse set Master 5%+"

   ## Functions
      function back {
         backDir=`pwd`
         backDir=`basename $backDir`
         backPath="$HOME/back/$backDir"

         rm -Rf "$backPath"
         mkdir -p "$backPath"
         cp -R * "$backPath"
      }

      function findvim {
         target="."
         if [ $# -gt 1 ]; then
            target=$2
         fi

         vim $(find $target -name $1)
      }

      function fulllatex {
         latex $1.tex && \
         latex $1.tex && \
         bibtex $1.aux && \
         latex $1.tex && \
         latex $1.tex && \
         makeindex $1.glo -s $1.ist -t $1.glg -o $1.gls && \
         latex $1.tex && \
         dvips -P pdf -t letter -o $1.ps $1.dvi && \
         ps2pdf -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress $1.ps $1.pdf
      }

      function fulllatexNoFail {
         latex $1.tex
         latex $1.tex
         bibtex $1.aux
         latex $1.tex
         latex $1.tex
         makeindex $1.glo -s $1.ist -t $1.glg -o $1.gls
         latex $1.tex
         dvips -P pdf -t letter -o $1.ps $1.dvi
         ps2pdf -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress $1.ps $1.pdf
      }

      function goInit {
         mkdir -p bin src pkg
         export GOPATH=`pwd`

         if [ ! -e setenv.sh ]; then
            cat > setenv.sh <<EOF
#!/bin/sh

# Set the Go environment to the current directory.
export GOPATH=\`pwd\`
export PATH=\$PATH:\$GOPATH/bin
EOF

            chmod +x setenv.sh
         fi
      }

      function mkcd {
         mkdir -p "$1";
         cd "$1";
      }

      function mountIso {
         sudo mkdir -p /media/iso
         sudo umount -df /media/iso
         sudo mount -o loop $1 /media/iso
      }

      function quickBench {
         echo "/dev/zero -> ."
         dd bs=1M count=512 if=/dev/zero of=.__test__bench__ ;\

         echo ". -> ."
         dd bs=1M count=512 if=.__test__bench__ of=.__test__bench__2 ;\

         echo ". -> /dev/null"
         dd bs=1M count=512 if=.__test__bench__ of=/dev/null ;\

         rm -f .__test__bench__*
      }

      function setWork {
         temp=`pwd`
         if [ $# -ne 0 ];
         then
            temp=$1
         fi

         WORKINGDIR=$temp
         echo $WORKINGDIR
         echo $WORKINGDIR > $HOME/._workingDirectoryConfig
      }

      function webPermissions {
         temp=`pwd`
         if [ $# -ne 0 ];
         then
            temp=$1
         fi

         find $temp -type d -exec chmod 755 {} \;
         find $temp -type f -exec chmod 644 {} \;
      }

### Eriq Specific
   ## Functions
      function eriqClone {
         git clone "git@github.com:eriq-augustine/${1}.git"
      }

      function gitTraces {
         git diff master --name-only -z | xargs -0 grep eriq
         git diff master --name-only -z | xargs -0 grep '//TEST'
      }

### Machine Specific
   # Use fstab entry
   alias mountNas="sudo mount /media/nas"
   alias razerSet="razercfg --setled Scrollwheel:off ; razercfg --setled GlowingLogo:off ; razercfg --res 1:2"
   alias skype='xhost +local: && su skype -c skype'
   alias winesteam="WINEDEBUG=-all wine \"`find $WINEPREFIX/drive_c/Program* -name Steam.exe`\" -no-dwrite"

   ## Functions
      function cleanWine {
         rm ~/.local/share/mime/packages/x-wine*
         rm ~/.local/share/applications/wine-extension*
         rm ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
         rm ~/.local/share/mime/application/x-wine-extension*
         rm -f ~/.local/share/applications/wine-extension*.desktop
         rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
         rm -f ~/.local/share/applications/mimeinfo.cache
         rm -f ~/.local/share/mime/packages/x-wine*
         rm -f ~/.local/share/mime/application/x-wine-extension*
         update-desktop-database ~/.local/share/applications
         update-mime-database ~/.local/share/mime/
      }

      function setTime {
         sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
         sudo ntpd -qg
         sudo hwclock -w
      }
