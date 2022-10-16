# MTDB (Music Theory DB)

Music theory website with interactive chord and scale lookup.
* Designed to work great on phones, tablets and desktops.
* Uses a high contrast dark theme that should look great on stage or in a dark studio (based on Dracula UI)
* Created using Rails 7 with Hotwire (Turbo/Stimulus), and Tailwind

Alpha version is live at musictheorydb.com

## Development

Start development server and Postgres in Docker:
```
docker-compose up
```

Start build server for Tailwind:
```
npx tailwindcss -i ./app/assets/stylesheets/tailwind_input_styles.css -o ./app/assets/stylesheets/tailwind_styles.css --watch
```
