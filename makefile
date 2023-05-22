# Makefile to process a Markdownn (MD) submission
#   Simply validates the minimal requirements before grading can occur

# The TAG represents the HTML comment that identifies a line that contains a response
TAG=<!-- response
ANSWER=\([\t ]*.*\)

SUBMISSION=submission.md
NAME=$(shell awk '/\#\# Name:/ {print $$3}' $(SUBMISSION) )
ACCOUNT=$(shell awk '/\#\# GitHub Account:/ {print $$4}' $(SUBMISSION) )
COMMITS=$(shell git log --oneline | wc -l)
MIN_COMMITS=4


all: md_submission

md_submission: validate_submission validate_name validate_account number_commits
	@echo ---------------------------------
	@echo The following are your responses:
	@echo 
	@sed -n -e '/^#/p' -e '/```/,/```/p' -e "/$(TAG)/s/^$(ANSWER)[\t ]*$(TAG).*/\1/p" $(SUBMISSION)

validate_submission:
	@test -f $(SUBMISSION)  || { echo \"$(SUBMISSION)\" is missing && false ; }

validate_name:
	@test -n "$(NAME)"

validate_account:
	@test -n "$(ACCOUNT)"

number_commits:
	@(( $(COMMITS) >= $(MIN_COMMITS) )) || { echo "Not enough commits" && false ; }

