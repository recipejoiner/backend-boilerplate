require 'rails_helper'

RSpec.describe GraphqlSchema do 

  before{
    # reset vars and context
    prepare_query_variables({})
    prepare_context({})

    # set query
    prepare_query('
      mutation updateUser($password: String, $newPassword: String, $newPasswordConfirmation: String){
        updateUser(password: $password, newPassword: $newPassword, newPasswordConfirmation: $newPasswordConfirmation) { 
          user { 
            email
          }
        }
      }
    ')
  }

  let (:password) { "Test1234!!" }

  describe 'update' do
    
    context 'when no user exists' do
      before{
        prepare_query_variables(
          password: password, 
          new_password: password + "1",
          new_password_confirmation: password + "1"
        )
      }
      it 'is nil' do
        expect(graphql!['errors'][0]['message']).to eq("No such user, or not logged in")
      end
    end

    
    context 'when there\'s a matching user' do
      before { 
        @current_user = create(
          :user, 
          email: Faker::Internet.email, 
          password: password, 
          password_confirmation: password
        )
        prepare_context({ current_user: @current_user }) 
      }

      let(:user) {
        @current_user 
      }

      context 'when password matches confirmation' do
        before { 
          prepare_query_variables(
            password: password, 
            newPassword: password + "1",
            newPasswordConfirmation: password + "1"
          )
        }
        
        it 'returns user object' do
          user_email = graphql!['data']['updateUser']['user']['email']
          expect(user_email).to eq(user.email)
        end
      end


      context 'when password does NOT match confirmation' do
        before {
          prepare_query_variables(
            password: password, 
            newPassword: password,
            newPasswordConfirmation: password + "1"
          )
        }
        
        it 'returns error' do
          expect(graphql!['errors']).not_to eq nil
        end
      end


    end
  end

end