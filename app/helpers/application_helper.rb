module ApplicationHelper
  def abbreviated_distance_of_time_in_words_to_now(from_date)
    "#{((Date.today - from_date).abs.to_i)}d"
  end

  def account_glyph(account)
    glyphs = {
      :credit_card => 'credit-card',
      :checking    => 'money',
      :savings     => 'money-alt'
    }

    puts account.account_type.to_sym
    puts glyphs[account.account_type]

    "<i class=\"fa fa-#{glyphs[account.account_type.to_sym]}\"></i>"
  end

  def additional_classes
    @additional_classes
  end
end
