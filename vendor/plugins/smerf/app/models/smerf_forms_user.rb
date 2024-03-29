# This model class manages the smerf_forms_users DB table. It stores a a record
# for each form a user completes.
# 

class SmerfFormsUser < ActiveRecord::Base
  has_many :smerf_responses,
           :dependent => :destroy
  validates_presence_of :responses
  validates_presence_of :user_id
  validates_presence_of :smerf_form_id
  belongs_to :user
  belongs_to :smerf_form
  
  # We save the form responses to the DB in yaml format
  serialize :responses  
  
  # This method finds the form record for the specified user and form
  #
  def SmerfFormsUser.find_user_smerf_form(user_id, smerf_form_id)
    # Find the form record for the current user
    smerf_forms_user = nil
    if (user_id > 0)
      smerf_forms_user = SmerfFormsUser.find(:first, 
        :conditions => ['smerf_form_id = ? AND user_id = ?', 
        smerf_form_id, user_id])
    else
      raise(RuntimeError, 
        "Para o formul�rio de respostas ser salvo para um usu�rio, um ID de registro para 
        a tabela de usu�rios precisa ser especificada. Isso pode ser arranjado usando 
        a fun��o 'self.smerf_user_id', por exemplo 'self.smerf_user_id = 1'")
    end
    
    return smerf_forms_user
  end

  # Create a record for the user for the current form
  #
  def SmerfFormsUser.create_records(smerf_form_id, user_id, responses)
    transaction do
      # Create the record for the user
      smerf_forms_user = SmerfFormsUser.create(
            :user_id => user_id,
            :smerf_form_id => smerf_form_id,
            :responses => responses)
      # Create response records for all user responses
      responses.each do |question_response|
        # Check if response is a hash, if so process each response 
        # individually, i.e. each response to a question will have it's
        # own response record
        if (question_response[1].kind_of?(Hash) or 
          question_response[1].kind_of?(Array))
          question_response[1].each do |multichoice_response|
            # Bug fix 0.0.4 (thanks Alan Masterson) 
            response = multichoice_response.kind_of?(Array) ? multichoice_response[1] : multichoice_response
            smerf_forms_user.smerf_responses << SmerfResponse.new(
              :question_code => question_response[0],
              :response => response) if (!response.blank?())           
          end
        else          
          smerf_forms_user.smerf_responses << SmerfResponse.new(
            :question_code => question_response[0],
            :response => question_response[1]) if (!question_response[1].blank?()) 
        end
      end
    end
  end

  # Update a record for the user for the current form
  #
  def SmerfFormsUser.update_records(smerf_form_id, user_id, responses)
    transaction do
      # Retrieve the response record for the current user
      smerf_forms_user = SmerfFormsUser.find_user_smerf_form(
        user_id, smerf_form_id)
      if (smerf_forms_user)
        # Update the record with the new responses 
        smerf_forms_user.update_attribute(:responses, responses)
        # Update response records, we use the activerecord replace method
        # First we find all the existing responses records for this form
        current_responses = SmerfResponse.find(:all, 
          :conditions => ["smerf_forms_user_id = ?", smerf_forms_user.id])  
        # Process responses, if the response has not changed or it's a new 
        # response add it to the array which we will pass to the replace method.
        # This method will add the new one's, and delete one's that are not in
        # the array
        new_responses = Array.new()
        responses.each do |question_response|
          # Check if response is a hash, if so process each response 
          # individually, i.e. each response to a question will have it's
          # own response record
          if (question_response[1].kind_of?(Hash) or 
            question_response[1].kind_of?(Array))
            question_response[1].each do |multichoice_response|
              if (!multichoice_response[1].blank?())
                # Check if this response already exists, if so we add the 
                # SurveyResponse object to the array, otherwise we create a 
                # new response object
                #
                if (found = self.response_exist?(current_responses, 
                  question_response[0], multichoice_response[1]))
                  new_responses << found
                else  
                  new_responses << (SmerfResponse.new(
                    :smerf_forms_user_id => smerf_forms_user.id, 
                    :question_code => question_response[0],
                    :response => multichoice_response[1]))           
                end
              end
            end
          else       
              if (!question_response[1].blank?()) 
                # Check if this response already exists, if so we add the 
                # SurveyResponse object to the array, otherwise we create a 
                # new response object
                #
                if (found = self.response_exist?(current_responses, 
                  question_response[0], question_response[1]))
                  new_responses << found
                else  
                  new_responses << (SmerfResponse.new(
                    :smerf_forms_user_id => smerf_forms_user.id, 
                    :question_code => question_response[0],
                    :response => question_response[1]))
                end
              end
          end
        end
        # Pass the array that holds existing(unchanged) responses as well
        # as new responses to the replace method which will generate deletes
        # and inserts as required
        smerf_forms_user.smerf_responses.replace(new_responses)
      end
    end
  end
  
  private
  
    # This method checks the responses from the form against those currently 
    # stored in the DB for this form and question. If it exists it will return 
    # the SmerfResponse object retrieved from the DB, otherwise it will return nil
    #
    def SmerfFormsUser.response_exist?(current_responses, question_code, response)
      response_object = nil
      begin
        current_responses.each do |current_response|
          if (current_response.question_code == question_code and
            current_response.response == response)
            response_object = current_response            
            raise
          end
        end
      rescue
        
      end
      
      return response_object
    end
  
end
