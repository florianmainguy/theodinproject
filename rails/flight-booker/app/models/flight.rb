class Flight < ActiveRecord::Base
  belongs_to :start_airport, class_name: "Airport"
  belongs_to :stop_airport, class_name: "Airport"
end
