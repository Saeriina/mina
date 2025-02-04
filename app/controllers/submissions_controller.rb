class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    @submission = current_user.submissions.build(submission_params)
    if @submission.save
      redirect_to tasks_path, success: "#{Submission.model_name.human}が作成されました。"           
    else
      flash.now[:danger] = "#{Submission.model_name.human}の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  private

    def submission_params
      params.require(:submission).permit(:title, :description, :due_date)
    end
end
