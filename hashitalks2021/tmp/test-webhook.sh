#!/bin/bash

# CLI => API Gateway => EventBridge => https://smee.io/123

http --json --print=HhBb POST https://serverless-playground.terraform-aws-modules.modules.tf/webhook @sample-webhook.json
