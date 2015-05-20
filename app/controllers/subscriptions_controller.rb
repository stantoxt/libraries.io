class SubscriptionsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @subscriptions = current_user.subscriptions.includes(:project).order('created_at DESC').paginate(page: params[:page])
    @projects = Project.most_watched.limit(10)
  end

  def subscribe
    @subscription = current_user.subscriptions.create(project_id: params[:project_id])
    redirect_to_back_or_default project_path(@subscription.project.to_param)
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy!
    redirect_to_back_or_default project_path(@subscription.project.to_param)
  end
end
