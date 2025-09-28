import json
import re
from db_interactions import initialize_db, get_db_schema, execute_query
from openai import OpenAI


# Initialize the sqlite database
conn = initialize_db()
db_schema = get_db_schema()

with open("../openai.config.json") as f:
    config = json.load(f)

client = OpenAI(
    api_key=config["api_key"]
)
client.models.list() # Check that the API key is valid

# Get a response from ChatGPT
def get_response_from_gpt(prompt: str, instructions: str) -> str:
    response = client.responses.create(
        model="gpt-4o",
        instructions=instructions,
        input=prompt,
        max_output_tokens=500, # Note: Adjust max_tokens as needed to avoid truncated responses
    )

    return response.output[0].content[0].text

# Pick out the SQL code block from the response
def get_sql_from_response(response: str) -> str:
    # Extract SQL statement from response string
    match = re.search(r"```sql\s*(.*?)```", response, re.DOTALL | re.IGNORECASE)
    if match:
        sql = match.group(1)
        print(f"Extracted SQL: {sql}")
    else:
        sql = ""
        print("No SQL code block found in the response.")
    return sql.strip()

# Sanitize the SQL query to prevent harmful operations. Only SELECT statements should be allowed.
def sanitize_sql_query(query: str) -> str:
    forbidden_keywords = ["DROP", "DELETE", "INSERT", "UPDATE", "ALTER"]
    for keyword in forbidden_keywords:
        if keyword in query.upper():
            raise ValueError(f"Forbidden keyword detected in query: {keyword}")
    return query

# Prepare instructions with schema details for query generation
query_generation_instructions = "You are an assistant that translates natural language to SQLite SELECT queries. "
query_generation_instructions += "Only respond with the SQL query, and nothing else."
schema_description = "The database in question has the following tables and columns:\n"
for table, columns in db_schema.items():
    schema_description += f"- {table}: {', '.join(columns)}\n"
query_generation_instructions += schema_description

# Prepare instructions for response interpretation
response_interpretation_instructions = "You are an assistant that interprets SQL query results from a recipes database. "
response_interpretation_instructions += "Given a user's question, the associated SQL query, and the SQL query results, provide a clear and concise answer. "
response_interpretation_instructions += "If the results are empty, inform the user that no data was found. "
response_interpretation_instructions += schema_description

# Prepare response interpretation prompt
def prepare_response_interpretation_prompt(user_question: str, sql_query: str, sql_results) -> str:
    results_str = json.dumps(sql_results)
    prompt = f"User Question: {user_question}\n"
    prompt += f"SQL Query: {sql_query}\n"
    prompt += f"SQL Results: {results_str}\n"
    prompt += "Based on the SQL results, provide a clear and concise answer to the user's question."
    return prompt

# Collect user inputs
while True:
    user_input = input("Enter your question about the recipes database (type 'exit' to finish): ")
    if user_input.strip().lower() == 'exit':
        break
    gpt_response = get_response_from_gpt(user_input, query_generation_instructions)
    print(f"GPT Response: {gpt_response}\n")
    sql_response = get_sql_from_response(gpt_response)
    print(f"SQL Response: {sql_response}\n")
    sanitized_sql = sanitize_sql_query(sql_response)
    print(f"Sanitized SQL: {sanitized_sql}\n")

    if sanitized_sql == "" or sanitized_sql is None:
        print("No valid SQL query generated.")
        continue

    if sql_response:
        query_results = execute_query(sanitized_sql)
        print(f"SQL Query Results: {query_results}\n")
        response_prompt = prepare_response_interpretation_prompt(user_input, sanitized_sql, query_results)
        final_response = get_response_from_gpt(response_prompt, response_interpretation_instructions)
        print(f"Response: {final_response}\n")
