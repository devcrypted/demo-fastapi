# FastAPI Demo Task Manager

Just a demo API built in FastAPI

## Installation

```bash
git clone https://github.com/devcrypted/demo-fastapi.git
cd demo-fastapi
pip install -r requirements.txt
```

## Running the Application

```bash
uvicorn main:app --reload
```

Navigate to `http://localhost:8000/docs` to view the Swagger UI where you can interact with the API.

## Using Docker

Build the Docker image:

```bash
docker build -t fastapi-task-manager .
```

Run the Docker container:

```bash
docker run -p 8080:80 fastapi-task-manager
```

Now you can access the application at `http://localhost:8080/docs`.

## API Endpoints

- **POST /**: Create a new task
- **GET /**: Retrieve all tasks
- **GET /{task_id}**: Retrieve a task by its ID
- **PUT /{task_id}**: Update a task by its ID
- **DELETE /{task_id}**: Delete a task by its ID
