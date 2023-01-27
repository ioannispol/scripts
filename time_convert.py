import tkinter as tk
from tkinter import messagebox

def convert_to_time():
    minutes = int(minutes_entry.get())
    seconds = int(seconds_entry.get())
    milliseconds = int(milliseconds_entry.get())
    convert_to = convert_to_var.get()
    # convert minutes to seconds
    minutes_in_seconds = minutes * 60
    # convert milliseconds to seconds
    milliseconds_in_seconds = milliseconds / 1000
    # add the total seconds
    total_seconds = minutes_in_seconds + seconds + milliseconds_in_seconds
    if convert_to == 'seconds':
        result_label.config(text=f'Total time in seconds: {total_seconds}')
    else:
        total_minutes = total_seconds / 60
        result_label.config(text=f'Total time in minutes: {total_minutes}')

# Create a tkinter window
root = tk.Tk()
root.geometry("400x200")
root.title("Time Converter")

# Create labels for input fields
minutes_label = tk.Label(root, text="Minutes")
minutes_label.grid(row=0, column=0)
seconds_label = tk.Label(root, text="Seconds")
seconds_label.grid(row=1, column=0)
milliseconds_label = tk.Label(root, text="Milliseconds")
milliseconds_label.grid(row=2, column=0)

# Create input fields
minutes_entry = tk.Entry(root)
minutes_entry.grid(row=0, column=1)
seconds_entry = tk.Entry(root)
seconds_entry.grid(row=1, column=1)
milliseconds_entry = tk.Entry(root)
milliseconds_entry.grid(row=2, column=1)

# Create a label for the convert_to option
convert_to_label = tk.Label(root, text="Convert To")
convert_to_label.grid(row=3, column=0)

# Create a option menu for convert_to
convert_to_var = tk.StringVar(root)
convert_to_var.set("seconds")
convert_to_option = tk.OptionMenu(root, convert_to_var, "seconds", "minutes")
convert_to_option.grid(row=3, column=1)

# Create a button to convert time
convert_button = tk.Button(root, text="Convert", command=convert_to_time)
convert_button.grid(row=4, column=1)

# Create a label to display the result
result_label = tk.Label(root, text="")
result_label.grid(row=5, column=1)

# Start the tkinter event loop
root.mainloop()
