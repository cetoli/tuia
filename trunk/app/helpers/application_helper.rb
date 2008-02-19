# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nice_date(date)
    h date.strftime("%A, %d de %B de %Y")
  end

  def nice_date_time(date)
    h date.strftime("%A, %d de %B de %Y - %H:%M:%S")
  end

  def short_date(date)
    h date.strftime("%d/%m/%Y")
  end

  def short_date_time(date)
    h date.strftime("%d/%m/%Y - %H:%M:%S")
  end
end
