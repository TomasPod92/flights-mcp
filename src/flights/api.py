from fastapi import FastAPI
from flights.services.search import mcp

app = FastAPI()

@app.get("/")
def root():
    return {"status": "FastMCP is alive"}

@app.on_event("startup")
def start_mcp():
     thread = threading.Thread(target=mcp.run, kwargs={"transport": "stdio"}, daemon=True)
    thread.start()
