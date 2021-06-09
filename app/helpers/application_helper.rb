module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  # def current_company
  #   current_user.company if current_user.present?
  # end

  def transform_money_format_from_request_to_normal money
    return nil unless money.present?
    result = money.gsub(/\./, '')
    result = result.gsub(/\,/, '.')
  end

  def thousand_separator number
    result = number.to_money.format.split('Rp.')[1]
    result.split(',00')[0]
  end

  def wicked_pdf_image_tag_for_public(img, options={})
    if img[0] == "/"        
      new_image = img.slice(1..-1)
      image_tag "file://#{Rails.root.join('public', new_image)}", options
    else        
        image_tag img
    end
  end   
end
