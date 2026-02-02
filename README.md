# Chat

Simple Flask + Socket.IO anonymous chat between users and admins.

Run locally (development):

```bash
python -m pip install -r requirements.txt
python PRONA.py
```

Deploy to Render (recommended):

- Render will use the `Procfile` which runs `gunicorn -k eventlet -w 1 PRONA:app`.
- Ensure `ENVIRONMENT=production` and set `SECRET_KEY` in service environment settings.

Notes:
- The chat UI is in `templates/index.html`.
- Database is `sqlite:///chat.db` by default.

Railway deployment
------------------

1. Connect your repository in the Railway dashboard (or use the Railway CLI).
2. Railway will detect a Python project when `requirements.txt` exists. If you prefer Docker, enable Docker deploys and Railway will use the included `Dockerfile`.
3. Set these environment variables in the Railway project settings:
	- `SECRET_KEY` (required)
	- `ENVIRONMENT=production`
	- `DATABASE_URL` (optional — if omitted the app uses local SQLite)
4. Railway exposes a `PORT` environment variable automatically; the app reads it.

Quick Docker deploy (optional):

```bash
railway up --docker
```

Security note: SQLite is not recommended for production on ephemeral hosts. Prefer a managed Postgres DB and set `DATABASE_URL` accordingly. If Railway supplies a `postgres://...` URL, the app converts it automatically to `postgresql://` for SQLAlchemy.