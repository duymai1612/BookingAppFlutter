# Booking App API Design (.NET)

## API Endpoints

### 1. Duration Options

#### GET /api/durations
Retrieves available duration options.

**Response:**
```json
{
  "durations": [
    {
      "id": 1,
      "minutes": 15,
      "description": "15 minute quick chat"
    },
    {
      "id": 2,
      "minutes": 30,
      "description": "30 minute discussion"
    },
    {
      "id": 3,
      "minutes": 60,
      "description": "60 minute in-depth meeting"
    }
  ]
}
```

### 2. Available Dates

#### GET /api/dates
Retrieves available dates for the current and next 3 months.

**Query Parameters:**
- `startDate` (optional): Start date for range (default: current date)
- `endDate` (optional): End date for range (default: 3 months from start date)

**Response:**
```json
{
  "availableDates": [
    {
      "date": "2023-06-01",
      "isAvailable": true
    },
    {
      "date": "2023-06-02",
      "isAvailable": false
    },
    // ... other dates
  ]
}
```

### 3. Time Slots

#### GET /api/timeslots
Retrieves available time slots for a specific date and duration.

**Query Parameters:**
- `date` (required): Date in format YYYY-MM-DD
- `durationId` (required): ID of the selected duration
- `timezone` (optional): Timezone string (default: UTC)

**Response:**
```json
{
  "date": "2023-06-01",
  "timeslots": [
    {
      "id": 1,
      "startTime": "09:00",
      "endTime": "09:15",
      "isAvailable": true
    },
    {
      "id": 2,
      "startTime": "09:30",
      "endTime": "09:45",
      "isAvailable": true
    },
    // ... other time slots
  ]
}
```

### 4. Timezones

#### GET /api/timezones
Retrieves list of available timezones.

**Response:**
```json
{
  "timezones": [
    {
      "id": "UTC",
      "displayName": "UTC (Coordinated Universal Time)"
    },
    {
      "id": "America/New_York",
      "displayName": "Eastern Time (US & Canada)"
    },
    // ... other timezones
  ]
}
```

### 5. Participants

#### GET /api/participants
Retrieves list of participants (meeting organizer and attendees).

**Response:**
```json
{
  "organizer": {
    "id": 1,
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com"
  },
  "participants": [
    {
      "id": 2,
      "firstName": "Jane",
      "lastName": "Smith",
      "email": "jane.smith@example.com"
    }
  ]
}
```

### 6. Bookings

#### POST /api/bookings
Creates a new booking.

**Request Body:**
```json
{
  "durationId": 2,
  "date": "2023-06-01",
  "timeslotId": 3,
  "timezone": "America/New_York",
  "title": "Project Discussion",
  "participantIds": [1, 2],
  "additionalNotes": "Discussing project timeline" 
}
```

**Response:**
```json
{
  "bookingId": "b8a9c027-3f3d-4d5e-9f0a-1b2c3d4e5f6a",
  "status": "confirmed",
  "details": {
    "title": "Project Discussion",
    "duration": 30,
    "date": "2023-06-01",
    "startTime": "09:30",
    "endTime": "10:00",
    "timezone": "America/New_York",
    "participants": [
      {
        "id": 1,
        "firstName": "John",
        "lastName": "Doe"
      },
      {
        "id": 2,
        "firstName": "Jane",
        "lastName": "Smith"
      }
    ]
  }
}
```

#### GET /api/bookings/{bookingId}
Retrieves details of a specific booking.

**Response:**
```json
{
  "bookingId": "b8a9c027-3f3d-4d5e-9f0a-1b2c3d4e5f6a",
  "status": "confirmed",
  "details": {
    "title": "Project Discussion",
    "duration": 30,
    "date": "2023-06-01",
    "startTime": "09:30",
    "endTime": "10:00",
    "timezone": "America/New_York",
    "participants": [
      {
        "id": 1,
        "firstName": "John",
        "lastName": "Doe"
      },
      {
        "id": 2,
        "firstName": "Jane",
        "lastName": "Smith"
      }
    ]
  }
}
```

#### DELETE /api/bookings/{bookingId}
Cancels a booking.

**Response:**
```json
{
  "bookingId": "b8a9c027-3f3d-4d5e-9f0a-1b2c3d4e5f6a",
  "status": "cancelled"
}
```

## Database Schema

### Tables

1. **Durations**
   - `Id` (int, PK)
   - `Minutes` (int)
   - `Description` (string)

2. **Timeslots**
   - `Id` (int, PK)
   - `StartTime` (time)
   - `EndTime` (time)
   - `Date` (date)
   - `DurationId` (int, FK)
   - `IsAvailable` (bool)

3. **Users**
   - `Id` (int, PK)
   - `FirstName` (string)
   - `LastName` (string)
   - `Email` (string)

4. **Bookings**
   - `Id` (Guid, PK)
   - `Title` (string)
   - `TimeslotId` (int, FK)
   - `Timezone` (string)
   - `Status` (string) - Confirmed, Cancelled, etc.
   - `AdditionalNotes` (string)
   - `CreatedAt` (datetime)

5. **BookingParticipants**
   - `BookingId` (Guid, FK)
   - `UserId` (int, FK)
   - `Role` (string) - Organizer, Participant, etc.

## Implementation Notes

1. **Authentication/Authorization**
   - For the POC, simple API key authentication can be used
   - In production, consider implementing OAuth2 or JWT-based auth

2. **Error Handling**
   - Return appropriate HTTP status codes (400 for client errors, 500 for server errors)
   - Include descriptive error messages in the response body

3. **Validation**
   - Validate date ranges (only future dates)
   - Validate booking requests against available timeslots
   - Prevent double-booking of timeslots

4. **Performance Considerations**
   - Cache frequently accessed data (duration options, timezones)
   - Use pagination for listing endpoints if data grows large 