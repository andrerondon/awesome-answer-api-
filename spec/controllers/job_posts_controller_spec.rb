require "rails_helper"

RSpec.describe JobPostsController, type: :controller do 
   describe "#new" do 
    it "renders the new template" do 
        # GIVEN
        # Defaults
    
        # WHEN
        # Making a GET request to the new action
        get(:new)
        # THEN
        # The 'response' object contains the rendered template 'new'
        # The response object is available inside any controller. It 
        # is similar to 'response' available in Express middleware,
        # however, we rarely interact with it in Rails. RSpec makes
        # it available when testing, in order to verify its contents.
    
        # Here we verify with the 'render_template' matcher that it
        # contains the right rendered template.
        expect(response).to(render_template(:new))
    end
    it "sets an instance variable with a new job post" do 
        get(:new)
        # assign(:job_post) - returns the value of an instance 
        # variable @job_post from the instance of our 
        # JobPostsController.
        # Only available if the gem 'rails-controller-testing' is 
        # added.
        expect(assigns(:job_post)).to(be_a_new(JobPost))
        # The above matcher (be_a_new) will verify that the expected
        # value is a new instance of the JobPost model 
    end
   end 
end