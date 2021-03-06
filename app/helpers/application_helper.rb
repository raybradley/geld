module ApplicationHelper
  def abbreviated_distance_of_time_in_words_to_now(from_date)
    "#{((Date.today - from_date).abs.to_i)}d"
  end

  def account_glyph(account)
    glyphs = {
      :credit_card => 'credit-card',
      :checking    => 'money',
      :savings     => 'piggy-bank',
    }

    "<i class=\"far fa-#{glyphs[account.type.downcase.to_sym]}\"></i>"
  end

  def additional_classes
    @additional_classes
  end
end
