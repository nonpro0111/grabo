class ContactsController < ApplicationController

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        notify_slack
        format.html { redirect_to finish_contacts_path, notice: '送信しました' }
      else
        format.html { render :new }
      end
    end
  end

  def finish
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:email, :title, :body)
    end

    def notify_slack
      message = "From: #{@contact.email}\nタイトル: #{@contact.title}\n 内容: #{@contact.body}"
      notifier = Slack::Notifier.new(Rails.application.config.slack_webhook_url)
      notifier.ping(message)
    end
end
