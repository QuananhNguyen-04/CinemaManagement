# Movie Theater Booking System

This project is a web application for a movie theater, allowing users to book tickets, view showtimes, and purchase snacks online. Built using the MVC architecture, it features a PostgreSQL database for data storage and a Node.js backend.

---

## Features

- **Browse Movies**: Users can view a list of available movies.
- **Showtime Selection**: Choose a convenient showtime for your movie.
- **Seat Booking**: Select and reserve seats.
- **Snack Purchases**: Add snacks to your booking.
- **MVC Architecture**: Clean separation of concerns between Models, Views, and Controllers.
- **Secure**: Sensitive data is handled via environment variables, and database queries are abstracted into models.

---

## Getting Started

### Prerequisites

Ensure the following are installed on your system:
- **Node.js** (v16+)
- **PostgreSQL** (v14+)
- **npm** (comes with Node.js)

---

### Installation

1. **Clone the Repository**:
   git clone https://github.com/QuananhNguyen-04/CinemaManagement.git
   cd CinemaManagement
2. Install Dependencies:
    npm install
    Set Up the Database:

3. Create a PostgreSQL database.
Import the provided schema from schema.sql:
    ...

4. Create a .env File: Copy the .env.example file and fill in your database credentials:
    DB_HOST=localhost
    DB_USER=your_username
    DB_PASSWORD=your_password
    DB_NAME=movie_theater
    DB_PORT=5432

5. Start the Server:
    npm start
The application will be accessible at http://localhost:3000.

## Development
### Run in Development Mode
Use nodemon to automatically reload the server on file changes:
    npm run dev

### Project Structure

project/
├── models/         # Database interaction logic
│   └── movies.model.js
├── views/          # HTML files or templates
│   └── index.html
├── controllers/    # Request handling and response logic
│   └── movieController.js
├── public/         # Static assets (CSS, JS, images)
│   └── styles.css
│   └── index.html
├── server.js       # Main server script
├── .env            # Environment variables
└── README.md       # Documentation
## Contributing
### Fork the repository.

- Create a new branch: git checkout -b feature-name.
- Commit your changes: git commit -m "Add feature-name".
- Push to the branch: git push origin feature-name.
- Submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for details.

Contact
For questions or suggestions:
GitHub: github.com/QuananhNguyen-04

### Sections:
1. **Features**: Highlight the key functionalities of the project.
2. **Getting Started**: Steps to set up and run the project.
3. **Development**: Guidance on modifying and extending the project.
4. **Contributing**: Instructions for collaborators.
5. **License & Contact**: Share licensing info and ways to reach you.

