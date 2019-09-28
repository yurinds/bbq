# frozen_string_literal: true

module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def declination(number, krokodil, krokodila, krokodilov)
    # Сначала, проверим входные данные на правильность
    number = 0 if number.nil? || !number.is_a?(Numeric)

    # Так как склонение определяется последней цифрой в числе, вычислим остаток
    # от деления числа number на 10
    remainder = number % 10

    # Вычислим остаток от деления числа number на 100 для обхода ситуаций с числами 111-114
    big_remainder = number % 100

    if (11..14).cover?(big_remainder)
      # 111-114 — родительный падеж и множественное число (111 Кого?/Чего? —
      # крокодилов)
      krokodilov
    else
      case remainder
      when 1
        # Для 1 — именительный падеж (Кто?/Что? — крокодил)
        krokodil
      when (2..4)
        # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодила)
        krokodila
      else
        # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
        # крокодилов)
        krokodilov
     end
    end
  end
end
