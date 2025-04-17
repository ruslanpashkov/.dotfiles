#!/bin/bash

# Script to find all audio files and remove metadata from them
# Supported formats: .wav, .mp3, .ogg, .flac
# Usage: ./script.sh [directory_path]
# If no directory is specified, the current directory will be used

# Default search directory is current directory
SEARCH_DIR="."

# If a directory argument is provided, use that instead
if [ "$1" ]; then
    if [ -d "$1" ]; then
        SEARCH_DIR="$1"
    else
        echo "Error: '$1' is not a valid directory"
        exit 1
    fi
fi

# Check if required tools are installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first."
    echo "On Debian/Ubuntu: sudo apt install ffmpeg"
    echo "On macOS with Homebrew: brew install ffmpeg"
    exit 1
fi

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]; then
    echo "Error: Could not create temporary directory"
    exit 1
fi

# Cleanup function to remove temporary directory
cleanup() {
    rm -rf "$TEMP_DIR"
}

# Register the cleanup function to be called on exit
trap cleanup EXIT

# Find all audio files and process them
echo "Searching for audio files in: $SEARCH_DIR"
find "$SEARCH_DIR" -type f \( -name "*.wav" -o -name "*.mp3" -o -name "*.ogg" -o -name "*.flac" \) | while read -r file; do
    echo "Processing: $file"
    
    # Get file extension
    ext="${file##*.}"
    # Get filename without path
    filename=$(basename "$file")
    # Create temporary output file path
    temp_output="$TEMP_DIR/$filename"
    
    # Remove metadata based on file type
    case "$ext" in
        mp3)
            # For MP3 files, use ffmpeg to strip metadata
            ffmpeg -i "$file" -map_metadata -1 -c:a copy "$temp_output" -y 2>/dev/null
            ;;
        wav)
            # For WAV files
            ffmpeg -i "$file" -map_metadata -1 -c:a copy "$temp_output" -y 2>/dev/null
            ;;
        ogg)
            # For OGG files
            ffmpeg -i "$file" -map_metadata -1 -c:a copy "$temp_output" -y 2>/dev/null
            ;;
        flac)
            # For FLAC files
            ffmpeg -i "$file" -map_metadata -1 -c:a copy "$temp_output" -y 2>/dev/null
            ;;
        *)
            echo "Unsupported file type: $ext"
            continue
            ;;
    esac
    
    # Check if ffmpeg was successful
    if [ $? -eq 0 ]; then
        # Replace original file with the metadata-free version
        mv "$temp_output" "$file"
        echo "✓ Metadata removed from: $file"
    else
        echo "× Failed to process: $file"
    fi
done

echo "All audio files processed in $SEARCH_DIR."

