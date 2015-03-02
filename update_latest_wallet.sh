if [[ $UID != 0 ]]; then
	echo "Please run this script with sudo"
	echo "sudo $0 $*"
	exit 1
fi

killall whitecoin-qt
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
