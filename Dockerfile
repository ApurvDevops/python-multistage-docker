# -------------------- Stage 1 --------------------
#---------------Fixed Docker file----
FROM python:3.9 AS backend-builder
WORKDIR /app

COPY backend/ /app
RUN python -m venv venv
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# ------------------ Stage 2 ----------------------
FROM python:3.9-slim-buster
WORKDIR /app
COPY --from=backend-builder /app /app
EXPOSE 5000
ENV NAME World
CMD ["/bin/bash", "-c", "source venv/bin/activate && python app.py"]

