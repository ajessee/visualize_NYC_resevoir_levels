# Get Resevoir Levels from NYC Open Data API

module Parser

  RESEVOIR_INFO = {
    "Neversink" => {
      capacity: 34_900,
      station_number: "01435900",
      min_elev: 1314.0,
      max_elev: 1445.0
    },
    "Cannonsville" => {
      capacity: 95_700,
      station_number: "01424997",
      min_elev: 1035.0,
      max_elev: 1160.0 
    },
    "Schoharie" => {
      capacity: 17_600,
      station_number: "01350100",
      min_elev: 1050.0,
      max_elev: 1140.0 
    },
    "Pepacton" => {
      capacity: 140_200,
      station_number: "01416900",
      min_elev: 1143.0,
      max_elev: 1284.0 
    },
    "Rondout" => {
      capacity: 49_600,
      station_number: "01366400",
      min_elev: 720.0,
      max_elev: 843.0
    }
  }

  RESEVOIR_ARRAY = []

  def self.import

    final_array =[]

    data = load_json

    build_array(data)

    RESEVOIR_ARRAY.each do |info_hash|
      final_array << Resevoir.new(info_hash)
    end

    final_array
  end

  # Get data from USGS, parse and prune to branch we need
  def self.load_json
    today = get_today
    data = open("https://waterservices.usgs.gov/nwis/dv/?format=json&sites=01435900,01424997,01350100,01416900,01366400&startDT=2007-03-01&endDT=#{today}&siteStatus=all").read
    data = JSON.parse(data)["value"]["timeSeries"]
  end

  def self.get_today
    year = Time.now.year.to_s
    if Time.now.month < 10
      month = "0#{Time.now.month}"
    else
      month = Time.now.month.to_s
    end
    if Time.now.day < 10
      day = "0#{Time.now.day}"
    else
      day = Time.now.day.to_s
    end
    "#{year}-#{month}-#{day}"
  end

  # Build an array made of of hashes with station number, resevoir name, and time and elevation data
  def self.build_array(data)
    data.each do |packet|
      data_hash = {} 
      packet.each do |key, value| 
        case (key)
          when "sourceInfo"
            # Get station number
             data_hash[:station_number] = value["siteCode"][0]["value"]
             # Get resevoir name by matching to RESEVOIR INFO
             RESEVOIR_INFO.each do |resevoir, information|
               if information[:station_number] == data_hash[:station_number]
                 data_hash[:name] = resevoir
               end
             end
          when "values"
            # Get time and elevation data, encaplsulate in objects and put in hash
            data_hash[:data] = get_data_objects(value[0]["value"], data_hash[:name])
        end
      end
        RESEVOIR_ARRAY.push(data_hash)
    end
    
  end

  # Return array of objects that represent all data points for resevoir
  def self.get_data_objects(data, resevoir)
    data.each_with_object([]) do |(row), data_points|
      date_field = Time.parse(row["dateTime"])
      date_field = "Year: #{date_field.year}\nMonth: #{Date::MONTHNAMES[date_field.month]}\nDay: #{date_field.day}"
      elevation_from_min = (row["value"].to_f - RESEVOIR_INFO[resevoir][:min_elev]).to_s
      args = {date: date_field, level: elevation_from_min, min: RESEVOIR_INFO[resevoir][:min_elev], max: RESEVOIR_INFO[resevoir][:max_elev]}
      if args[:date] == nil || args[:level] == nil
        debugger
        next
      else
        data_points << DataPoint.new(args)
      end
    end
  end
end
