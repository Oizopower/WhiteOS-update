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

git clone https://github.com/glassechidna/zxing-cpp.git
cd zxing-cpp && mkdir build && cd build
export CXXFLAGS="-fPIC"
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ..
make && sudo make install

git clone https://github.com/Whitecoin-org/Whitecoin.git Whitecoin
cd Whitecoin

git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag
qmake
make
rm -f /usr/bin/whitecoin-qt
cp whitecoin-qt /usr/bin/
chmod 777 /usr/bin/whitecoin-qt
cd ~
rm -rf /tmp/wc_update
echo "ALL DONE !"
