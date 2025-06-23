from flask import Blueprint, request, jsonify
import uuid
import time

chat_bp = Blueprint('chat', __name__)

@chat_bp.route('/v1/chat/completions', methods=['POST'])
def chat_completions():
    data = request.get_json()

    dummy_response = {
        "id": f"chatcmpl-{uuid.uuid4().hex[:24]}",
        "object": "chat.completion",
        "created": int(time.time()),
        "model": data.get("model", "meta-llama/Meta-Llama-3-8B"),
        "choices": [
            {
                "index": 0,
                "message": {
                    "role": "assistant",
                    "content": "This is a dummy response from a LLaMA 3 8B-based mock API."
                },
                "finish_reason": "stop"
            }
        ],
        "usage": {
            "prompt_tokens": 10,
            "completion_tokens": 10,
            "total_tokens": 20
        }
    }

    return jsonify(dummy_response)
