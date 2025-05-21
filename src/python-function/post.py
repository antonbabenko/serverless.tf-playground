import datetime
import json
import uuid
import boto3
import os
import random
import randomname

DYNAMODB_TABLE_NAME = os.environ.get("DYNAMODB_TABLE_NAME")

session = boto3.Session()
client = session.client("dynamodb", region_name="eu-west-1")

def save_item(item):
    client.put_item(
        TableName=DYNAMODB_TABLE_NAME,
        Item=item
    )

def generate_item():
    return {
        "id": {"S": str(random.randint(1, 1000))},
        "name": {"S": randomname.get_name() + " was here at " + datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")},
    }

def lambda_handler(event, context):
    item = generate_item()

    save_item(item)

    body = "Hello from serverless.tf! New item saved:\n" + json.dumps(item, indent=2)

    r = {
        "statusCode": 200,
        "body": body
    }

    return r

if __name__ == "__main__":
    DYNAMODB_TABLE_NAME = "brave-iguana"

    print(lambda_handler(event={}, context=None))
