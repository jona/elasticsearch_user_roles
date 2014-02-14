#Elasticsearch roles

**Add roles to your elasticsearch model**

##Initialize

Add this to your user model

```ruby
associates :user_role
```

##Helper method

User this method to authenticate roles

```ruby
def authenticate_role(role)
  redirect_to '/' unless current_user.has_role? role
end
```

##Extras

I've included a controller that you can use to access users that will update roles. You can include my <a href="https://github.com/jona/manage_users">user management</a> repo into your project that will take what the controller dishes out.

##Dependencies

1. Uses <a href="https://github.com/karmi/retire"> Tire</a>.