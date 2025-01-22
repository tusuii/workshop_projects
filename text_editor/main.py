import tkinter as tk
from menubar import create_menu_bar
from toolbar import create_toolbar
from text_area import create_text_area
import file_operations

def main():
    # Create main window
    root = tk.Tk()
    root.title("Simple Text Editor")
    root.geometry("800x600")

    # Create main container
    main_container = tk.Frame(root)
    main_container.pack(expand=True, fill=tk.BOTH)

    # Create menu bar
    menu_bar = create_menu_bar(root, None)  # We'll set text_area later

    # Create toolbar
    toolbar = create_toolbar(main_container)

    # Create text area
    text_area = create_text_area(main_container)

    # Set up toolbar with text area reference
    toolbar.setup_text_area(text_area)

    # Update menu bar with text area reference
    menu_bar.setup_text_area(text_area)

    # Configure keyboard shortcuts
    root.bind('<Control-n>', lambda e: file_operations.new_file(text_area))
    root.bind('<Control-o>', lambda e: file_operations.open_file(text_area))
    root.bind('<Control-s>', lambda e: file_operations.save_file(text_area))
    root.bind('<Control-S>', lambda e: file_operations.save_file_as(text_area))

    # Start the application
    root.mainloop()

if __name__ == "__main__":
    main()
