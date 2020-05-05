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

   describe "#create" do 
    # 'context' is funcationally the same as 'describe', but
    # we use context to group branching code paths. 
    context "with valid parameters" do 
        def valid_request 
            # The post method below simulates an HTTP request to the 
            # create action of JobPostsController using the POST verb 
            # This has the effect of a user filling out our new form 
            # in a browser and submitting
            post(:create, params: { job_post: FactoryBot.attributes_for(:job_post) })
        end

        it "creates a job post in the db" do 
            count_before = JobPost.count
            valid_request
            count_after = JobPost.count 
            expect(count_after).to(eq(count_before + 1))
        end

        it "redirects us to the show page for that job post" do 
            valid_request
            job_post = JobPost.last 
            expect(response).to(redirect_to(job_post_url(job_post.id)))
        end
    end

    context "with invalid parameters" do 
        def invalid_request 
            post(:create, params: { job_post: FactoryBot.attributes_for(:job_post, title: nil) })
        end

        it "doesn't save a job post in the db" do
            count_before = JobPost.count 
            invalid_request 
            count_after = JobPost.count 
            expect(count_after).to eq(count_before)
        end

        it "renders the new template" do 
            invalid_request
            expect(response).to render_template(:new)
        end

        it "assigns an invalid job_post as an instance variable" do 
            invalid_request
            expect(assigns(:job_post)).to be_a(JobPost)
            expect(assigns(:job_post).valid?).to be(false)
        end
    end
   end

   describe "#show" do 
    it "render show template" do 
        job_post = FactoryBot.create(:job_post)
        get(:show, params: {id: job_post.id })
        expect(response).to render_template(:show)
    end

    it "sets an instance variable @job_post for the shown object" do 
        job_post = FactoryBot.create(:job_post)
        get(:show, params: { id: job_post.id })
        expect(assigns(:job_post)).to eq(job_post)
    end
   end
end