#!/bin/bash

mkdir -p /mnt/ramdisk/logs
mkdir -p /mnt/ramdisk/stream

# Function to clean up background processes
cleanup() {
    echo "Stopping HTTP server..."
    kill $HTTP_SERVER_PID 2>/dev/null
    echo "Stopping FFmpeg..."
    kill $FFMPEG_PID 2>/dev/null
    echo "Stopping VLC..."
    kill $VLC_LOOP_PID 2>/dev/null
    pkill -P $VLC_LOOP_PID
    echo "Cleanup completed."
    exit 0
}

# Trap SIGINT and SIGTERM to clean up
trap cleanup SIGINT SIGTERM

# Start the HTTP server
echo "Starting HTTP server..."
python3 /home/kubbur/http_server.py > /mnt/ramdisk/logs/http_server.log 2>&1 &
HTTP_SERVER_PID=$!
echo "HTTP server started with PID $HTTP_SERVER_PID"

# Wait for the HTTP server to fully start
sleep 5

# Start FFmpeg
echo "Starting FFmpeg..."
nohup ffmpeg -f x11grab -s 1024x600 -r 10 -i :0.0 \
    -vcodec libx264 -pix_fmt yuv420p -preset ultrafast -tune zerolatency \
    -crf 35 -movflags +faststart -x264-params keyint=10:scenecut=0 \
    -b:v 512k -f hls -hls_time 1 -hls_list_size 3 -hls_wrap 15 \
    -start_number 1 -hls_playlist_type event \
    /mnt/ramdisk/stream/stream.m3u8 > /mnt/ramdisk/logs/ffmpeg.log 2>&1 &
FFMPEG_PID=$!
echo "FFmpeg started with PID $FFMPEG_PID"

# Wait for FFmpeg to fully start
sleep 5

# Function to start VLC and handle reconnection
start_vlc() {
    while true; do
        echo "Starting VLC..."
        cvlc --network-caching=2000 --sout "#chromecast{ip=192.168.18.17}" http://192.168.18.10:8091/stream/stream.m3u8 > /mnt/ramdisk/logs/vlc.log 2>&1
        echo "VLC exited. Restarting in 10 seconds..."
        sleep 10
    done
}

# Start VLC with reconnection handling in a subshell to easily kill it
(start_vlc) &
VLC_LOOP_PID=$!
echo "VLC started with PID $VLC_LOOP_PID"

# Wait indefinitely
while true; do
    sleep 60 &
    wait $!
done
