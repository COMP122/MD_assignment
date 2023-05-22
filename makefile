#  This is a simple makfile for a MD submission


SUBMISSION=submission.md
RESPONSE_TAG=<!-- response
        # The standardize tag to "grep" for within the student's submission to locate just the responses to review


all: validate_submission validate_name validate_account
	@echo ---------------------------------
	@echo The following are your responses:
	@echo 
	@egrep '(^#|$(RESPONSE_TAG))' $(SUBMISSION) |\
	  sed "s/^ *\(.* *\)$(RESPONSE_TAG).*/\1 /" 

validate_submission:
	@test -f $(SUBMISSION)  || echo \"$(SUBMISSION)\" is missing || return 1

validate_name:
	@test -n $$(awk '/## Name:/ {print $$3}'  $(SUBMISSION) )

validate_account:
	@test -n $$(awk '/## GitHub Account:/ {print $$4}' $(SUBMISSION) )



