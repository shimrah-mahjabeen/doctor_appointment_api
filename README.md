# README

# Medical Appointment API

This API provides endpoints to manage medical appointments for doctors and patients. It allows doctors to manage their availabilities, patients to book appointments, update appointments, and view doctor's availability.

## Getting Started

To get started with the Medical Appointment API, follow the instructions below.

### Prerequisites

- Ruby (>= 3.1.2)
- Ruby on Rails (>= 7.0.8)
- PostgreSQL (>= 10.0)

### Installation

Navigate to the project directory:

cd doctor_appoientment_api

Install dependencies:
bundle install

Set up the database:
rails db:create db:migrate

Seed the database with sample data:
rails db:seed

Start the Rails server:
rails server

It provides the following endpoints

## Api Endpoints

### Book Appointemnt

URL: /api/v1/doctors/{doctor_id}/appointments
HTTP Method: POST
Functionality: Creates a new appointment for the specified doctor.

### Update Appointment:

URL: /api/v1/doctors/{doctor_id}/appointments/{id}
HTTP Method: PATCH
Functionality: Updates an existing appointment for the specified doctor.

### Delete Appointment:

URL: /api/v1/doctors/{doctor_id}/appointments/{id}
HTTP Method: DELETE
Functionality: Deletes an existing appointment for the specified doctor.

### List Doctor's Availabilities:

URL: /api/v1/doctors/{doctor_id}/availabilities
HTTP Method: GET
Functionality: Retrieves a list of availabilities for the specified doctor.

### List Open Slots for Doctor:

URL: /api/v1/doctors/{doctor_id}/availabilities/open_slots
HTTP Method: GET
Functionality: Retrieves a list of open slots (unbooked availabilities) for the specified doctor.

### List Doctors working hours:

URL: /api/v1/doctors/{doctor_id}/working_hours
HTTP Method: GET
Functionality: Retrieves a list of a doctors working hours
