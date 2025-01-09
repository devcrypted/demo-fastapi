from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional, List
from uuid import uuid4, UUID

app = FastAPI()


class Task(BaseModel):
    id: Optional[UUID] = None
    title: str
    description: Optional[str] = None
    is_complete: bool = False


tasks_db = []


# Endpoint to create a new task
@app.post("/", response_model=Task)
def create_task(task: Task):
    task.id = uuid4()
    tasks_db.append(task)
    return task


# Endpoint to get a task by id
@app.get("/{task_id}", response_model=Task)
def get_task(task_id: UUID):
    for task in tasks_db:
        if task.id == task_id:
            return task
    raise HTTPException(status_code=404, detail="Task not found")


# Endpoint to update a task by id
@app.put("/{task_id}", response_model=Task)
def update_task(task_id: UUID, updated_task: Task):
    for index, task in enumerate(tasks_db):
        if task.id == task_id:
            updated_task.id = task_id
            tasks_db[index] = updated_task
            return updated_task
    raise HTTPException(status_code=404, detail="Task not found")


# Endpoint to delete a task by id
@app.delete("/{task_id}", response_model=Task)
def delete_task(task_id: UUID):
    for index, task in enumerate(tasks_db):
        if task.id == task_id:
            deleted_task = tasks_db.pop(index)
            return deleted_task
    raise HTTPException(status_code=404, detail="Task not found")


# Endpoint to list all tasks
@app.get("/", response_model=List[Task])
def list_tasks():
    return tasks_db
