class BirdsController < ApplicationController
#if method no.2 is used please add 
# rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
#plus the following route example: 
  # GET /birds/:id
  # def show
  #   bird = find_bird
  #   render json: bird
  # end


  # GET /birds (regular method)
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = find_by_bird
    if bird
      render json: bird
    else
      render_not_found_response
    end
  end
  
  #OR 
# def show
#   bird = find_bird
#   render json: bird
# rescue ActiveRecord::RecordNotFound
#    render_not_found_response
# end

  # PATCH /birds/:id
  def update
    bird = find_by_bird
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render_not_found_response
    end
  end

  #OR 
# def update
#   bird = find_bird
#   bird.update(bird_params)
#   render json: bird
# rescue ActiveRecord::RecordNotFound
#   render_not_found_response
# end


  # PATCH /birds/:id/like
  def increment_likes
    bird = find_by_bird
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render_not_found_response
    end
  end

  # DELETE /birds/:id
  def destroy
    bird = find_by_bird
    if bird
      bird.destroy
      head :no_content
    else
      render_not_found_response
    end
  end

  private

  #method no.1
  def find_by_bird 
    Bird.find_by(id:params[:id])
  end

  #Exception handling - method no.2
  def find_bird 
    Bird.find(params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def render_not_found_response 
    render json: {error: "Bird not found"}, status: :not_found
  end

end
