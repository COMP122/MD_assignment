#  This is a simple makfile for a MD submission


SUBMISSION=submission.md
RESPONSE_TAG=<!-- response
        # The standardize tag to "grep" for within the student's submission to locate just the responses to review


all: validate_submission validate_name validate_account
	@echo -----------------------
	@echo The following are your responses
	@egrep '(^#|$(RESPONSE_TAG))' $(SUBMISSION) |\
	  sed "s/^ *\(.* *\)$(RESPONSE_TAG).*/\1 /" 

validate_submission:
	@[[ -f $(SUBMISSION) ]]  || echo \"$(SUBMISSION)\" is missing

validate_name:
	@grep "## Name:"  $(SUBMISSION)

validate_account:
	@grep "## GitHub Account:" $(SUBMISSION)



