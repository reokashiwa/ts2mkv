#/bin/sh

FFMPEG='/opt/local/bin/ffmpeg'
if [ -p /dev/stdin ];then
  INPUT=`cat -`
else
  INPUT=`echo $@`
fi
FILENAME=`echo $INPUT|sed 's/\.ts$//'`

if [ ! -e "${FILENAME}.mkv" ]; then
  $FFMPEG -i "${FILENAME}.ts" \
    -fpre x264_main.ffpreset \
    -pass 1 \
    -filter:v yadif \
    -flags +loop+global_header \
    -vcodec hevc_videotoolbox \
    -acodec copy \
    -bsf:a aac_adtstoasc \
    -map 0:0 \
    -map 0:1 \
    "${FILENAME}.mkv" 
fi
