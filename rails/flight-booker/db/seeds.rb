sfo = Airport.create(name: 'SFO')
nyc = Airport.create(name: 'NYC')
paris = Airport.create(name: 'PARIS')
london = Airport.create(name: 'LONDON')
tokyo = Airport.create(name: 'TOKYO')

sfo.departing_flights.create(stop_airport_id: 2, start_time: '2016-01-01 12:00:00', duration: 120)
paris.departing_flights.create(stop_airport_id: 4, start_time: '2016-02-01 13:00:00', duration: 60)
paris.departing_flights.create(stop_airport_id: 5, start_time: '2016-03-01 14:00:00', duration: 240)