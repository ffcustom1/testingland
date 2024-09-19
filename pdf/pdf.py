import fitz  # PyMuPDF
import subprocess
import os
from tqdm import tqdm  # Import tqdm for progress bars

# Load the PDF
pdf_path = "input.pdf"
intermediate_path = "intermediate_output.pdf"  # Temporary file before compression
output_path = "output.pdf"

# Text to remove from the PDF
text_to_remove = [
    "Download Free IELTS Material, Cue Card Visit website Englishwithroop.com",
    "www.Youtube.com/englishwithroop",
    "www.youtube.com/makkarielts",
    "www.instagram.com/makkarielts",
    "www.makkarielts.com/books",
    "www.makkarielts.com",
    "All rights reserved with the author. It is illegal to share this ebook in public, anyone found doing so might face legal consequences."
]

# Open the PDF
doc = fitz.open(pdf_path)
num_pages = len(doc)

# Iterate through each page to redact text with progress bar
for page_num in tqdm(range(num_pages), desc="Redacting pages", unit="page"):
    page = doc[page_num]
    
    # List to keep track of all text instances to redact
    text_instances = []
    
    for line in text_to_remove:
        instances = page.search_for(line)
        text_instances.extend(instances)
    
    # Add redaction annotations for all found instances
    for inst in text_instances:
        page.add_redact_annot(inst)  # Mark the text for redaction

    # Apply all redactions at once
    page.apply_redactions()

# Save the modified PDF to an intermediate file
doc.save(intermediate_path)
doc.close()

# Compress the PDF using Ghostscript with highest quality
compress_cmd = [
    "gs",
    "-sDEVICE=pdfwrite",
    "-dCompatibilityLevel=1.4",
    "-dPDFSETTINGS=/prepress",  # Highest quality
    "-dNOPAUSE",
    "-dQUIET",
    "-dBATCH",
    "-sOutputFile=" + output_path,
    intermediate_path
]

print("Compressing PDF...")
subprocess.run(compress_cmd)

# Optionally, remove the intermediate file
os.remove(intermediate_path)

print("Processing complete.")
