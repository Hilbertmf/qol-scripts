#!/bin/bash
# In this script we're gonna go recursively through directories



name="Hey"

main() {
    # no input
    if (($# < 1)); then
        print_usage
        exit 1
    fi

    # get flags
    recursive_flag=0

    while getopts "r:h" flag; do
        case $flag in
            r) recursive_flag=1 ;;
            h) print_usage; exit ;;
        esac
    done
    shift $((OPTIND -1)) # Remove as flags processadas, sobra o caminho

    if(( recursive_flag > 0 )); then
        # se passou o argumento do diretorio, usa ele, senão usa o atual
        target_path="${1:-$(pwd)}"
        root_dir=$(readlink -f "$target_path")
        stack=("$root_dir")

        while ((${#stack[@]} > 0)) ; do

            cur_idx=$(( ${#stack[@]} - 1)) # grab cur idx
            cur="${stack[$cur_idx]}" # stack.top()
            unset "stack[$cur_idx]" #pop()

            cd "$cur" || continue
            videos_to_compress=()

            for item in *; do
                if [[ -d "$item" && "$item" != compressed ]]; then
                    echo "explorando $item..."
                    stack+=("$(pwd)/$item")
                elif [[ -f "$item" && ("$item" == *.mp4 || "$item" == *.mkv || "$item" == *.avi || "$item" == *.mov) && "$item" != *_compressed.mkv ]]; then
                    echo "Found a video: $item"
                    videos_to_compress+=("$item")
                fi
            done
            
            # if list not empty we have videos to compress
            if (( ${#videos_to_compress[@]} != 0 )); then
                mkdir -p compressed
                for video in "${videos_to_compress[@]}"; do
                    local output_file="${video%.*}_compressed.mkv"
                    compress_video "$video" "compressed/$output_file"
                done
            fi
        
        # cd - > /dev/null

        done

    fi
}

compress_video() {
    local video="$1"
    local output="$2"
    local file="$1"
    echo "Converting $file..."
    ffmpeg -i "$video" \
    -vcodec libx265 \
    -crf 28 \
    -preset slow \
    -vf "scale='min(1920,iw)':-2" \
    -map 0 \
    -acodec aac -b:a 128k \
    -tag:v hvc1 \
    "$output" -y

}

print_usage() {

    echo "Usage:
    run ./compress_videos.sh -r 1 <direcoty_path>"
}


main "$@"; exit