# Climate news

## Description

This is an app for getting the latest climate-related news. It's still a work-in-progress.

## What's needed

This app runs on Ruby on Rails and Node.js. The required versions are in the `.tool-versions`, `.ruby-versions`, and `.nvmrc` files.

## How to install and run the app locally

1. Copy the values from .env.example to .env for the backend
2. Create the postgres user locally associated with the table

```shell
sudo psql -U <username> -d postgres
```

```sql
CREATE USER climate_news WITH PASSWORD 'climate_news';
ALTER ROLE climate_news createrole createdb;
```

3. Run `ruby prepare.rb` in root directory
4. Run `foreman start` to start the app
5. Open up http://localhost:3000 to view the app

## Starting the frontend and backend independently

Run `npm run dev` in the `frontend` folder to start up the frontend by itself.

Run `bin/rails s` or `bundle exec rails s` in the `backend` folder to start up the backend by itself.

## Todos

### Backend

- [x] tables and models for storing the queries and news information
- [x] api controller for news and messages
- [x] Bing Search service for getting search results
- [x] news helpers to help create records for news articles in the database from search results
- [x] rspec request tests starting point
- [ ] rspec tests with Bing Search mock
- [x] initial Postman collection

### Frontend

- [x] proof of concept page for displaying the content on the frontend
- [ ] a way to bookmark articles without the need to create an account i.e. local storage
- [ ] frontend tests
