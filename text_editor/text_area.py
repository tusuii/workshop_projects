import tkinter as tk
from tkinter import ttk

def create_text_area(parent):
    # Create frame to hold text area
    frame = tk.Frame(parent)
    frame.pack(side=tk.TOP, expand=True, fill=tk.BOTH)

    # Create main text area with scrollbar
    text_area = tk.Text(frame, wrap=tk.WORD, undo=True,
                       font=('Arial', 12))
    scrollbar = ttk.Scrollbar(frame, orient=tk.VERTICAL, command=text_area.yview)
    text_area.configure(yscrollcommand=scrollbar.set)
    
    # Pack scrollbar and text area
    scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
    text_area.pack(side=tk.LEFT, expand=True, fill=tk.BOTH)
    
    return text_area
