module DestroyableUpload
  extend ActiveSupport::Concern

  included do
    def destroy_upload
      attachment = ActiveStorage::Attachment.find(params[:upload_id])
      attachment.purge
      flash[:notice] = "L'élément a bien été supprimé"
      redirect_action = params[:redirect] || :index
      redirect_to action: redirect_action
    end

  end

  private

end
