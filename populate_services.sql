INSERT INTO users (username, email, password_hash, role, auth_provider) VALUES
('wanderlust_travels', 'wanderlust@travel.com', 'dummy_hash_1', 'agency', 'local'),
('global_explorers', 'explorers@travel.com', 'dummy_hash_2', 'agency', 'local'),
('dream_vacations', 'dream@vacations.com', 'dummy_hash_3', 'agency', 'local');

INSERT INTO agencies (user_id, name, banner_url, logo_url, address, phone) VALUES
(1, 'Wanderlust Travels', 'https://picsum.photos/1200/300', 'https://picsum.photos/200/200', '123 Travel Street, Adventure City', '+1-555-0101'),
(2, 'Global Explorers', 'https://picsum.photos/1200/300', 'https://picsum.photos/200/200', '456 Explorer Avenue, Discovery Town', '+1-555-0102'),
(3, 'Dream Vacations', 'https://picsum.photos/1200/300', 'https://picsum.photos/200/200', '789 Vacation Road, Paradise City', '+1-555-0103');

INSERT INTO services (agency_id, category_id, title, price, location, duration, description, itinerary, inclusions, exclusions, terms) VALUES
(1, 1, 'Paris City Break', 899.99, 'Paris, France', 4, 'Experience the magic of Paris with our exclusive city break package.', 'Day 1: Eiffel Tower, Day 2: Louvre Museum, Day 3: Notre Dame, Day 4: Shopping', 'Hotel, Breakfast, Metro Pass', 'Flights, Lunch, Dinner', 'Cancellation 7 days before'),
(1, 4, 'Swiss Alps Adventure', 1299.99, 'Interlaken, Switzerland', 5, 'Thrilling adventure in the Swiss Alps with hiking and skiing.', 'Day 1: Arrival, Day 2-4: Activities, Day 5: Departure', 'Accommodation, Equipment, Guide', 'Flights, Meals', 'Weather dependent'),
(1, 6, 'Rome Cultural Tour', 799.99, 'Rome, Italy', 3, 'Immerse yourself in Roman history and culture.', 'Day 1: Colosseum, Day 2: Vatican, Day 3: Roman Forum', 'Hotel, Guide, Entry Fees', 'Flights, Meals', 'Standard terms'),
(1, 5, 'Greek Island Escape', 1499.99, 'Santorini, Greece', 7, 'Luxury beach holiday in the Greek Islands.', '7 days of relaxation and island exploration', 'Hotel, Breakfast, Transfers', 'Flights, Activities', 'Seasonal rates apply'),
(1, 2, 'Mediterranean Cruise', 1999.99, 'Mediterranean Sea', 7, 'Cruise through the beautiful Mediterranean.', 'Various ports of call', 'Cabin, Meals, Entertainment', 'Excursions, Drinks', 'Cruise terms apply'),
(1, 3, 'European Circuit', 2499.99, 'Multiple Cities', 10, 'Tour through major European cities.', 'Multiple cities itinerary', 'Hotels, Transport, Breakfast', 'Flights, Activities', 'Flexible booking'),
(1, 8, 'Venice Honeymoon', 1799.99, 'Venice, Italy', 5, 'Romantic getaway in Venice.', 'Gondola rides and city exploration', 'Hotel, Breakfast, Activities', 'Flights, Dinner', 'Special honeymoon terms');

INSERT INTO services (agency_id, category_id, title, price, location, duration, description, itinerary, inclusions, exclusions, terms) VALUES
(2, 1, 'Tokyo City Break', 1299.99, 'Tokyo, Japan', 4, 'Explore the vibrant city of Tokyo.', 'Day 1: Shibuya, Day 2: Asakusa, Day 3: Shinjuku, Day 4: Akihabara', 'Hotel, Metro Pass, Guide', 'Flights, Meals', 'Standard terms'),
(2, 4, 'New Zealand Adventure', 2499.99, 'Queenstown, New Zealand', 7, 'Adventure activities in New Zealand.', 'Various adventure activities', 'Accommodation, Equipment', 'Flights, Meals', 'Weather dependent'),
(2, 6, 'Kyoto Cultural Tour', 999.99, 'Kyoto, Japan', 4, 'Traditional Japanese culture experience.', 'Temples and gardens tour', 'Hotel, Guide, Entry Fees', 'Flights, Meals', 'Cultural terms'),
(2, 5, 'Maldives Beach Holiday', 2999.99, 'Maldives', 7, 'Luxury beach resort stay.', 'Beach activities and relaxation', 'Resort, Meals, Activities', 'Flights, Spa', 'Resort terms'),
(2, 2, 'Caribbean Cruise', 1799.99, 'Caribbean Sea', 7, 'Island hopping in the Caribbean.', 'Multiple island stops', 'Cabin, Meals, Entertainment', 'Excursions, Drinks', 'Cruise terms'),
(2, 3, 'Asian Circuit', 1999.99, 'Multiple Cities', 10, 'Tour through Asian capitals.', 'Multiple cities itinerary', 'Hotels, Transport, Breakfast', 'Flights, Activities', 'Flexible booking'),
(2, 8, 'Bali Honeymoon', 1599.99, 'Bali, Indonesia', 7, 'Romantic escape to Bali.', 'Beach and cultural activities', 'Resort, Breakfast, Activities', 'Flights, Dinner', 'Honeymoon terms');

INSERT INTO services (agency_id, category_id, title, price, location, duration, description, itinerary, inclusions, exclusions, terms) VALUES
(3, 1, 'New York City Break', 1099.99, 'New York, USA', 4, 'Experience the Big Apple.', 'Day 1: Manhattan, Day 2: Museums, Day 3: Shopping, Day 4: Broadway', 'Hotel, Metro Card, Guide', 'Flights, Meals', 'Standard terms'),
(3, 4, 'Costa Rica Adventure', 1899.99, 'Costa Rica', 7, 'Rainforest and beach adventure.', 'Various adventure activities', 'Accommodation, Guide, Equipment', 'Flights, Meals', 'Weather dependent'),
(3, 6, 'Machu Picchu Tour', 1499.99, 'Peru', 5, 'Ancient Incan ruins exploration.', 'Machu Picchu and surrounding areas', 'Hotel, Guide, Entry Fees', 'Flights, Meals', 'Altitude terms'),
(3, 5, 'Maui Beach Holiday', 1999.99, 'Maui, Hawaii', 7, 'Paradise beach vacation.', 'Beach and island activities', 'Resort, Breakfast, Activities', 'Flights, Dinner', 'Resort terms'),
(3, 2, 'Alaska Cruise', 2499.99, 'Alaska', 7, 'Glacier and wildlife cruise.', 'Glacier viewing and wildlife spotting', 'Cabin, Meals, Entertainment', 'Excursions, Drinks', 'Cruise terms'),
(3, 3, 'USA West Coast Circuit', 2999.99, 'Multiple Cities', 10, 'Tour the American West Coast.', 'Multiple cities itinerary', 'Hotels, Transport, Breakfast', 'Flights, Activities', 'Flexible booking'),
(3, 8, 'Maldives Honeymoon', 3999.99, 'Maldives', 7, 'Luxury overwater bungalow stay.', 'Private beach and water activities', 'Resort, All-inclusive', 'Flights, Spa', 'Honeymoon terms');

INSERT INTO service_availability (service_id, start_date, end_date, capacity, remaining_spots)
SELECT 
    id,
    date('now'),
    date('now', '+7 days'),
    20,
    20
FROM services;

INSERT INTO service_media (service_id, media_type, url, is_featured, caption)
SELECT 
    id,
    'image',
    'https://picsum.photos/800/600',
    1,
    title || ' - Featured Image'
FROM services;

INSERT INTO service_media (service_id, media_type, url, is_featured, caption)
SELECT 
    id,
    'image',
    'https://picsum.photos/800/600',
    0,
    title || ' - Gallery Image 1'
FROM services;

INSERT INTO service_media (service_id, media_type, url, is_featured, caption)
SELECT 
    id,
    'image',
    'https://picsum.photos/800/600',
    0,
    title || ' - Gallery Image 2'
FROM services;