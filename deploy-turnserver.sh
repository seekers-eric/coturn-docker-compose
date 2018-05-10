internalIp="$(ip route get 8.8.8.8 | awk '{print $NF; exit}')"
externalIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"

echo "listening-port=3478
tls-listening-port=5349
listening-ip="$internalIp"
relay-ip="$internalIp"
external-ip="$externalIp"
realm=preprod.seekerscapital.com
server-name=preprod.seekerscapital.com
lt-cred-mech
userdb=/var/lib/turn/turndb
# use real-valid certificate/privatekey files
cert=/etc/ssl/turn_server_cert.pem
pkey=/etc/ssl/turn_server_pkey.pem
 
no-stdout-log"  | tee /etc/turnserver.conf


turnadmin -a -u seekers -p seekers -r preprod.seekerscapital.com

turnserver

echo "TURN server running. IP: "$externalIp" Username: seekers, password: seekers"
