module ApplicationHelper
  def user_avatar(user)
    asset_path('user.png')
  end

  def inclination(num, first_form, second_form, third_form)
    last_digit = num % 10
  
    if last_digit == 1 && num != 11
      first_form
    elsif last_digit.between?(2, 4) && !(num % 100).between?(12, 14)
      second_form
    else
      third_form
    end
  end
end
