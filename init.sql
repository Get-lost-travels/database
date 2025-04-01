PRAGMA foreign_keys = ON;

-- User Management
CREATE TABLE users
(
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    username      TEXT NOT NULL,
    email         TEXT NOT NULL UNIQUE,
    password_hash TEXT,
    role          TEXT NOT NULL CHECK (role IN ('customer', 'agency', 'webadmin')),
    auth_provider TEXT NOT NULL CHECK (auth_provider IN ('local', 'google')),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_preferences
(
    user_id                  INTEGER PRIMARY KEY REFERENCES users (id),
    theme_preference         TEXT NOT NULL DEFAULT 'system' CHECK (theme_preference IN ('light', 'dark', 'system')),
    notification_preferences TEXT          DEFAULT '{}' -- JSON string for notification settings
);

CREATE TABLE user_sessions
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER REFERENCES users (id),
    token      TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table user_saved_searches
(
    request    INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER REFERENCES users (id),
    query      TEXT NOT NULL,
    filters    TEXT, -- json string of search filters
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER REFERENCES users (id),
    provider   TEXT NOT NULL CHECK (provider IN
                                    ('credit_card', 'paypal', 'bank_transfer')),
    details    TEXT NOT NULL, -- Encrypted payment details as JSON
    is_default BOOLEAN   DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Travel Agency Management
CREATE TABLE agencies
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER REFERENCES users (id),
    name       TEXT NOT NULL,
    banner_url TEXT,
    logo_url   TEXT,
    address    TEXT,
    phone      TEXT
);

CREATE TABLE agency_analytics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    agency_id INTEGER REFERENCES agencies(id),
    date DATE NOT NULL,
    views INTEGER DEFAULT 0,
    bookings INTEGER DEFAULT 0,
    revenue REAL DEFAULT 0,
    UNIQUE(agency_id, date)
);

-- Travel Services
CREATE TABLE service_categories
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL UNIQUE,
    description TEXT NOT NULL
);

-- Insert default categories
INSERT INTO service_categories (name, description)
VALUES ('City Breaks', 'Short trips to explore urban destinations'),
       ('Cruises', 'Sea voyages with stops at various ports'),
       ('Circuits', 'Multi-destination organized tours'),
       ('Adventure Tours', 'Active and exciting experiences in nature'),
       ('Beach Holidays', 'Relaxing vacations by the sea'),
       ('Cultural Tours', 'Focused on history, art, and local traditions'),
       ('Safari & Wildlife',
        'Exploring natural habitats and observing wildlife'),
       ('Honeymoon Packages', 'Romantic getaways for newlyweds');

CREATE TABLE services
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    agency_id   INTEGER REFERENCES agencies (id),
    category_id INTEGER REFERENCES service_categories (id),
    title       TEXT NOT NULL,
    price       REAL NOT NULL,
    location    TEXT NOT NULL,
    duration    INTEGER,
    description TEXT,
    itinerary   TEXT,
    inclusions  TEXT,
    exclusions  TEXT,
    terms       TEXT
);

CREATE TABLE service_availability
(
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id      INTEGER REFERENCES services (id),
    start_date      DATE    NOT NULL,
    end_date        DATE    NOT NULL,
    capacity        INTEGER NOT NULL DEFAULT 1,
    remaining_spots INTEGER NOT NULL,
    CHECK (end_date >= start_date),
    CHECK (remaining_spots >= 0)
);

CREATE TABLE service_media (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_id INTEGER REFERENCES services(id),
    media_type TEXT NOT NULL CHECK (media_type IN ('image', 'video')),
    url TEXT NOT NULL,
    is_featured BOOLEAN DEFAULT 0,
    caption TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Booking System
CREATE TABLE bookings
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id      INTEGER REFERENCES users (id),
    service_id   INTEGER REFERENCES services (id),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status       TEXT NOT NULL CHECK (status IN
                                      ('pending', 'confirmed', 'completed',
                                       'cancelled', 'refunded'))
);

CREATE TABLE e_tickets
(
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id  INTEGER UNIQUE REFERENCES bookings (id),
    ticket_code TEXT NOT NULL UNIQUE,
    qr_code_url TEXT,
    issued_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payment System
CREATE TABLE payments
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id   INTEGER REFERENCES bookings (id),
    amount       REAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status       TEXT NOT NULL CHECK (status IN
                                      ('pending', 'completed', 'failed',
                                       'refunded'))
);

CREATE TABLE refund_disputes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER REFERENCES bookings(id),
    payment_id INTEGER REFERENCES payments(id),
    opened_by INTEGER REFERENCES users(id),
    status TEXT NOT NULL CHECK (status IN ('opened', 'under_review', 'resolved_approved', 'resolved_denied')),
    reason TEXT NOT NULL,
    customer_explanation TEXT,
    agency_response TEXT,
    admin_verdict TEXT,
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP,
    resolved_by INTEGER REFERENCES users(id)
);

-- Messaging System
CREATE TABLE messages
(
    id           INTEGER PRIMARY KEY AUTOINCREMENT,
    sender_id    INTEGER REFERENCES users (id),
    recipient_id INTEGER REFERENCES users (id),
    agency_id    INTEGER REFERENCES agencies (id),
    content      TEXT NOT NULL,
    sent_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status       TEXT NOT NULL CHECK (status IN ('sent', 'delivered', 'read'))
);

-- Notifications
CREATE TABLE notifications
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER REFERENCES users (id),
    type       TEXT NOT NULL CHECK (type IN ('booking', 'message', 'payment',
                                             'system')),
    content    TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read    BOOLEAN   DEFAULT 0
);

-- Reviews and Ratings
CREATE TABLE reviews
(
    id                INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id           INTEGER REFERENCES users (id),
    service_id        INTEGER REFERENCES services (id),
    verified_purchase BOOLEAN   DEFAULT 0,
    rating            INTEGER CHECK (rating BETWEEN 1 AND 5),
    comment           TEXT,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Admin Flags
CREATE TABLE system_settings
(
    key         TEXT PRIMARY KEY,
    value       TEXT NOT NULL,
    description TEXT,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by  INTEGER REFERENCES users (id)
);

-- Indexes
-- for foreign keys
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_service_id ON bookings (service_id);
CREATE INDEX idx_payments_booking_id ON payments (booking_id);
CREATE INDEX idx_messages_sender_id ON messages (sender_id);
CREATE INDEX idx_messages_recipient_id ON messages (recipient_id);
CREATE INDEX idx_messages_agency_id ON messages (agency_id);
CREATE INDEX idx_notifications_user_id ON notifications (user_id);
CREATE INDEX idx_reviews_user_id ON reviews (user_id);
CREATE INDEX idx_reviews_service_id ON reviews (service_id);
CREATE INDEX idx_payment_methods_user_id ON payment_methods(user_id);
CREATE INDEX idx_service_availability_service_id ON service_availability(service_id);
CREATE INDEX idx_service_availability_dates ON service_availability(start_date, end_date);
CREATE INDEX idx_e_tickets_booking_id ON e_tickets(booking_id);
CREATE INDEX idx_refund_disputes_booking_id ON refund_disputes(booking_id);
CREATE INDEX idx_refund_disputes_status ON refund_disputes(status);
CREATE INDEX idx_service_media_service_id ON service_media(service_id);
CREATE INDEX idx_agency_analytics_agency_id_date ON agency_analytics(agency_id, date);

-- for search queries
CREATE INDEX idx_services_title ON services (title);
CREATE INDEX idx_services_location ON services (location);
CREATE INDEX idx_reviews_rating ON reviews (rating);
CREATE INDEX idx_reviews_created_at ON reviews (created_at);
