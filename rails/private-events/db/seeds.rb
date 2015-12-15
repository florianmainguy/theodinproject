
flo = User.create!(name:  "flo")
event1 = flo.created_events.create!(date: '2015-12-12', location: 'Lichfield', description: 'Top Cool')

ginny = User.create!(name:  "ginny")
event2 = ginny.created_events.create!(date: '2016-12-12', location: 'Lichfield', description: 'Plus Cool')

event1.attendees.create!(name: 'ginny')
event2.attendees.create!(name: 'flo')