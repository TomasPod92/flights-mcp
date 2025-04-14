# src/flights/fastmcp.py


import logging

class FastMCP:
    def __init__(self, name: str):
        self.name = name
        self.logger = logging.getLogger(__name__)

    def run(self, transport='stdio'):
        self.logger.info(f"{self.name} running on {transport}")

    def tool(self):
        def decorator(func):
            self.logger.info(f"Registering tool: {func.__name__}")
            return func
        return decorator
