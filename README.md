# Doctor Appointment API

The Doctor Appointment API offers comprehensive endpoints for managing doctor appointments for both doctors and patients. It facilitates doctors in managing their availabilities and empowers patients to seamlessly book, update, and view doctor availability.

### Getting Started

To kickstart your journey with the Doctor Appointment API, kindly follow the instructions outlined below.

#### Prerequisites

Before you proceed, make sure your environment meets the following prerequisites:

- Ruby (>= 3.1.2)
- Ruby on Rails (>= 7.0.8)
- PostgreSQL (>= 10.0)

#### Installation

1. To clone the repository, use the following command: 

   ```sh
   git clone git@github.com:afeefazaman/doctor_appointment_api.git
   ```

2. Navigate to the project directoryy:

   ```sh
   cd doctor_appointment_api
   ```

2. Navigate to the project directory:

   ```sh
   cd doctor_appointment_api
   ```

3. Install dependencies:

   ```sh
   bundle install
   ```

4. Set up the database:

   ```sh
   rails db:create db:migrate
   ```

5. Seed the database with sample data:

   ```sh
   rails db:seed
   ```


6. Start the Rails server:

   ```sh
   rails server
   ```


The API provides the following endpoints:

## API Endpoints

### Book Appointment

- **URL**: /api/v1/doctors/{doctor_id}/appointments
- **HTTP Method**: POST
- **Functionality**: Creates a new appointment for the specified doctor.

### Update Appointment

- **URL**: /api/v1/doctors/{doctor_id}/appointments/{id}
- **HTTP Method**: PATCH
- **Functionality**: Updates an existing appointment for the specified doctor.

### Delete Appointment

- **URL**: /api/v1/doctors/{doctor_id}/appointments/{id}
- **HTTP Method**: DELETE
- **Functionality**: Deletes an existing appointment for the specified doctor.

### List Doctor's Availabilities

- **URL**: /api/v1/doctors/{doctor_id}/availabilities
- **HTTP Method**: GET
- **Functionality**: Retrieves a list of availabilities for the specified doctor.

### List Open Slots for Doctor

- **URL**: /api/v1/doctors/{doctor_id}/availabilities/open_slots
- **HTTP Method**: GET
- **Functionality**: Retrieves a list of open slots (unbooked availabilities) for the specified doctor.

### List Doctor's Working Hours

- **URL**: /api/v1/doctors/{doctor_id}/working_hours
- **HTTP Method**: GET
- **Functionality**: Retrieves a list of a doctor's working hours.
