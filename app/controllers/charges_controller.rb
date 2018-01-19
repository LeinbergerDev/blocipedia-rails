class ChargesController < ApplicationController
  def downgrade
    current_user.update_attributes(role: "standard")

    current_user.wikis.each do |wiki|
      wiki.update_attributes(private: false)
      wiki.save!
    end

    flash[:notice] = "Your account has been downgraded to a standard account.  We are sorry to see you go."
    redirect_to edit_user_registration_path(current_user)
  end

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: Amount.default
   }
 end

 def create
  # Creates a Stripe Customer object, for associating
  # with the charge
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
  )

  # Where the real magic happens
  charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
  )

  flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again. Your account hwas been upgraded to premium"

  current_user.update_attributes(role: "premium")

  redirect_to wikis_path # or wherever


  # Stripe will send back CardErrors, with friendly messages
  # when something goes wrong.
  # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

end

class Amount
  def self.default
    100
  end
end
