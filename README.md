# MTDB (Music Theory DB)

Rails 7 using Hotwire (Turbo/Stimulus), ESM, and Tailwind

## Development

Start development server and Postgres in Docker:
```
docker-compose up
```

Start build server for Tailwind:
```
npx tailwindcss -i ./app/assets/stylesheets/tailwind_input_styles.css -o ./app/assets/stylesheets/tailwind_styles.css --watch
```
