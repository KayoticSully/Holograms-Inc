::Disable the printing of the commands
@ECHO OFF

::Set the window buffer height to 10000
mode con:lines=10000

::Set the window title to the current task
TITLE Running functional tests

::Alert the user that we are starting the task
ECHO Beginning functional tests from /test/functional

::Begin the tasks
ruby -Itest test/functional/groups_controller_test.rb
ruby -Itest test/functional/help_items_controller_test.rb
ruby -Itest test/functional/home_controller_test.rb
::ruby -Itest test/functional/keywords_controller_test.rb
ruby -Itest test/functional/order_items_controller_test.rb
ruby -Itest test/functional/orders_controller_test.rb
ruby -Itest test/functional/products_controller_test.rb
ruby -Itest test/functional/sessions_controller_test.rb
ruby -Itest test/functional/user_types_controller_test.rb
ruby -Itest test/functional/users_controller_test.rb

::Pause at the end so the user can see the results
PAUSE