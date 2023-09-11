using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Bogus;

class Program
{
    static void Main(string[] args)
    {
        string connectionString = "Server=DESKTOP-2628EB6;Database=Tech-Lib;Integrated Security=True;";
        int numberOfRecords = 1000;

        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();
            //InsertDataToBooksTable(numberOfRecords, connection);
            //InsertDataToBorrowersTable(numberOfRecords, connection);
            //InsertDataToLoansTable(numberOfRecords, connection);
        }
    }


    private static void InsertDataToBooksTable(int numberOfRecords, SqlConnection connection)
    {
        using (var transaction = connection.BeginTransaction())
        {

            List<string> genres = new List<string>
        {
            "Science Fiction",
            "Fantasy",
            "Mystery",
            "Romance",
            "Thriller",
            "Horror",
            "Non-fiction",
            "Biography",
            "Historical Fiction",
            "Adventure"
            // Add more genres as needed
        };
            List<string> shelfLocations = new List<string>
        {
            "A1",
            "B3",
            "C2",
            "D4",
            "E5",
            "F1",
            "G3",
            "H2",
            "I1",
            "J4"
            // Add more shelf locations as needed
        };
            var faker = new Bogus.Faker();

            using (var command = connection.CreateCommand())
            {
                command.Transaction = transaction;

                for (int i = 0; i < numberOfRecords; i++)
                {
                    var title = faker.Commerce.ProductName();
                    var author = faker.Name.FullName();
                    var isbn = faker.Random.Long(1000000000000, 9999999999999).ToString();
                    var publishedDate = faker.Date.Past(20, DateTime.Now.AddYears(-1));
                    var genre = genres[faker.Random.Int(0, genres.Count - 1)];
                    var shelfLocation = shelfLocations[faker.Random.Int(0, shelfLocations.Count - 1)];
                    var currentStatus = faker.PickRandom("Available", "Borrowed");

                    command.CommandText = "INSERT INTO Books (Title, Author, ISBN, PublishedDate, Genre, ShelfLocation, CurrentStatus) " +
                                          "VALUES (@Title, @Author, @ISBN, @PublishedDate, @Genre, @ShelfLocation, @CurrentStatus)";

                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@Title", title);
                    command.Parameters.AddWithValue("@Author", author);
                    command.Parameters.AddWithValue("@ISBN", isbn);
                    command.Parameters.AddWithValue("@PublishedDate", publishedDate);
                    command.Parameters.AddWithValue("@Genre", genre);
                    command.Parameters.AddWithValue("@ShelfLocation", shelfLocation);
                    command.Parameters.AddWithValue("@CurrentStatus", currentStatus);

                    command.ExecuteNonQuery();
                }
                transaction.Commit();
            }
            Console.WriteLine($"Inserted {numberOfRecords} records into the database.");
        }
    }
    private static void InsertDataToBorrowersTable(int numberOfRecords, SqlConnection connection)
    {
        using (var transaction = connection.BeginTransaction())
        {
            var faker = new Bogus.Faker();

            using (var command = connection.CreateCommand())
            {
                command.Transaction = transaction;

                for (int i = 0; i < numberOfRecords; i++)
                {
                    var firstName = faker.Name.FirstName();
                    var lastName = faker.Name.LastName();
                    var email = faker.Internet.Email();
                    var dateOfBirth = faker.Date.Past(30, DateTime.Now.AddYears(-18));
                    var membershipDate = faker.Date.Past(5);

                    command.CommandText = "INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate) " +
                                          "VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate)";

                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@FirstName", firstName);
                    command.Parameters.AddWithValue("@LastName", lastName);
                    command.Parameters.AddWithValue("@Email", email);
                    command.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                    command.Parameters.AddWithValue("@MembershipDate", membershipDate);

                    command.ExecuteNonQuery();
                }
                transaction.Commit();
            }
            Console.WriteLine($"Inserted {numberOfRecords} records into the database.");
        }
    }
    private static void InsertDataToLoansTable(int numberOfRecords, SqlConnection connection)
    {
        using (var transaction = connection.BeginTransaction())
        {
            var faker = new Bogus.Faker();
            var usedBookIDs = new HashSet<int>();

            using (var command = connection.CreateCommand())
            {
                command.Transaction = transaction;

                for (int i = 0; i < numberOfRecords; i++)
                {
                    int bookID;
                    do
                    {
                        bookID = faker.Random.Int(1, numberOfRecords);
                    } while (usedBookIDs.Contains(bookID));

                    usedBookIDs.Add(bookID);

                    var borrowerID = faker.Random.Int(1, numberOfRecords);
                    var dateBorrowed = faker.Date.Past(5);
                    var dueDate = dateBorrowed.AddDays(faker.Random.Int(7, 30));
                    DateTime? dateReturned = faker.Random.Number(0, 100) < 80 ? faker.Date.Between(dateBorrowed, DateTime.Now) : (DateTime?)null;

                    command.CommandText = "INSERT INTO Loans (BookID, BorrowerID, DateBorrowed, DueDate, DateReturned) " +
                      "VALUES (@BookID, @BorrowerID, @DateBorrowed, @DueDate, @DateReturned)";

                    command.Parameters.Clear();
                    command.Parameters.AddWithValue("@BookID", bookID);
                    command.Parameters.AddWithValue("@BorrowerID", borrowerID);
                    command.Parameters.AddWithValue("@DateBorrowed", dateBorrowed);
                    command.Parameters.AddWithValue("@DueDate", dueDate);

                    if (dateReturned.HasValue && dateReturned >= dateBorrowed)
                    {
                        command.Parameters.AddWithValue("@DateReturned", dateReturned);
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@DateReturned", DBNull.Value);
                    }

                    command.ExecuteNonQuery();
                }
                transaction.Commit();
            }
            Console.WriteLine($"Inserted {numberOfRecords} records into the Loans table.");
        }
    }

}
