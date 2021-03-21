class InquiryMailer < ApplicationMailer
  default to: ENV['SEND_MAIL']   # お問い合わせを管理したいアドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:from => inquiry.email, :subject => 'お問い合わせを承りました')
  end

  def send_email(inquiry)
    @inquiry = inquiry
    mail(:to => inquiry.email, :subject => 'お問い合わせありがとうございます')
  end
end
