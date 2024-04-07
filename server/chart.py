from fastapi import FastAPI
import os
import csv

dir_path = "./assets/data/charts"

files = [
    f for f in os.listdir(dir_path) if os.path.isfile(os.path.join(dir_path, f))
]

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/chart/{chart_id}")
def read_chart(chart_id: str):
    if chart_id not in files:
        return {"error": "chart not found"}

    with open(f"{dir_path}/{chart_id}", encoding="utf-8", newline="") as f:
        reader = csv.reader(f)
        content = [row for row in reader]
        return {"chart": content}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
