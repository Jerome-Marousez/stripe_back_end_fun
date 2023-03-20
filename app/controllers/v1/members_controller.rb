class V1::MembersController < V1::ApiController
	protect_from_forgery except: [:create, :update]

	def index
		@members = Member.all
	end

	def show
		@member = Member.find(params[:id])
    render json: { error: 'could not find member' }, status: 404 unless @member.present?
	end

	def create

	end

end