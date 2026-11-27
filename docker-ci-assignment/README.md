# Assignment 2: Dockerize a Flask App with a GitHub Actions CI Check

A small Flask app (`/` and `/health`) packaged in Docker, with a workflow that builds the image on every push.

## Run it

```bash
git clone https://github.com/<your-username>/docker-ci-assignment.git
cd docker-ci-assignment

docker build -t myapp .
docker run -d --name myapp -p 5000:5000 myapp

curl localhost:5000/
curl localhost:5000/health
```

Stop and clean up: `docker rm -f myapp`

### Output of `curl localhost:5000/health`

```
$ curl localhost:5000/health
{"status":"ok"}
```

## Bug hunt: the teammate's Dockerfile

```dockerfile
FORM python:3.12-slim
WORKDIR /app
COPY . .
RUN pip install -r requirement.txt
CMD ["python", "app.py"]
```
Run with: `docker run -p 5000:8080 myapp`

| # | Problem | Fix |
|---|---|---|
| 1 | `FORM` is a typo; Docker doesn't know this instruction, so the build fails. | `FROM python:3.12-slim` |
| 2 | `requirement.txt` doesn't exist; the file is `requirements.txt`, so `pip install` fails. | `RUN pip install -r requirements.txt` |
| 3 | Wrong port mapping: `-p 5000:8080` sends host port 5000 to container port **8080**, but Flask listens on **5000**, so the app can't be reached. | `docker run -p 5000:5000 myapp` |
| 4 | No `EXPOSE` (documentation only, not a blocker). | Add `EXPOSE 5000` |
| 5 | `COPY . .` before `pip install` invalidates the dependency cache on every code change; `pip` also keeps its cache in the image. | Copy `requirements.txt` first, install with `--no-cache-dir`, then `COPY . .` |
| 6 | Container runs as root. | Create and switch to a non-root user (`USER appuser`) |

`host="0.0.0.0"` in `app.py` was already correct. Binding to `127.0.0.1` would make it unreachable from outside the container.

## Fixed Dockerfile

See [`Dockerfile`](Dockerfile). It also uses a [`.dockerignore`](.dockerignore) and a non-root user (bonus items).

## CI: GitHub Actions

[`.github/workflows/build.yml`](.github/workflows/build.yml) runs on every push and pull request:

1. Checks out the code
2. Builds the Docker image
3. (Bonus) Runs the container and calls `/health` with retries, failing the job if it doesn't respond
4. Removes the container

See results under the repo's **Actions** tab.
