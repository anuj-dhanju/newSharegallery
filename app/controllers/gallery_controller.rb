class GalleryController < ApplicationController
  
  def index
    
    
    @i=1
    if Image.limit(20).count<1
      render text: "something going wrong"
    else
      @images=Image.limit(8)
      
    end
    
    
    
  end
end
