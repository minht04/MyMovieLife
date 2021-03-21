class InquiryMailer < ApplicationMailer
  default to: ENV['SEND_MAIL']   # お問い合わせを管理したアドレス

  def received_email(inquiry)
    @inquiry = inquiry
    mail(:from => inquiry.email, :subject => 'お問い合わせを承りました')
  end
end
