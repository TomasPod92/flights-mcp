"""Flight search MCP package initialization."""

from . import server
import asyncio

def main():
    """Main entry point for the package."""
    server.main()

__all__ = ['main', 'server']
