# PPT Crop for Papers

> [中文版](README_zh.md) | English

This is an automated workflow script for academic writing that exports PDFs from PowerPoint, performs image cropping, and automatically syncs files to Google Drive and Overleaf.

## Features

- **Automatic PDF Export**: Automatically export cropped high-quality PDF files from Microsoft PowerPoint
- **Image Cropping**: Call external scripts to crop PDF white borders
- **File Synchronization**: Automatically sync processed files to Google Drive and Overleaf
- **Timestamp Naming**: Generated files include timestamps for easy version management

## Usage

### 1. Prerequisites

- macOS system
- Microsoft PowerPoint
- Alfred (for workflow automation)
- pdfcropmargins and pdfcrop tools (for PDF cropping)
- Google Drive (for file synchronization)

### Install Dependencies

```bash
# Install PDF cropping tools (macOS)
brew install pdfcropmargins
brew install pdfcrop

# Or use conda
conda install -c conda-forge pdfcropmargins
```

### 2. Configure Script Variables

Modify the following paths in `for_alfred.applescript`:

```applescript
# Modify paths in this line:
# /path/to/crop_pdf.sh - Replace with the actual path to crop_pdf.sh
# /path/to/pdf - Replace with the PDF output directory path
# /path/to/google_drive/ - Replace with the Google Drive directory path
# /path/to/pptx/ - Replace with the PPTX file directory path

set commandString to "/path/to/crop_pdf.sh /path/to/pdf" & pdfName & ".pdf /path/to/google_drive/MMCL3.pdf; rsync -av /path/to/pptx/MMCL32.pptx /path/to/google_drive/; "
```

### 3. PowerPoint Keyboard Shortcut Setup

PowerPoint requires setting up a keyboard shortcut for PDF export:
1. Open Settings -> Keyboard Shortcuts -> App Shortcuts
3. Set shortcut to `Command + Shift + E`

### 4. Run Script

Create a workflow in Alfred and call `for_alfred.applescript` to complete the entire process with one click. You can also run the script directly without Alfred to crop PPT to PDF.
![alt text](<assets/Alfred workflow.png>)
![alt text](<assets/Alfred example.png>)

## File Description

- `for_alfred.applescript`: Main automation script that controls PowerPoint and terminal operations via AppleScript
- `crop_pdf.sh`: PDF cropping script with two-step cropping logic (white border removal + gray frame cropping)
- `Placeholder.pptx`: PowerPoint template example showing correct gray frame design

## Notes

- Ensure all paths are configured correctly to avoid file operation failures
- Scripts include delay operations to ensure applications have enough time to respond
- If Google Drive paths are long, string concatenation logic may need adjustment

## Troubleshooting

### PDF Export Failure
- Check that the keyboard shortcut (Command + Shift + E) is correctly set in PowerPoint, manual setup required on Mac
- Ensure a PowerPoint document is currently open

### Cropping Script Error
- Confirm `pdfcropmargins` and `pdfcrop` tools are installed
- Check if input file paths exist
- Verify output directory permissions

### Google Drive Sync Failure
- Check if Google Drive path configuration is correct
- Confirm sufficient disk space
- Verify network connection

### Script Unresponsive
- Check that all applications are properly installed
- Try increasing delay times in scripts
- Check system logs for specific errors

## PPT Template Design Details

The project provides a `Placeholder.pptx` example file demonstrating how to design PPT templates for automatic cropping:

**Template Structure**:
- Outer gray frame indicates the area boundary to be cropped
- Inner gray frame (optional) represents the specific content area of images
- Colors can be adjusted according to personal preferences, but avoid colors that are too light to ensure proper detection by cropping scripts

**Cropping Principle**:
The first crop removes all white margins until encountering colored areas. If the color is too light, the script may not detect the boundary accurately. I chose gray because it is neither too prominent nor interferes with drawing creation.

The second crop further removes the gray frame (3-point margin), ultimately preserving the complete internal image. Since PPT supports multi-page alignment, you can copy gray frames to each page and align positions precisely, making it easy to create large images composed of multiple images.

It is precisely because manual cropping is too cumbersome each time that I developed this automation script, hoping to improve efficiency for everyone's academic writing.

## Detailed Workflow

1. **Automatic PDF Export**: Script simulates keyboard shortcut (Command + Shift + E) to export PDF with best printing quality
2. **Timestamp Naming**: Generated filename format is `MMCL3-YYYY-MM-DD-HH-MM-SS.pdf`, ensuring unique versions for each modification
3. **PDF Cropping**: Call `crop_pdf.sh` script for white border and gray frame cropping
4. **File Synchronization**:
   - Sync processed PDF to Google Drive
   - Sync original PPTX file to Google Drive for version management
5. **Activate Browser**: Open Firefox for subsequent Overleaf page viewing

## Using in Overleaf

1. Set Google Drive PDF files to public sharing
2. Use External URL in Overleaf to link to the PDF
3. Images in the paper update automatically after Overleaf refreshes

## Version Management Suggestions

Google Drive automatically records file modification history, but version retention has time limits. It is recommended to manually save important versions before major modifications.

## Contributing & Feedback

If you find this tool useful, please consider giving it a ⭐ star on GitHub!

If this tool brings convenience to your work, welcome to visit my [personal homepage](https://lucydyu.github.io/) where we can further exchange ideas and explore collaboration opportunities.

I'm always open to discussions and collaborations!
