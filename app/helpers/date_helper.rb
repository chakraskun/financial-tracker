module DateHelper
  def readable_date date
    return "-" unless date.present?
    I18n.l(date, format: '%A, %d %B %Y')
  end

  def readable_date_2 date
    return "-" unless date.present?
    I18n.l(date, format: '%-d %B %Y')
  end

  def readable_date_3 date
    return "-" unless date.present?
    I18n.l(date, format: '%d-%m-%Y')
  end

  def readable_date_en date
    return "-" unless date.present?
    I18n.l(date, format: '%-d %B %Y', locale: :en)
  end

  def readable_timestamp date
    return "-" unless date.present?
    I18n.l(date, format: '%A, %d %B %Y %H:%M')
  end

  def readable_timestamp_2 date
    return "-" unless date.present?
    I18n.l(date, format: '%d %B %Y %H:%M')
  end

  # used in shipments/show for id branch jakarta & batam (WIB)
  def readable_timestamp_2_id date
    return "-" unless date.present?
    TZInfo::Timezone.get('Asia/Jakarta').to_local(date).strftime('%A, %-d %B %Y %H:%M WIB')
  end

  # used in shipments/show for id branch singapore (SGT)
  def readable_timestamp_2_sg date
    return "-" unless date.present?
    TZInfo::Timezone.get('Asia/Singapore').to_local(date).strftime('%A, %-d %B %Y %H:%M SGT')
  end

  def readable_timestamp_3_id date
    return "-" unless date.present?
    TZInfo::Timezone.get('Asia/Jakarta').to_local(date).strftime('%-d/%m/%y %H:%M WIB')
  end

  def readable_timestamp_3_sg date
    return "-" unless date.present?
    TZInfo::Timezone.get('Asia/Singapore').to_local(date).strftime('%-d/%m/%y %H:%M SGT')
  end

  def readable_timestamp_3 date
    return "-" unless date.present?
    I18n.l(date, format: '%d %B %Y %H:%M:%S')
  end

  def readable_hour date
    return "-" unless date.present?
    I18n.l(date, format: '%H:%M:%S')
  end

  def html_input_date date
    return '' unless date.present?
    I18n.l(date, format: '%d/%m/%Y')
  end
end
