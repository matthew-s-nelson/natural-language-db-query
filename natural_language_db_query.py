import json
from db_interactions import initialize_db
# from openai import OpenAI


# Initialize the sqlite database
conn = initialize_db()

# with open("openai.config.json") as f:
#     config = json.load(f)

# client = OpenAI(
#   api_key=config["api_key"]
# )

# response = client.responses.create(
#   model="gpt-5-nano",
#   input="write a haiku about ai",
#   store=True,
# )

# print(response.output_text);
