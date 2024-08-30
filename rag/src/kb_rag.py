import boto3
import os

KB_ID = os.environ.get("KB_ID", "ICF8JBMOU1")
REGION = os.environ.get("REGION", "us-east-1")

MODEL = "anthropic.claude-3-sonnet-20240229-v1:0"
NUM_RESULTS = 10


def lambda_handler(event={}, context={}):
    # Print the received event to the logs
    # print("Received event: ")
    # print(event)
    qs = event.get("queryStringParameters", {})

    question = qs.get("q", "What resources were created?")

    # Setup bedrock
    bedrock_agent_runtime = boto3.client(
        service_name="bedrock-agent-runtime",
        region_name=REGION,
    )

    # docs_only_response = bedrock_agent_runtime.retrieve(
    #     knowledgeBaseId=KB_ID,
    #     retrievalQuery={"text": question},
    #     retrievalConfiguration={
    #         "vectorSearchConfiguration": {"numberOfResults": NUM_RESULTS}
    #     },
    # )

    # for doc in docs_only_response["retrievalResults"]:
    #     print(f"Citation:\n{doc}\n")

    text_response = bedrock_agent_runtime.retrieve_and_generate(
        input={"text": question},
        retrieveAndGenerateConfiguration={
            "type": "KNOWLEDGE_BASE",
            "knowledgeBaseConfiguration": {
                "knowledgeBaseId": KB_ID,
                "modelArn": MODEL,
            },
        },
    )

    print(f"Input:\n{question}\n")

    # for citation in text_response["citations"]:
    #     print(f"Citation:\n{citation}\n")
    body = text_response['output']['text']
    print(f"Output:\n{body}\n")

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/plain"
        },
        "body": str(body)
    }
    
if __name__ == "__main__":
    lambda_handler()