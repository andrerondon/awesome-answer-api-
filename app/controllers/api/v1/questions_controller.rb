class Api::V1::QuestionsController < Api::ApplicationController
    def index
      questions = Question.order(created_at: :desc)
      render json: questions
    end
  
    def show
      # /api/v1/questions/:id
      question = Question.find params[:id]
      render json: question
    end
  
    def create
      byebug
      question = Question.new params.require(:question).permit(:title, :body, :tag_names)
      question.user = current_user
      if question.save
        render json: { id: question.id }
      else
        render json: { error: question.errors }
      end
    end
  end
  