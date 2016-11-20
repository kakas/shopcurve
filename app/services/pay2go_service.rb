class Pay2goService
  attr_reader :amt, :merchant_order_no, :time_stamp, :url
  attr_reader :callback, :payment_method, :message

  def initialize(shop, order, callback_data = nil)
    @shop = shop
    @amt = order.total_price.to_i
    @merchant_order_no = "#{order.id}s#{order.created_at.strftime("%Y%m%d%H%M%S")}"

    if !callback_data
      @time_stamp = order.created_at.to_i
      @url = "https://capi.pay2go.com/MPG/mpg_gateway"
    else
      @callback = parse_callback(callback_data)
      @payment_method = @callback["Result"]["PaymentType"]
      @message = @callback["Message"]
    end
  end

  # send to pay2go
  def check_value
    Digest::SHA256.hexdigest(mpg_string).upcase
  end

  # callback check
  def check_code
    d = callback_string(@callback["Result"]["TradeNo"])
    Digest::SHA256.hexdigest(d).upcase
  end

  def success?
    @callback["Status"] == "SUCCESS" && check_code == @callback["Result"]["CheckCode"]
  end

  private

  def parse_callback(callback_data)
    callback = JSON.parse(callback_data)
    callback["Result"] = JSON.parse(callback["Result"])
    callback
  end

  def mpg_string
    "HashKey=#{@shop.hash_key}&Amt=#{@amt}&MerchantID=#{@shop.merchant_id}&MerchantOrderNo=#{@merchant_order_no}&TimeStamp=#{@time_stamp}&Version=1.2&HashIV=#{@shop.hash_iv}"
  end

  def callback_string(trade_no)
    "HashIV=#{@shop.hash_iv}&Amt=#{@amt}&MerchantID=#{@shop.merchant_id}&MerchantOrderNo=#{@merchant_order_no}&TradeNo=#{trade_no}&HashKey=#{@shop.hash_key}"
  end
end
