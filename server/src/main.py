from fastapi import FastAPI
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
import os
import csv

files = {
    "chart": {
        "dir_path": "./assets/data/charts",
        "files": [
            f
            for f in os.listdir("./assets/data/charts")
            if os.path.isfile(os.path.join("./assets/data/charts", f))
        ],
    },
    "audio": {
        "dir_path": "./assets/audio/",
        "files": [
            f
            for f in os.listdir("./assets/audio/")
            if os.path.isfile(os.path.join("./assets/audio/", f))
        ],
    },
    "config": {
        "dir_path": "./music/",
        "files": [
            f
            for f in os.listdir("./music/")
            if os.path.isfile(os.path.join("./music/", f))
        ],
    },
}
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://127.0.0.1:3000"],
    allow_credentials=True,
    allow_methods=["GET"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/chart/{chart_id}")
def read_chart(chart_id: str):
    if chart_id not in files["chart"]["files"]:
        return {"error": "chart not found"}

    with open(
        f"{files["chart"]["dir_path"]}/{chart_id}", encoding="utf-8", newline=""
    ) as f:
        reader = csv.reader(f)
        content = [row for row in reader]
        return {"chart": content}


@app.get("/audio/{audio_id}")
def get_audio(audio_id: str):
    if audio_id not in files["audio"]["files"]:
        return {"error": "audio not found"}

    return FileResponse(
        path=f"{files["audio"]["dir_path"]}/{audio_id}", media_type="audio/mpeg"
    )


@app.get("/config/{config_id}")
def get_config(config_id: str):
    if config_id not in files["config"]["files"]:
        return {"error": "config not found"}

    return FileResponse(
        path=f"{files["config"]["dir_path"]}/{config_id}", media_type="application/json"
    )


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8000)
