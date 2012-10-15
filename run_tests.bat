::Disable the printing of the commands
@ECHO OFF

::Set the winDOw buffer height to 10000
mode con:lines=10000

::Set the winDOw title to the current task
TITLE Running Ruby Test Cases

::Move to the test directory
CD test

::Alert the user that the tests are beginning
ECHO -----------------------------------------------------------
ECHO Beginning test...
ECHO -----------------------------------------------------------

::Loop over each folder in the /test/ directory
for /d %%D in (%dir%*) do (

	::Move to the new sub-directory
	CD %%D

	::Do not execute tests from the /unit/ directory
	if NOT %%D == unit (
		::Alert the user that we have started a new type of testing
		ECHO --- %%D tests ---

		for /r . %%g in (*.rb) do (
			::Move back to the /test/ directory
			CD..

			::Move back the the /Holograms-Inc/ directory
			CD..

			::Execute the Ruby test command
			ruby -Itest test\%%D\%%~nxg

			::Move back the the /test/ directory
			CD test

			::Move back to the sub-directory
			CD %%D
		)
	)

	::Move back to the /test/ directory
	CD..
)

::Alert the user that the tests have finished
ECHO -----------------------------------------------------------
ECHO Testing complete...
ECHO -----------------------------------------------------------

::Pause at the end so the user can see the results
PAUSE



::Loop over each file in the current sub-directory
::Because these tests need to be executed from the /Holograms-Inc/ directory, we grab the
::file name and move back to the test directory, execute the command, and the move
::back into the directory of the file