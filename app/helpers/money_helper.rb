module MoneyHelper
  def format_money_mtu_iso money
    formatted_money = money.format
    formatted_money = formatted_money.gsub('Rp.', '')
  end
end
