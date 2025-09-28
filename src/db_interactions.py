import sqlite3

db_file_path = '../kitchen.db'
sql_file_path = '../kitchendbsqlite.sql'

def initialize_db():
    with open(sql_file_path, 'r') as sql_file:
        sql_script = sql_file.read()

    try:
        check_table = 'recipes'
        with sqlite3.connect(db_file_path) as conn:
            cursor = conn.cursor()

            cursor.execute(
                "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
                (check_table,)
            )
            table_exists = cursor.fetchone() is not None

            # If the table exists, skip the initialization script
            if table_exists:
                print(f"Database already initialized with table '{check_table}'. Skipping setup.")
                return
            
            cursor.executescript(sql_script)
            conn.commit()
            cursor.close()
        print('Kitchen sqlite DB formed.')
    except Exception as e:
        print(f'Kitchen sqlite DB not formed: {e}')

def get_db_schema():
    with sqlite3.connect(db_file_path) as conn:
        cursor = conn.cursor()
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()

        schema = {}
        for table_name in tables:
            table = table_name[0]
            cursor.execute(f"PRAGMA table_info({table});")
            columns = cursor.fetchall()
            schema[table] = [col[1] for col in columns]  # col[1] is the column name
        cursor.close()

    return schema

def execute_query(query: str):
    try:
        with sqlite3.connect(db_file_path) as conn:
            cursor = conn.cursor()
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
    except Exception as e:
        print(f"Error executing query: {e}")
        return []
    return results