import tkinter as tk
from tkinter import messagebox
from src.file_operations import save_file
from src.text_area import get_text

def create_menu_bar(root, text_widget):
    menu_bar = tk.Menu(root)
    root.config(menu=menu_bar)
    
    file_menu = tk.Menu(menu_bar, tearoff=0)
    menu_bar.add_cascade(label="File", menu=file_menu)
    
    file_menu.add_command(label="Save", command=lambda: save_text(text_widget))
    file_menu.add_separator()
    file_menu.add_command(label="Exit", command=root.quit)

    help_menu = tk.Menu(menu_bar, tearoff=0)
    menu_bar.add_cascade(label="Help", menu=help_menu)
    help_menu.add_command(label="About", command=show_about)
    
    return menu_bar

def save_text(text_widget):
    content = get_text(text_widget)
    save_file(content)

def show_about():
    messagebox.showinfo(
        "About Simple Text Editor in python",
        "Simple Text Editor v1.0\n\n" +
        "A lightweight text editor for quick notes and coding.\n" +
        "Features:\n" +
        "- Simple and clean interface\n" +
        "- Easy text editing\n" +
        "- Quick file saving"
    )
