from tkinter import filedialog, messagebox

def save_file(content):
    try:
        file_path = filedialog.asksaveasfilename(
            title="Save your file",
            defaultextension=".txt",
            filetypes=[
                ("Text files", "*.txt"),
                ("Python files", "*.py"),
                ("All files", "*.*")
            ]
        )
        
        if file_path:
            with open(file_path, 'w') as file:
                file.write(content)
            messagebox.showinfo("Success", "File saved successfully!")
            return True
        return False
        
    except Exception as e:
        messagebox.showerror("Error", f"Could not save the file:\n{str(e)}")
        return False
