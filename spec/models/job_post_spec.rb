require 'rails_helper'
require 'byebug'
# matchers docs https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
# run these tests using the command rspec -f d

RSpec.describe JobPost, type: :model do
  describe "validates" do
    describe "title" do
      it "is required" do
        # Given
        job_post = JobPost.new
  
        # When
        job_post.valid?
  
        # Then
        # expect is is passed a value we're asserting
        # we can chain .to()
        # .to() accepts a assertion/expectation clause
        expect(job_post.errors.messages).to(have_key(:title))
      end
  
      it "is unique" do
        persisted_job_post = JobPost.create(title: "full stack dev", description: 'hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world', min_salary: 35_000, location: 'canada')
        job_post = JobPost.new(title: persisted_job_post.title, description: 'hello world')
  
        job_post.valid?
        expect(job_post.errors.messages).to(have_key(:title))
      end
    end

    describe "location" do
      it "is required" do
        job_post = JobPost.new

        job_post.valid?

        expect(job_post.errors.messages).to(have_key(:location))
      end
    end

    describe "description" do
      it "it required" do
        job_post = JobPost.new
  
        job_post.valid?
  
        expect(job_post.errors.messages).to(have_key(:description))
      end
  
      it "must be larger than 100 characters" do
        # Given
        job_post = JobPost.new(description: "abcd")
  
        # When
        job_post.valid?
  
        # Then
        expect(job_post.errors.messages).to(have_key(:description))
      end
    end

    describe "min_salary" do
      it "must be a number greater than 30_000" do
        # When
        job_post = JobPost.new(min_salary: 25_000)
  
        job_post.valid?
  
        # the error object on models have a method details that returns a hash with keys equal to columns that have errors. The value of those keys are an array of error messages each with a error key whose value is a validation symbol
        expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))
      end
    end
  end
end
