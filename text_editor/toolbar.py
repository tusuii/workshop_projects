import tkinter as tk
from tkinter import font

def create_toolbar(parent):
    # Create a frame for the toolbar with a border
    toolbar = tk.Frame(parent, bd=1, relief=tk.RAISED)
    toolbar.pack(side=tk.TOP, fill=tk.X)
    
    # Font size selector
    sizes = [8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72]
    font_size = tk.StringVar(parent)
    font_size.set("12")  # default size
    
    size_label = tk.Label(toolbar, text="Size:")
    size_label.pack(side=tk.LEFT, padx=(2, 0))
    
    size_menu = tk.OptionMenu(toolbar, font_size, *sizes)
    size_menu.config(width=3)
    size_menu.pack(side=tk.LEFT, padx=2, pady=2)
    
    # Add a small separator
    tk.Frame(toolbar, width=2, bd=1, relief=tk.SUNKEN).pack(side=tk.LEFT, padx=5, fill=tk.Y)
    
    # Bold button
    bold_button = tk.Button(toolbar, text="B", width=2, relief=tk.RAISED)
    bold_button.pack(side=tk.LEFT, padx=2, pady=2)
    
    # Italic button
    italic_button = tk.Button(toolbar, text="I", width=2, relief=tk.RAISED)
    italic_button.pack(side=tk.LEFT, padx=2, pady=2)
    
    # Underline button
    underline_button = tk.Button(toolbar, text="U", width=2, relief=tk.RAISED)
    underline_button.pack(side=tk.LEFT, padx=2, pady=2)
    
    def apply_font_size(*args):
        current_font = font.Font(font=text_area['font'])
        text_area.configure(font=(current_font.actual()['family'], font_size.get()))

    def setup_text_area(text_widget):
        global text_area
        text_area = text_widget
        
        # Configure button commands after text_area is set
        bold_button.config(command=lambda: toggle_bold(text_area))
        italic_button.config(command=lambda: toggle_italic(text_area))
        underline_button.config(command=lambda: toggle_underline(text_area))
        font_size.trace('w', apply_font_size)
    
    toolbar.setup_text_area = setup_text_area
    return toolbar

def toggle_bold(text_area):
    try:
        current_tags = text_area.tag_names("sel.first")
        if "bold" in current_tags:
            text_area.tag_remove("bold", "sel.first", "sel.last")
        else:
            text_area.tag_add("bold", "sel.first", "sel.last")
            text_area.tag_configure("bold", font=font.Font(weight="bold"))
    except tk.TclError:
        # No text selected
        pass

def toggle_italic(text_area):
    try:
        current_tags = text_area.tag_names("sel.first")
        if "italic" in current_tags:
            text_area.tag_remove("italic", "sel.first", "sel.last")
        else:
            text_area.tag_add("italic", "sel.first", "sel.last")
            text_area.tag_configure("italic", font=font.Font(slant="italic"))
    except tk.TclError:
        # No text selected
        pass

def toggle_underline(text_area):
    try:
        current_tags = text_area.tag_names("sel.first")
        if "underline" in current_tags:
            text_area.tag_remove("underline", "sel.first", "sel.last")
        else:
            text_area.tag_add("underline", "sel.first", "sel.last")
            text_area.tag_configure("underline", underline=1)
    except tk.TclError:
        # No text selected
        pass
