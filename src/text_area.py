import tkinter as tk

def create_text_area(root):
    text_widget = tk.Text(
        root,
        wrap=tk.WORD,
        undo=True,
        font=('Courier', 20)
    )
    text_widget.pack(expand=True, fill='both')
    return text_widget

def get_text(text_widget):
    return text_widget.get('1.0', tk.END)

def set_text(text_widget, text):
    text_widget.delete('1.0', tk.END)
    text_widget.insert('1.0', text)
