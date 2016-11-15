require 'csv'

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol


def clean_phone_number(dirty)
  
  # delete non digit characters
  dirty.gsub!(/\D+/, "")
    
  if (dirty.length < 10)
    return "(000) 000-0000"
  end

  if (dirty.length > 11)
    return "(000) 000-0000"
  end  
  
  phone = ""
  if (dirty.length == 11)
    if dirty[0] == "1"
      phone = dirty[1..10]
    else
      return "(000) 000-0000"
    end
  else
    phone = dirty
  end
  
  "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}"
    
end


contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone_number = clean_phone_number(row[:homephone])
  
  puts "#{id} #{name} #{phone_number}"
end