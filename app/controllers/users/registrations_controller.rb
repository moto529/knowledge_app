# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  #必須  更新（編集の反映）時にパスワード入力を省く
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  #任意  更新後のパスを指定
  def after_update_path_for(resource)
    timeline_knowledges_path
  end
end
