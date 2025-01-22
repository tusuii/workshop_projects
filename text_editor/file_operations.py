from tkinter import filedialog, messagebox
import os

current_file = None

def new_file(text_area):
    global current_file
    if text_area.edit_modified():
        response = messagebox.askyesnocancel("Save Changes", "Do you want to save changes?")
        if response is None:  # Cancel
            return
        if response:  # Yes
            save_file(text_area)
    
    text_area.delete(1.0, "end")
    text_area.edit_modified(False)
    current_file = None

def open_file(text_area):
    global current_file
    if text_area.edit_modified():
        response = messagebox.askyesnocancel("Save Changes", "Do you want to save changes?")
        if response is None:  # Cancel
            return
        if response:  # Yes
            save_file(text_area)
    
    file_path = filedialog.askopenfilename(
        defaultextension=".txt",
        filetypes=[
            ("Text Files", "*.txt"),
            ("Python Files", "*.py"),
            ("All Files", "*.*")
        ]
    )
    
    if file_path:
        try:
            with open(file_path, 'r', encoding='utf-8') as file:
                text_area.delete(1.0, "end")
                text_area.insert(1.0, file.read())
                current_file = file_path
                text_area.edit_modified(False)
        except Exception as e:
            messagebox.showerror("Error", f"Could not open file: {str(e)}")

def save_file(text_area):
    global current_file
    if current_file:
        try:
            with open(current_file, 'w', encoding='utf-8') as file:
                file.write(text_area.get(1.0, "end-1c"))
                text_area.edit_modified(False)
                return True
        except Exception as e:
            messagebox.showerror("Error", f"Could not save file: {str(e)}")
            return False
    else:
        return save_file_as(text_area)

def save_file_as(text_area):
    global current_file
    file_path = filedialog.asksaveasfilename(
        defaultextension=".txt",
        filetypes=[
            ("Text Files", "*.txt"),
            ("Python Files", "*.py"),
            ("All Files", "*.*")
        ]
    )
    
    if file_path:
        current_file = file_path
        return save_file(text_area)
    return False
