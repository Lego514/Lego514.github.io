#!/usr/bin/env bash
# Turn one generated Lego clip into the two files the page plays (LEGO_ANIMATION.md §4).
#
#   tools/lego_clip.sh <id> <raw.mp4> [white_point]
#
# <id> is the figure's data-lego name (coding, basketball, surf, dive, photo); its still
# img/lego/lego-<id>-*.webp sets the output size. The clip is scaled and padded with white to
# that size, near-white is pushed to pure white (white_point, default 0.92) so the page's
# multiply/darken blend leaves no box, and it is encoded as VP9 WebM + H.264 MP4, silent, 24 fps.
# If the last frame does not match the first, pass PINGPONG=1 to play it forward then back.
# Check the result against the still before wiring it in (see §6).
set -euo pipefail
id=${1:?usage: tools/lego_clip.sh <id> <raw.mp4> [white_point]}
raw=${2:?raw clip path}
wp=${3:-0.92}
root=$(cd "$(dirname "$0")/.." && pwd)
case "$id" in   # the still each figure shows on the page
  coding|surf) view=side ;;
  basketball|dive|photo) view=front ;;
  *) echo "unknown id: $id" >&2; exit 1 ;;
esac
still="$root/img/lego/lego-$id-$view.webp"
[ -f "$still" ] || { echo "missing $still" >&2; exit 1; }
command -v cygpath >/dev/null && still=$(cygpath -w "$still")
size=$(python -c "from PIL import Image; w,h=Image.open(r'$still').size; print(f'{w}:{h}')")
w=${size%:*}; h=${size#*:}
w=$(( w + w % 2 )); h=$(( h + h % 2 ))   # H.264 needs even sizes; the extra pixel is white
loop="[0:v]"
[ "${PINGPONG:-0}" = 1 ] && loop="[0:v]split[a][b];[b]reverse[r];[a][r]concat=n=2:v=1:a=0,"
vf="${loop}fps=24,scale=${w}:${h}:force_original_aspect_ratio=decrease,pad=${w}:${h}:(ow-iw)/2:(oh-ih)/2:white,curves=all='0/0 ${wp}/1 1/1',format=yuv420p"
out="$root/img/lego/$id"
ffmpeg -v error -y -i "$raw" -an -filter_complex "$vf" -c:v libvpx-vp9 -crf 34 -b:v 0 -row-mt 1 "$out.webm"
ffmpeg -v error -y -i "$raw" -an -filter_complex "$vf" -c:v libx264 -crf 26 -preset slow -movflags +faststart "$out.mp4"
ls -l "$out.webm" "$out.mp4"
echo "budget: 400 KB each; raise -crf or drop to 20 fps if over."
