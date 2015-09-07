class MyOverriddenMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that you mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    if record.name.present?
      opts[:subject] = "Welcome #{record.name}, confirm your account#{Time.now.asctime }"
    else
      opts[:subject] = "Confirm your Qitch.com account"
    end

    super
  end

end