import pyodbc

server = 'localhost'
database = 'test'
username = 'dilrabo'
password = 'Dilrabo_123' 
driver = '{ODBC Driver 18 for SQL Server}'

conn = pyodbc.connect(
    f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password};Encrypt=no;TrustServerCertificate=yes;'
)
cursor = conn.cursor()

# Ma'lumotni olish
cursor.execute("SELECT id, file_name, photo_data FROM photos WHERE id = 1")
row = cursor.fetchone()

if row:
    file_name = row.file_name
    photo_data = row.photo_data

    with open(file_name, 'wb') as file:
        file.write(photo_data)
    
    print(f"Image '{file_name}' successfully saved!")
else:
    print("No image found.")

cursor.close()
conn.close()
