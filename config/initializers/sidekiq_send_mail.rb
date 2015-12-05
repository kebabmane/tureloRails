ActionMailer::Base.register_interceptor(SidekiqSendMail::MailInterceptor)
