import json
from openai import OpenAI
import sqlite3

# with open("openai.config.json") as f:
#     config = json.load(f)

# Initialize the sqlite database
def initialize_db():
    db_file = 'kitchen.db'

    try:
        conn = sqlite3.connect(db_file)
        print('Kitchen sqlite DB formed.')
    except:
        print('Kitchen sqlite DB not formed')
    return conn



conn = initialize_db()
conn.close()


# client = OpenAI(
#   api_key=config["api_key"]
# )

# response = client.responses.create(
#   model="gpt-5-nano",
#   input="write a haiku about ai",
#   store=True,
# )

# print(response.output_text);
