# 🍲 SoupCon LaTeX Proceedings

A modular LaTeX framework designed to generate beautiful culinary proceedings. This system isolates the visual "engine" (styling and logic) from the unique content of individual book volumes.

## Project Structure

The repository is organized to allow multiple "editions" to coexist while sharing the same core design.

```
.
├── main.tex                        # Entry point; sets the current edition path
├── anthology.cls                   # Core style definitions and \recipe logic
├── .gitignore                      # White-list configuration for Git tracking
└── editions/                       # Container for all unique volumes
    └── [edition_name]/             # Example: soupcon_2024
        ├── foreword.tex            # Introduction for this specific book
        ├── recipes/                # Individual .tex recipe files
        │   └──receipe_manifest.tex # Manifest file importing all recipes in order
        └── images/                 # Recipe photos and edition-specific assets
```

---

## 🚀 How to Build a New Edition

### 1. Set the Target Edition
Open `main.tex` and update the `\editionname` variable to match your folder name in `editions/`:
\newcommand{\editionname}{soupcon_2024}

### 2. Adding a Recipe
Create a .tex file in your edition's recipes/ folder. Use the 8-argument \recipe command:

```
\recipe{Recipe Name}            % #1 Name
       {Submitter Name}         % #2 Submitter
       {Abstract text...}       % #3 Short story/blurb
       {\ingredients{...}}      % #4 Ingredients list
       {\instructions{...}}     % #5 Instructions list
       {Optional notes...}      % #6 Notes (leave {} if empty)
       {filename.jpg}           % #7 Image filename (no path needed)
       {Category}               % #8 TOC Group (e.g., Soups, Mains)
```

### 3. Updating the Manifest
To include the recipe in the PDF, add it to editions/[edition_name]/recipe_manifest.tex. The order of \input commands in this file determines the order in the book.

---

## ⚠️ Known Issues & Troubleshooting
* Image not found: Ensure the image is inside the images/ subfolder of your current edition, and that you haven't included images/ in the filename argument.
