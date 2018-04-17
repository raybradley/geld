module ApplicationHelper
  def abbreviated_distance_of_time_in_words_to_now(from_date)
    # result = distance_of_time_in_words_to_now(from_date)
    # # return result

    # result.gsub!('about',   '')
    # result.gsub!('days',    'd')
    # result.gsub!('day',     'd')
    # result.gsub!('months',  'm')
    # result.gsub!('month',   'm')
    # result.gsub!('weeks',   'w')
    # result.gsub!('week',    'w')


    "#{((Date.today - from_date).abs.to_i)}d"
  end
end
