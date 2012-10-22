::Disable the printing of the commands
@ECHO OFF

::Set the window title
TITLE Database fix

::Alert the user that we are starting the task
ECHO Preparing the test database

::Begin the tasks
::rake db:drop
rake db:create 
rake db:schema:load
rake db:test:load
rake db:test:clone
rake db:test:prepare

::Pause at the end so the user can see the results
PAUSE