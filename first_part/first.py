from tkinter import *
from tkinter import messagebox, ttk
from PIL import Image, ImageTk
import mysql.connector

# MySQL connection
def connect_to_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Adgjmerve8118.",
        database="database_project"
    )

# Fetch movies from the database
def fetch_movies():
    try:
        con = connect_to_db()
        cursor = con.cursor()
        query = "SELECT title, duration, genre, release_date FROM movies"
        cursor.execute(query)
        movies = cursor.fetchall()
        con.close()
        return movies
    except mysql.connector.Error as err:
        print(f"Database error: {err}")
        return []

# Fetch detailed movie information from the database
def fetch_movie_details(title):
    try:
        con = connect_to_db()
        cursor = con.cursor()
        query = """
            SELECT title, genre, duration, director, actors, rating, release_date
            FROM movies
            WHERE title = %s
        """
        cursor.execute(query, (title,))
        movie_details = cursor.fetchone()
        con.close()
        return movie_details
    except mysql.connector.Error as err:
        print(f"Database error: {err}")
        return None

# Fetch available dates for a movie
def fetch_dates_for_movie(title):
    try:
        con = connect_to_db()
        cursor = con.cursor()
        query = """
            SELECT DISTINCT DATE(show_datetime) AS show_date
            FROM showtime
            WHERE movie_id = (SELECT movie_id FROM movies WHERE title = %s)
            ORDER BY show_date
        """
        cursor.execute(query, (title,))
        dates = cursor.fetchall()
        con.close()
        return [date[0].strftime('%Y-%m-%d') for date in dates]
    except mysql.connector.Error as err:
        print(f"Database error: {err}")
        return []

def fetch_times_for_movie(title, selected_date):
    try:
        con = connect_to_db()
        cursor = con.cursor()
        query = """
            SELECT TIME(show_datetime) AS show_time
            FROM showtime
            WHERE movie_id = (SELECT movie_id FROM movies WHERE title = %s)
              AND DATE(show_datetime) = %s
            ORDER BY show_time
        """
        cursor.execute(query, (title, selected_date))
        times = cursor.fetchall()
        con.close()
        return [str(time[0]) for time in times]
    except mysql.connector.Error as err:
        print(f"Database error: {err}")
        return []

def book_ticket(title):
    def select_date():
        dates = fetch_dates_for_movie(title)
        if not dates:
            messagebox.showerror("Error", "No dates available for this movie.")
            return

        date_window = Toplevel(root)
        date_window.title("Select Date")
        date_window.geometry("600x400")

        Label(date_window, text="Select a Date:", font=("Times New Roman", 14)).pack(pady=10)
        date_listbox = Listbox(date_window, font=("Times New Roman", 12), height=10)
        for date in dates:
            date_listbox.insert(END, date)
        date_listbox.pack(pady=20)

        def select_time():
            selected_date = date_listbox.get(ACTIVE)
            if not selected_date:
                messagebox.showerror("Error", "Please select a date.")
                return

            times = fetch_times_for_movie(title, selected_date)
            if not times:
                messagebox.showerror("Error", "No times available for the selected date.")
                return

            time_window = Toplevel(date_window)
            time_window.title("Select Time")
            time_window.geometry("600x400")

            Label(time_window, text=f"Select a Time for {selected_date}:", font=("Times New Roman", 14)).pack(pady=10)
            time_listbox = Listbox(time_window, font=("Times New Roman", 12), height=10)
            for time in times:
                time_listbox.insert(END, time)
            time_listbox.pack(pady=20)

            def select_seat():
                selected_time = time_listbox.get(ACTIVE)
                if not selected_time:
                    messagebox.showerror("Error", "Please select a time.")
                    return

                time_window.destroy()
                date_window.destroy()

                seat_window = Toplevel(root)
                seat_window.title("Select Seats")
                seat_window.geometry("800x600")

                Label(seat_window, text=f"Select seats for {title} on {selected_date} at {selected_time}:", font=("Times New Roman", 14)).pack(pady=10)

                seat_frame = Frame(seat_window)
                seat_frame.pack(pady=20)

                rows, cols = 8, 10  # 8 rows, 10 columns for 80 seats
                seats = [[False for _ in range(cols)] for _ in range(rows)]
                seat_buttons = []

                def toggle_seat(r, c):
                    if seats[r][c]:
                        seats[r][c] = False
                        seat_buttons[r][c].config(bg="SystemButtonFace")  # Reset to default color
                    else:
                        seats[r][c] = True
                        seat_buttons[r][c].config(bg="green")  # Selected seat color

                for r in range(rows):
                    row_buttons = []
                    for c in range(cols):
                        seat_button = Button(seat_frame, text=f"{r+1}-{c+1}", width=6, height=3, font=("Times New Roman", 10),
                                             command=lambda r=r, c=c: toggle_seat(r, c), relief=SOLID, bg="lightgray", activebackground="lightgreen")
                        seat_button.grid(row=r, column=c, padx=5, pady=5)
                        row_buttons.append(seat_button)
                    seat_buttons.append(row_buttons)

                def confirm_seats():
                    selected_seats = [(r + 1, c + 1) for r in range(rows) for c in range(cols) if seats[r][c]]
                    if not selected_seats:
                        messagebox.showerror("Error", "Please select at least one seat.")
                        return

                    messagebox.showinfo("Success", f"Seats reserved: {', '.join([f'{r}-{c}' for r, c in selected_seats])}")
                    seat_window.destroy()

                Button(seat_window, text="Confirm", command=confirm_seats, font=("Times New Roman", 12), bg="#8968cd", fg="white").pack(pady=20)

            Button(time_window, text="Next", command=select_seat, font=("Times New Roman", 12), bg="#8968cd", fg="white").pack(pady=20)

        Button(date_window, text="Next", command=select_time, font=("Times New Roman", 12), bg="#8968cd", fg="white").pack(pady=20)

    select_date()
def show_movie_details(title):
    movie_details = fetch_movie_details(title)
    if not movie_details:
        messagebox.showerror("Error", "Details for this movie could not be retrieved.")
        return

    details_window = Toplevel(root)
    details_window.title(f"Details - {title}")
    details_window.geometry("650x650")

    details_frame = Frame(details_window, bg="black")
    details_frame.place(relwidth=1, relheight=1)

    poster_frame = Frame(details_frame, bg="black")
    poster_frame.grid(row=0, column=0, padx=20, pady=20)

    info_frame = Frame(details_frame, bg="black")
    info_frame.grid(row=1, column=0, padx=20, pady=10)

    button_frame = Frame(details_frame, bg="black")
    button_frame.grid(row=0, column=1, rowspan=2, padx=20, pady=20, sticky=N)

    poster_paths = {
        "Gladiator II": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Gladiator_II.png",
        "Moana 2": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Moana_2.png",
        "The Bell Keeper": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\The_Bell_Keeper.png",
        "Here": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Here.png",
        "The Last Breath": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\The_Last_Breath.png",
        "Wicked": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Wicked.png"
    }
    poster_path = poster_paths.get(title, None)
    if poster_path:
        try:
            poster_image = Image.open(poster_path)
            poster_image = poster_image.resize((250, 300))
            photo = ImageTk.PhotoImage(poster_image)
            poster_label_frame = Frame(poster_frame, bg="black")
            poster_label_frame.pack()
            Label(poster_label_frame, text=title, font=("Times New Roman", 14, "bold"), fg="white", bg="black").pack()
            poster_label = Label(poster_label_frame, image=photo, bg="black")
            poster_label.image = photo
            poster_label.pack()
        except FileNotFoundError:
            Label(poster_frame, text="No Poster Available", fg="white", bg="black", font=("Times New Roman", 12)).pack()

    details = {
        "Genre": movie_details[1],
        "Duration": f"{movie_details[2]} min",
        "Director": movie_details[3],
        "Actors": movie_details[4],
        "IMDB Rating": movie_details[5],
        "Release Date": movie_details[6].strftime('%Y-%m-%d')
    }

    for key, value in details.items():
        frame = Frame(info_frame, bg="black")
        frame.pack(anchor=W, pady=2)
        Label(frame, text=f"{key}: ", font=("Times New Roman", 12, "bold"), fg="white", bg="black").pack(side=LEFT)
        Label(frame, text=value, font=("Times New Roman", 12), fg="white", bg="black").pack(side=LEFT)

    Button(details_frame, text="Buy Ticket", bg="gray", fg="white", font=("Times New Roman", 16, "bold"),
           command=lambda: book_ticket(title))\
        .place(x=370, y=300)

def film_goruntuleme():
    movie_window = Toplevel(root)
    movie_window.title("Movie Viewer")
    movie_window.geometry("900x800")

    try:
        background_image = Image.open(r"C:\\Users\\MERVE\\Desktop\\background2.jpeg")
        background_image = background_image.resize((900, 800))
        bg = ImageTk.PhotoImage(background_image)
        bg_label = Label(movie_window, image=bg)
        bg_label.image = bg
        bg_label.place(x=0, y=0, relwidth=1, relheight=1)
    except FileNotFoundError:
        messagebox.showerror("Error", "Background image file not found. Please ensure the path is correct.")

    movies = fetch_movies()
    if not movies:
        messagebox.showerror("Error", "No movies found in the database!")
        return

    movie_frame = Frame(movie_window, bg="black")
    movie_frame.place(relx=0.5, rely=0.55, anchor=CENTER)

    poster_paths = {
        "Gladiator II": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Gladiator_II.png",
        "Moana 2": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Moana_2.png",
        "The Bell Keeper": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\The_Bell_Keeper.png",
        "Here": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Here.png",
        "The Last Breath": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\The_Last_Breath.png",
        "Wicked": r"C:\\Users\\MERVE\\Desktop\\first_part\\posters\\Wicked.png"
    }

    image_refs = []

    for idx, movie in enumerate(movies):
        title, duration, genre, release_date = movie
        row = idx // 3
        column = idx % 3

        poster_path = poster_paths.get(title, None)
        if poster_path:
            try:
                poster_image = Image.open(poster_path)
                poster_image = poster_image.resize((142, 192))
                photo = ImageTk.PhotoImage(poster_image)
                image_refs.append(photo)
                poster_label = Label(movie_frame, image=photo, bg="black", cursor="hand2")
                poster_label.image = photo
                poster_label.grid(row=row * 3, column=column, padx=30, pady=20)

                poster_label.bind("<Button-1>", lambda e, t=title: show_movie_details(t))
            except FileNotFoundError:
                Label(movie_frame, text="No Image", font=("Times New Roman", 10), fg="white", bg="black").grid(row=row * 3, column=column, padx=30, pady=20)

        title_label = Label(movie_frame, text=title, font=("Times New Roman", 12, "bold"), fg="white", bg="black")
        title_label.grid(row=row * 3 + 1, column=column, padx=30, pady=(10, 0))

        details_label = Label(movie_frame, text=f"{duration} min\n{genre}", font=("Times New Roman", 12), fg="gray", bg="black")
        details_label.grid(row=row * 3 + 2, column=column, padx=30, pady=(0, 10))

def register_user():
    username = reg_entry_username.get()
    password = reg_entry_password.get()
    email = reg_entry_email.get()

    if not username or not password or not email:
        messagebox.showerror("Error", "All fields are required!")
        return

    try:
        con = connect_to_db()
        cursor = con.cursor()

        check_query = "SELECT * FROM users WHERE email=%s"
        cursor.execute(check_query, (email,))
        existing_user = cursor.fetchone()

        if existing_user:
            messagebox.showerror("Error", "This email is already registered. Please use a different email.")
            return

        query = "INSERT INTO users (user_name, password, email) VALUES (%s, %s, %s)"
        cursor.execute(query, (username, password, email))
        con.commit()
        con.close()
        messagebox.showinfo("Success", "Registration successful!")
        reg_window.destroy()
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Database error: {err}")

def register():
    global reg_window, reg_entry_username, reg_entry_password, reg_entry_email
    reg_window = Toplevel(root)
    reg_window.title("Register")
    reg_window.geometry("400x300")

    Label(reg_window, text="Username:", font=("Times New Roman", 14)).place(x=50, y=50)
    reg_entry_username = Entry(reg_window, font=("Times New Roman", 14))
    reg_entry_username.place(x=150, y=50, width=200)

    Label(reg_window, text="Password:", font=("Times New Roman", 14)).place(x=50, y=100)
    reg_entry_password = Entry(reg_window, show="*", font=("Times New Roman", 14))
    reg_entry_password.place(x=150, y=100, width=200)

    Label(reg_window, text="Email:", font=("Times New Roman", 14)).place(x=50, y=150)
    reg_entry_email = Entry(reg_window, font=("Times New Roman", 14))
    reg_entry_email.place(x=150, y=150, width=200)

    Button(reg_window, text="Sign Up", command=register_user, font=("Times New Roman", 14), bg="#4f94cd", fg="white").place(x=150, y=200, width=100)

root = Tk()
root.title("Welcome Screen")
root.geometry("800x600")

try:
    background_image = Image.open(r"C:\\Users\\MERVE\\Desktop\\background.jpeg")
    background_image = background_image.resize((800, 600))
    bg = ImageTk.PhotoImage(background_image)
    bg_label = Label(root, image=bg)
    bg_label.place(x=0, y=0, relwidth=1, relheight=1)
except FileNotFoundError:
    messagebox.showerror("Error", "Background image file not found. Please ensure the path is correct.")

frame = Frame(root, bg="black")
frame.place(x=375, y=150, width=400, height=300)

Label(frame, text="Username:", font=("Times New Roman", 16), bg="black", fg="white").place(x=20, y=50)
entry_username = Entry(frame, font=("Times New Roman", 14))
entry_username.place(x=150, y=50, width=200)

Label(frame, text="Password:", font=("Times New Roman", 16), bg="black", fg="white").place(x=20, y=100)
entry_password = Entry(frame, show="*", font=("Times New Roman", 14))
entry_password.place(x=150, y=100, width=200)

Button(frame, text="Log In", command=film_goruntuleme, font=("Times New Roman", 14), bg="#a38c3d", fg="white").place(x=50, y=200, width=120)
Button(frame, text="Sign Up", command=register, font=("Times New Roman", 14), bg="#654321", fg="white").place(x=200, y=200, width=120)

root.mainloop()