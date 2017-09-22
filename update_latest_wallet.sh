if [[ $UID != 0 ]]; then
	echo "Please run this script with sudo"
	echo "sudo $0 $*"
	exit 1
fi

killall whitecoin-qt
sudo apt-get -y install qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools \
    build-essential libboost-dev libboost-system-dev \
    libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev \
    libssl-dev libdb++-dev libminiupnpc-dev libqrencode-dev
mkdir /tmp/wc_update
cd /tmp/wc_update
git clone https://github.com/Whitecoin-org/Whitecoin.git Whitecoin
cd Whitecoin
qmake
make
rm -f /usr/bin/whitecoin-qt
cp whitecoin-qt /usr/bin/
chmod 777 /usr/bin/whitecoin-qt
cd ~
rm -rf /tmp/wc_update
echo "ALL DONE !"
