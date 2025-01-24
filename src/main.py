import tkinter as tk
from src.text_area import create_text_area
from src.menu_bar import create_menu_bar

def main():
    root = tk.Tk()
    root.title("Simple Text Editor")
    root.geometry("800x600")
    
    text_widget = create_text_area(root)
    create_menu_bar(root, text_widget)
    
    root.mainloop()

if __name__ == "__main__":
    main()
