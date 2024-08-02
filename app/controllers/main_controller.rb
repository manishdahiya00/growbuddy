class MainController < ApplicationController
  before_action :set_app_offer, only: [:app_offer, :refer]
  before_action :set_refer_code, except: [:google_login]

  def index
    @refer_code = session[:refer_code]
    @app_banners = AppBanner.active
    @app_offers = AppOffer.active
  end

  def app_offer
    if request.post?
      if params["g-recaptcha-response"].blank?
        flash.now[:alert] = "Please complete the captcha"
        render :app_offer
        return
      end

      @existing_affiliate = Affiliate.find_by(campaign_name: @app_offer.identifier, paytm_number: params[:mobile_number], upi_id: params[:upi_id])
      if params[:commit] == "Complete Offer"
        if @existing_affiliate.nil?
          @click_id = SecureRandom.uuid
          @affiliate = Affiliate.create(
            paytm_number: params[:mobile_number],
            upi_id: params[:upi_id],
            campaign_name: @app_offer.identifier,
            refer_code: session[:refer_code],
            click_id: @click_id,
          )
          redirect_to @app_offer.action_url, allow_other_host: true
        end
        flash.now[:alert] = "You can complete offer one time with same upi Id or phone number"
      else
        if @existing_affiliate.nil?
          @click_id = SecureRandom.uuid
          @affiliate = Affiliate.create(
            paytm_number: params[:mobile_number],
            upi_id: params[:upi_id],
            campaign_name: @app_offer.identifier,
            refer_code: session[:refer_code],
            click_id: @click_id,
          )
        end
        redirect_to refer_path(app_offer: @app_offer.identifier, refer_code: session[:refer_code])
      end
    else
      render :app_offer
    end
  end

  def refer
    if params[:refer_code] != session[:refer_code]
      redirect_to root_path
      return
    end

    if request.post?
      redirect_to refer_path(app_offer: params[:app_offer], refer_code: session[:refer_code])
    else
      @refer_code = params[:refer_code]
    end
  end

  def referral
    @refer_code = params[:refer_code]
    @affiliate = Affiliate.find_by(refer_code: @refer_code)
    unless @affiliate
      redirect_to root_path
      return
    end

    @app_offer = AppOffer.find_by(identifier: params[:app_offer])
    unless @app_offer
      redirect_to root_path
      return
    end

    if request.get?
      unless @refer_code.present?
        redirect_to root_path
        return
      end
    elsif request.post?
      if params["g-recaptcha-response"].blank?
        flash.now[:alert] = "Please complete the captcha"
        render :referral
        return
      end

      @click_id = SecureRandom.uuid
      @existing_referrer = Referrer.find_by(affiliate_id: @affiliate.id, upi_id: params[:upi_id], app_offer_id: @app_offer.id)
      if @existing_referrer.nil?
        @referrer = Referrer.new(
          app_offer_id: @app_offer.id,
          affiliate_id: @affiliate.id,
          click_id: @click_id,
          paytm_number: params[:mobile_number],
          upi_id: params[:upi_id],
          source_ip: request.ip,
        )
        if @referrer.save
          @affiliate.increment!(:referrers_count)
          redirect_to @app_offer.action_url, allow_other_host: true
        end
      else
        flash.now[:alert] = "You can complete offer one time with same upi Id or phone number"
      end
    end
  end

  def verification
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash.now[:alert] = "Something went wrong"
      redirect_to root_path
      return
    end

    if @user.mobile_number.nil?
      if request.post?
        @user.update(mobile_number: params[:mobile_number])
        redirect_to profile_path
      end
    else
      redirect_to profile_path
    end
  end

  def profile
    @user = User.find_by(id: session[:user_id])
    if @user
      @affiliate = Affiliate.find_by(paytm_number: @user.mobile_number)
      @affiliate_offers = Affiliate.where(paytm_number: @user.mobile_number)
      @offers = AppOffer.where(identifier: @affiliate_offers.pluck(:campaign_name))
      @total_referrals = @affiliate ? Referrer.where(affiliate_id: @affiliate.id).count : 0
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to profile_path
  end

  def postback
    if params[:app_offer].present? && params[:event].present? && params[:paytm_number].present? && params[:clk_id].present? && params[:upi_id].present? && !params[:app_offer].nil? && !params[:event].nil? && !params[:paytm_number].nil? && !params[:upi_id].nil? && !params[:clk_id].nil?
      puts "###############################"
      puts "++++++++++#{params}++++++++++++"
      puts "###############################"

      @affiliate = Affiliate.find_by(paytm_number: params[:paytm_number], upi_id: params[:upi_id], click_id: params[:clk_id])
      if @affiliate.present?
        puts "###############################"
        puts "++++++++++#{@affiliate}++++++++++++"
        puts "###############################"

        @app_offer = AppOffer.find_by identifier: params[:app_offer]
        if @app_offer.present?
          puts "###############################"
          puts "++++++++++#{@app_offer}++++++++++++"
          puts "###############################"

          @event = OfferEvent.find_by(app_offer_id: @app_offer.id, event_title: params[:event])
          if @event.present?
            puts "###############################"
            puts "++++++++++#{@event}++++++++++++"
            puts "###############################"
            if @event.event_order == 1
              if @event.pay_type == "Auto"
                puts "###############################"
                puts "++++++++++FOUND AUTO #{@event.event_order}++++++++++++"
                puts "###############################"

                render json: { status: 200, message: "AUTO" }
              else
                puts "###############################"
                puts "++++++++++FOUND MANUAL++++++++++++"
                puts "###############################"
                render json: { status: 200, message: "Manual" }
              end
            else
              @initial_event = OfferEvent.find_by(app_offer_id: @app_offer.id, event_order: @event.event_order - 1)
              if @initial_event.present?
                @initial_postback = Postback.find_by(event: @initial_event.event_title)
                if @initial_postback.present?
                  puts "###############################"
                  puts "++++++++++#{@initial_postback}++++++++++++"
                  puts "###############################"
                  if @event.pay_type == "Auto"
                    puts "###############################"
                    puts "++++++++++FOUND AUTO #{@event.event_order}++++++++++++"
                    puts "###############################"

                    render json: { status: 200, message: "AUTO" }
                  else
                    puts "###############################"
                    puts "++++++++++FOUND MANUAL++++++++++++"
                    puts "###############################"
                    render json: { status: 200, message: "Manual" }
                  end
                else
                  puts "###############################"
                  puts "++++++++++NO INITAIAL POSTBACK++++++++++++"
                  puts "###############################"
                  render json: { status: 500, message: "Error" }
                end
              else
                puts "###############################"
                puts "++++++++++NO INITAIAL EVENT IN POSTBACK++++++++++++"
                puts "###############################"
                render json: { status: 500, message: "Error" }
              end
            end
          else
            puts "###############################"
            puts "++++++++++NO EVENT++++++++++++"
            puts "###############################"
            render json: { status: 500, message: "Error" }
          end
        else
          puts "###############################"
          puts "++++++++++NO APP OFFER++++++++++++"
          puts "###############################"
          render json: { status: 500, message: "Error" }
        end
      else
        puts "###############################"
        puts "++++++++++NO AFFILIATE++++++++++++"
        puts "###############################"
        render json: { status: 500, message: "Error" }
      end
    else
      puts "###############################"
      puts "++++++++++ NO PARAMS ++++++++++++"
      puts "###############################"
      render json: { status: 500, message: "Error" }
    end
  end

  def google_login
    user = authenticate_with_google

    if user
      session[:user_id] = user.id
      redirect_to user.mobile_number.nil? ? "/verification/#{user.id}" : profile_path
    else
      redirect_to root_path, alert: "Authentication failed"
    end
  end

  private

  def set_app_offer
    @app_offer = AppOffer.find_by(identifier: params[:app_offer])
    redirect_to root_path unless @app_offer
  end

  def set_refer_code
    session[:refer_code] ||= SecureRandom.hex(4)
  end

  def authenticate_with_google
    return nil unless id_token = flash[:google_sign_in]["id_token"]

    identity = GoogleSignIn::Identity.new(id_token)
    user = User.find_or_initialize_by(social_token: identity.user_id)

    if user.new_record?
      user.assign_attributes(
        social_email: identity.email_address,
        social_name: identity.name,
        social_img_url: identity.avatar_url,
        oauth_response: identity.inspect,
        social_type: "Google",
        source_ip: request.ip,
      )
      user.save
    end

    session[:user_id] = user.id
    user
  rescue => e
    Rails.logger.error "Google authentication error: #{e.message}"
    nil
  end
end
