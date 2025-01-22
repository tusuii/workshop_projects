import tkinter as tk
from tkinter import filedialog, messagebox
import file_operations

def create_menu_bar(root, text_area):
    menubar = tk.Menu(root)
    root.config(menu=menubar)

    def create_menus(text_widget):
        nonlocal text_area
        text_area = text_widget

        # File Menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="New", accelerator="Ctrl+N", 
                            command=lambda: file_operations.new_file(text_area))
        file_menu.add_command(label="Open", accelerator="Ctrl+O", 
                            command=lambda: file_operations.open_file(text_area))
        file_menu.add_command(label="Save", accelerator="Ctrl+S", 
                            command=lambda: file_operations.save_file(text_area))
        file_menu.add_command(label="Save As", accelerator="Ctrl+Shift+S", 
                            command=lambda: file_operations.save_file_as(text_area))
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=lambda: exit_editor(root, text_area))

        # Edit Menu
        edit_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Edit", menu=edit_menu)
        edit_menu.add_command(label="Undo", accelerator="Ctrl+Z", 
                            command=lambda: text_area.edit_undo())
        edit_menu.add_command(label="Redo", accelerator="Ctrl+Y", 
                            command=lambda: text_area.edit_redo())
        edit_menu.add_separator()
        edit_menu.add_command(label="Cut", accelerator="Ctrl+X", 
                            command=lambda: text_area.event_generate("<<Cut>>"))
        edit_menu.add_command(label="Copy", accelerator="Ctrl+C", 
                            command=lambda: text_area.event_generate("<<Copy>>"))
        edit_menu.add_command(label="Paste", accelerator="Ctrl+V", 
                            command=lambda: text_area.event_generate("<<Paste>>"))
        edit_menu.add_separator()
        edit_menu.add_command(label="Select All", accelerator="Ctrl+A", 
                            command=lambda: text_area.tag_add("sel", "1.0", "end"))

        # Help Menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="About", command=lambda: show_about(root))

    menubar.setup_text_area = create_menus
    return menubar

def show_about(root):
    about_window = tk.Toplevel(root)
    about_window.title("About Simple Text Editor")
    about_window.geometry("300x150")
    about_window.resizable(False, False)
    about_window.transient(root)
    about_window.grab_set()
    
    label = tk.Label(about_window, text="Simple Text Editor\nVersion 1.0\n\nA basic text editor created with Python and Tkinter",
                     justify=tk.CENTER, padx=20, pady=20)
    label.pack()
    
    ok_button = tk.Button(about_window, text="OK", command=about_window.destroy)
    ok_button.pack(pady=10)

def exit_editor(root, text_area):
    if text_area.edit_modified():
        response = messagebox.askyesnocancel("Save Changes", "Do you want to save changes?")
        if response is None:  # Cancel
            return
        if response:  # Yes
            if not file_operations.save_file(text_area):
                return  # Don't exit if save was cancelled
    root.quit()
