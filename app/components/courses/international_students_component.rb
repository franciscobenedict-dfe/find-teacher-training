module Courses
  class InternationalStudentsComponent < ViewComponent::Base
    include ViewHelper

    attr_reader :course

    def initialize(course:)
      super
      @course = course
    end

    def right_required
      if course.salaried?
        'right to work'
      else
        'right to study'
      end
    end

    def visa_type
      @visa_type ||= course.salaried? ? :skilled_worker_visa : :student_visa
    end

    def sponsorship_availability
      @sponsorship_availability ||= course.public_send("can_sponsor_#{visa_type}") ? :available : :not_available
    end

    def course_is_apprenticeship
      @course.apprenticeship?
    end
  end
end
