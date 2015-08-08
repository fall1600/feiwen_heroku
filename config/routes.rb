Rails.application.routes.draw do
  
  #root 'pages#posts'
  root "posts#index"
  get "pages/home"
  get "pages/login"

  get "home", to: "pages#home"
  get "login", to: "pages#login"

  resources :tags,
    except: :destroy do
    member do
      get :posts,
        except: :destroy
      # if you want to build feature about hot tags 
      # get :hot 
    end
  end

  resources :forums,
    except: :destroy do
      member do
        put :fake_delete
      end

      member do
        get :join_this
      end

      resources :posts,
        except: :destroy,
        controller: :forum_posts do
        member do
          put :fake_delete
        end
      end
  end

  resources :users do
    resources :posts,
      controller: :user_posts,
      except: :destroy
  end

  # put :fake_delete, controller: :posts
  resources :posts, 
    except: :destroy do
      resources :tags,
        controller: :post_tags,
        except: :destroy
      resources :replies,
        controller: :post_replies,
        except: :destroy
      member do
        put :fake_delete
      end
  end

  resource :session,
    only: [:create, :destroy]

  #post :about, controller: :pages
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
