#!/bin/bash

############################################################
#region removeStuff
systemctl stop sentinel-backend.socket
systemctl stop sentinel-backend.service
systemctl stop sentinel-backend.path

rm /run/sentinel-backend.sk

#endregion

############################################################
#region copyStuff
cp sentinel-backend.service /etc/systemd/system/
cp sentinel-backend.socket /etc/systemd/system/
cp sentinel-backend.path /etc/systemd/system/
cp restart-sentinel-backend.service /etc/systemd/system/

cp nginx-config /etc/nginx/servers/sentinel-backend

#endregion

############################################################
./mount-files.sh

############################################################
#region reloadAnd(Re)start
systemctl daemon-reload
systemctl start sentinel-backend.socket
systemctl start sentinel-backend.path

nginx -s reload

#endregion
