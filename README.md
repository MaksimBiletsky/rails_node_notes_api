# Project Setup and Run Guide

This guide will help you set up and run the project using Docker.

## Prerequisites

- Ensure you have Docker and Docker Compose installed on your machine.

## Step-by-Step Instructions

### 1. Create the `.env` File

Copy the `.env.example` file to create a new `.env` file. This file will store your environment variables.

```sh
cp .env.example .env
```

### 2. Build the Docker Images

Use Docker Compose to build the images specified in the `docker-compose.yml` file.

```sh
docker-compose build
```

### 3. Set Up the Database

Run the following command to create and migrate the database for the Rails application.

```sh
docker-compose run railsapp rails db:create db:migrate
```

### 4. Start the Services

```sh
docker-compose up
```

### Accessing the Servers

- **Rails API Server**: Available at [http://localhost:3000](http://localhost:3000)
- **Node.js Server**: Available at [http://localhost:3001](http://localhost:3001)
