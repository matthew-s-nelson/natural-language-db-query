import sqlite3

def initialize_db():
    db_file_path = '../kitchen.db'
    sql_file_path = '../kitchendbsqlite.sql'

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
        print('Kitchen sqlite DB formed.')
    except Exception as e:
        print(f'Kitchen sqlite DB not formed: {e}')