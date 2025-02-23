# Machine specific aliases/functions are at the bottom.

### General
   alias addGoPath="export GOPATH=\$GOPATH:\`pwd\`"
   # Clean a directory of all latex compilation artifacts.
   alias cleanLatex='rm -f *.aux *.bbl *.blg *.dvi *.log *.pdf *.ps *.lof *.lot *.toc *.out'
   alias clear="clear;clear"
   alias clipboard="xclip -sel clip"
   alias extensions="find . -type f | ext | sort | uniq -c | sort -n"
   alias gcc101='gcc -lm -std=c99 -Wall -pedantic'
   alias myip="wget -qO - http://cfaj.freeshell.org/ipaddr.cgi"
   alias noSleep="xset s off; xset -dpms"
   alias nohist="unset HISTFILE"
   alias oom-run="systemd-run --user --pty --same-dir --wait --collect --service-type=exec --quiet --slice=oom.slice"
   alias prm="perl -e 'for(<*>){unlink}'"
   alias quit="exit"
   alias rawsort="LC_ALL=C sort"
   alias rmsvn="find . -name .svn -print0 | xargs -0 rm -rf"
   alias sshx="ssh -XC -c aes256-gcm@openssh.com,aes128-gcm@openssh.com"
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
      alias javaXmem="java -Xmx25G -Xms25G"
      alias javacp="java -cp ./target/classes:\`cat classpath.out\`"
      alias mvncp="mvn dependency:build-classpath -Dmdep.outputFile=classpath.out"

   ## Python stuff
      function venv {
         if [[ ! -e "${GLOBAL_VENV_PATH}" ]] ; then
            python3 -m venv "${GLOBAL_VENV_PATH}"
         fi

         # Check the current venv status.
         if [[ -z "${VIRTUAL_ENV}" ]] ; then
            # We are not in a venv.
            bash --rcfile <(echo ". ${HOME}/.bashrc; source ${GLOBAL_VENV_PATH}/bin/activate")
         else
            # We are in a venv.
            deactivate
            exit
         fi
      }

   ## Vim
      # "VIM No O"
      alias vimno="vim -O1"
      # Readonly
      alias vimr="vim -R"
      # Open multiple files with horizontal splits.
      alias vimo="vim -o"
      # Always open multiple files with vertical splits.
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

   ## Image Encoding
      function optjpg {
         local inFile=$1
         local outFile=$2

         # Install mozjpg.
         # cjpeg -quality 85 -outfile "${outFile}" "${inFile}"
         mozcjpeg -quality 85 -outfile "${outFile}" "${inFile}"
      }

      function optpng {
         local inFile=$1
         local outFile=$2

         pngquant --speed 1 --strip --force --output "${outFile}" "${inFile}"
      }

      # Fetch a PKGBUILD from AUR.
      function aurFetch {
         local package=$1

         wget -O PKGBUILD.${package} "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=${package}"
      }

      function back {
         backDir=`pwd`
         backDir=`basename $backDir`
         backPath="$HOME/back/$backDir"

         rm -Rf "$backPath"
         cp -R $(pwd) "$backPath"
      }

      function findvim {
         target="."
         if [ $# -gt 1 ]; then
            target=$2
         fi

         vim $(find $target -name $1)
      }

      function fullpdflatex {
         pdflatex $1.tex && \
         bibtex $1.aux && \
         pdflatex $1.tex && \
         pdflatex $1.tex
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

      # tar each argument in its own archive.
      function tarAll {
         for path in "$@" ; do
            path=${path%/}

            echo "tar cf ${path}.tar ${path}"
            tar cf "${path}.tar" "${path}"
         done
      }

      function tarReplaceAll {
         for path in "$@" ; do
            path=${path%/}

            echo "tar cf ${path}.tar ${path}"
            tar cf "${path}.tar" "${path}" && rm -Rf "${path}"
         done
      }

      function tarballAll {
         for path in "$@" ; do
            path=${path%/}

            echo "tar zcf ${path}.tar.gz ${path}"
            tar zcf "${path}.tar.gz" "${path}"
         done
      }

      function tarballReplaceAll {
         for path in "$@" ; do
            path=${path%/}

            echo "tar zcf ${path}.tar.gz ${path}"
            tar zcf "${path}.tar.gz" "${path}" && rm -Rf "${path}"
         done
      }

      function zipAll {
         for path in "$@" ; do
            path=${path%/}

            echo "zip -r ${path}.zip ${path}"
            zip -r "${path}.zip" "${path}"
         done
      }

      function zipReplaceAll {
         for path in "$@" ; do
            path=${path%/}

            echo "zip -r ${path}.zip ${path}"
            zip -r "${path}.zip" "${path}" && rm -Rf "${path}"
         done
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

      function webGroupPermissions {
         temp=`pwd`
         if [ $# -ne 0 ];
         then
            temp=$1
         fi

         find $temp -type d -exec chmod 775 {} \;
         find $temp -type f -exec chmod 664 {} \;
      }

      function nasPermissions {
         temp=`pwd`
         if [ $# -ne 0 ];
         then
            temp=$1
         fi

         find $temp -type d -exec chmod 775 {} \;
         find $temp -type f -exec chmod 664 {} \;
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

      function setTime {
         sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
         sudo ntpd -qg
         sudo hwclock -w
      }
