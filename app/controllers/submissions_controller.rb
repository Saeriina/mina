class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    @submission = current_user.submissions.build(submission_params)
    if @submission.save
      redirect_to tasks_path, success: "提出物が登録されました。"
    else
      flash.now[:danger] = "提出物の登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  private

    def submission_params
      params.require(:submission).permit(:title, :description, :due_date)
    end
end
