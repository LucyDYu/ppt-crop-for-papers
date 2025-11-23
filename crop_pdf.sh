#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi
# 例子
# Step 1: ppt to pdf
# Step 2: terminal run ./crop_pdf.sh /path/to/Placeholder.pdf  /path/to/Placeholder_out

# Set the input and output file names from the command-line arguments
INPUT_FILE="$1"
OUTPUT_FILE="$2"
OUTPUT_FILE_intermediate="${OUTPUT_FILE%.*}_intermediate.pdf"

# Step 1: Use pdfcropmargins to crop the margins, keep by 0% (crop all).
# 100 means keep all.
pdfcropmargins -p 0 "$INPUT_FILE" -o "$OUTPUT_FILE_intermediate"

# Step 2: Use pdfcrop to further crop the margins by -3 points on all sides
crop_margin="-3"
pdfcrop --margins "$crop_margin" "$OUTPUT_FILE_intermediate" "$OUTPUT_FILE"

# pdfcrop --margins '-3 -3 -3 -3' "$OUTPUT_FILE_intermediate" "$OUTPUT_FILE"

echo "Cropping complete. Output saved to $OUTPUT_FILE."
