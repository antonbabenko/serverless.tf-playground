import json


def lambda_handler(event, context):
    r = {
        "isBase64Encoded": False,
        "statusCode": 200,
        "statusDescription": "200 OK",
        "headers": {
            "Content-Type": "application/json",
        },
        "body": "Hello from serverless.tf! Lambda function ARN: {}".format(context.invoked_function_arn)
    }

    return r
