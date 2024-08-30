# Implementing RAG using serverless.tf (Doing serverless with Terraform on AWS)

> This talk will focus on the implementation of Retrieval-Augmented Generation (RAG) using a serverless approach with Terraform on AWS. The demo will showcase deploying a full RAG pipeline, integrating AI models with a retrieval system, and handling real-time queries using AWS Lambda, API Gateway, and DynamoDB—all managed through Terraform using open-source Terraform AWS modules and serverless.tf.

https://www.meetup.com/advancedaws/events/302961381/

## Scope

Ask questions about Terraform states stored in S3.

AWS Bedrock => RAG (Knowledge Base, Agents) to query terraform states from S3

```
https POST pe43dluxmzynvocrnkwl4y2n4y0mlzuv.lambda-url.us-east-1.on.aws/ q=="How many resources were deployed?"
```

## Setup

[uv](https://github.com/astral-sh/uv) is used.

```
cd rag
. .venv/bin/activate

uv pip install -r requirements.txt
```

## Troubleshooting

> ImportError: failed to find libmagic.  Check your installation

Solution: `brew install libmagic`


## Read more:

https://catalog.workshops.aws/building-gen-ai-apps/en-US/chat-with-docs