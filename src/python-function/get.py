import json
import boto3
import os

from boto3.dynamodb.types import TypeDeserializer

DYNAMODB_TABLE_NAME = os.environ.get("DYNAMODB_TABLE_NAME")

session = boto3.Session()
client = session.client("dynamodb", region_name="eu-west-1")

def get_all_items():
    paginator = client.get_paginator('scan')

    response_iterator = paginator.paginate(
        TableName=DYNAMODB_TABLE_NAME
    )

    data = []
    for page in response_iterator:
        for item in page['Items']:
            # convert to python types
            deserializer = TypeDeserializer()
            python_data = {k: deserializer.deserialize(v) for k, v in item.items()}

            data.append(python_data)

    return data


def lambda_handler(event, context):
    items = get_all_items()

    body = "Hello from serverless.tf! Here are the items:\n" + json.dumps(items, indent=2)

    r = {
        "statusCode": 200,
        "body": body
    }

    return r

if __name__ == "__main__":
    DYNAMODB_TABLE_NAME = "brave-iguana"

    print(lambda_handler(event={}, context=None))
