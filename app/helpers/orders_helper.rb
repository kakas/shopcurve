module OrdersHelper

  def render_expire_time(order)
    if order.expire_time?
      content_tag :p, class: "text-success" do
        "Expire Time: #{order.expire_time}"
      end
    end
  end

  def render_bank_code(order)
    if order.bank_code?
      content_tag :p, class: "text-success" do
        "Bank Code: #{order.bank_code}"
      end
    end
  end

  def render_code_no(order)
    if order.code_no?
      content_tag :p, class: "text-success" do
        "Code No: #{order.code_no}"
      end
    end
  end

  def render_status(order, status)
    t "order.enums.#{status}.#{order.send(status)}"
  end

end
