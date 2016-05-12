class MyurlsController < ApplicationController
 

  def thishowedoprivaterkm678rsm
    @myurls = Myurl.all
  end

  def new
    @myurl = Myurl.new()
  end

  def create
    @myurl = Myurl.new(myurl_params)

    if @myurl.valid?

      if @myurl.url =~ /\A#{URI::regexp}\z/
        @myurl.key = @myurl.key.gsub(/\s+/, "")

      	if @myurl.key.nil? || @myurl.key == ""
          @myurl.save
          @myurl.key = @myurl.id.to_s(16)
          @myurl.save
          redirect_to(:action => 'new',:createdurl => "http://xyzurl.com/#{@myurl.key}")

        elsif Myurl.find_by_key(@myurl.key).nil?
          @myurl.save
          redirect_to(:action => 'new',:createdurl => "http://xyzurl.com/#{@myurl.key}")
          
        
        elsif !Myurl.find_by_key(@myurl.key).nil?
            flash.now[:notice] = "The tag is unavailable, please try another!"
            @myurl.key = nil
            render('new')

      	end
      else
        flash.now[:notice] = "Invalid Url. Please add prefix http:// or https://. Url should be like this http://www.example.com."
        render('new')
      end
    else
      flash.now[:notice] = "Url can't be blank. Please enter url."
      render('new')
    end
  end

  def edit

  end

  def delete
    Myurl.find(params[:myurl_id]).destroy
    redirect_to(:action => 'thishowedoprivaterkm678rsm')
  end

  def redirect
    if Myurl.find_by_key(params[:key]).nil?
      flash.now[:notice] = "Given url is not a generated or valid url. Create Now."
      render('new')
    else
      redirect_to(Myurl.find_by_key(params[:key]).url)
    end
  end

  private

    def myurl_params
      params.require(:myurl).permit(:key,:url)
    end
end
