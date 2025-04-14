# src/flights/fastmcp.py


import logging

class FastMCP:
    def __init__(self, name: str):
        self.name = name
        self.logger = logging.getLogger(__name__)
        self.tools = {}

    def run(self, transport='stdio'):
        self.logger.info(f"{self.name} running on {transport}")
        for name, func in self.tools.items():
            self.logger.info(f"Tool registered: {name} -> {func}")

    def tool(self, name=None):
        def decorator(func):
            tool_name = name or func.__name__
            self.logger.info(f"Registering tool: {tool_name}")
            self.tools[tool_name] = func
            return func
        return decorator

