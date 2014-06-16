class UploadController < ApplicationController
  layout "profile" 
  before_action :authenticate_user!
  def new    
    @user_action="My Albums"
    @albumb=Albumb.new
    @albumb.images.build
    if params[:search]
         @all_albumb = Albumb.search(params[:search])
         @images= Image.search(params[:search])
    else           
       
         @all_albumb=Albumb.all
          
    end
  end
  def create
    @albumb=Albumb.new(albumb_params)
    @albumb.user_id=current_user.id
    @albumb.save  
    redirect_to new_upload_path      
  end
  
 def show
    @user_action="Album images"   
    @albumb=Albumb.find(params[:id])
    @images=@albumb.images
    @image=Image.new 
      
 end
  
  def create_image
    
     @image=Image.new(image_params)
     
     @image.albumb_id=params[:upload_id]
     
     @image.save 
     redirect_to upload_path(params[:upload_id]) 
  
  end
 
  def destroy
    @album= Albumb.find(params[:id])
    @album.destroy
    redirect_to new_upload_path
    
  end
  
  def view
    if params[:tag]
    @images = Image.tagged_with(params[:tag])
    else
      render text: "something going wrong"
    end
    
  end
  
  private
  def albumb_params
    params.require(:albumb).permit(:name, :description, images_attributes: [:name, :avatar, :tag_list])
  end
  def image_params
    params.require(:image).permit(:name, :avatar, :tag_list)
  end
end
