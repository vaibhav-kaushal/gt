#!/usr/bin/env zsh

# Git tool
if [[ "$1" == "help" ]]; then
	source ${0:A:h}/help.zsh "gt"
	return
fi

case $1 in
# Commit and Push
cpb)
	if ! source ${0:A:h}/gt_repo_check.zsh; then
		return 5
	fi

	case $2 in
	help)
		pr default "Usage:"
		pr default "${0} $1 commit_message"
		pr default "commit_message is required and it cannot be 'help'"
		;;
	*)
		if [[ -z "$2" ]]; then
			pr red "No commit message supplied"
			pr red "Exiting!"
			return 3
		fi

		pr --no-newline default "About to commit with the email address: "
		pr red $(git config --global user.email)

		read -k1 "choice?Continue? [y/n] "

		if [[ $choice = "y" || $choice = "Y" ]]; then
			echo ""
			pr blue "continuing..."
		else
			echo ""
			pr blue "Aborted!"
			return 6
		fi

		# Allow free flowing text for commit message
		shift

		git add .
		pr blue '======)> Added!'
		git commit -m "$(gitbranch) $*"
		pr blue '======)> Commited'
		git push origin $(gitbranch)
		pr blue '======)> Pushed'
		;;
	esac
	;;
cp)
	# if ! gt_repo_check
	if ! source ${0:A:h}/gt_repo_check.zsh; then
		return 4
	fi

	case $2 in
	help)
		pr default "Usage:"
		pr default "${0} $1 commit_message"
		pr default "commit_message is required and it cannot be 'help'"
		;;
	*)
		if [[ -z "$2" ]]; then
			pr red "No commit message supplied"
			pr red "Exiting!"
			return 3
		fi

		pr --no-newline default "About to commit with the email address: "
		pr red $(git config --global user.email)

		read -k1 "choice?Continue? [y/n] "

		if [[ $choice = "y" || $choice = "Y" ]]; then
			echo ""
			pr blue "continuing..."
		else
			echo ""
			pr blue "Aborted!"
			return 6
		fi

		# Allow free flowing text for commit message
		shift

		git add .
		pr blue '======)> Added!'
		git commit -m "$*"
		pr blue '======)> Commited'
		git push origin $(gitbranch)
		pr blue '======)> Pushed'
		;;
	esac
	;;
# Switch Keys
sk)
	pr default "Switching GitHub SSH keys (and email)"
	pr magenta "Current Email: $(gt s email)"

	case $2 in
	w | work)
		sed -i -e 's/id_rsa_personal/id_rsa_work/' ~/.ssh/config
		git config --global user.email vaibhav@plackal.in
		pr green "After swithing: $(gt s email)"
		;;
	p | personal)
		sed -i -e 's/id_rsa_work/id_rsa_personal/' ~/.ssh/config
		git config --global user.email vaibhavkaushal123@gmail.com
		pr green "After swithing: $(gt s email)"
		;;
	help | *)
		pr default "Usage:"
		pr default "${0} $1 key_type"
		pr default "key_type is required and it cannot be 'help'. It can be one of:"
		pr default "  w (work): Sets the ssh key for work"
		pr default "  p (personal): Sets the personal key"
		;;
	esac
	;;
# Show certain information
s)
	case $2 in
	e | email)
		pr default "git config --global user.email: $(git config --global user.email)"
		;;
	n | name)
		pr default "git config --global user.name: $(git config --global user.name)"
		;;
	help | *)
		pr default "Usage:"
		pr default "${0} $1 what_to_show"
		pr default "what_to_show is required and can be:"
		pr default "  e (email): Shows the user email"
		pr default "  n (name): Shows the user name"
		;;
	esac
	;;
# Opens github webpage in browser
ogh)
	if ! source ${0:A:h}/gt_repo_check.zsh; then
		return 5
	fi

	# local url=$(git remote -v | grep "^origin.*(fetch)$" | cut -f 2 | cut -d' ' -f 1 | sed -e 's/:/\//' | sed -e 's/git@/https:\/\//' | sed -e 's/\.git//')
	# The last filter in above expression one matches all occurrenced of ".git" while
	# the one below will match only the last occurence of ".git"
	local url=$(git remote -v | grep "^origin.*(fetch)$" | cut -f 2 | cut -d' ' -f 1 | sed -e 's/:/\//' | sed -e 's/git@/https:\/\//' | sed 's/\(.*\)\.git/\1/')
	local orig_url=$url

	case $2 in
	issues | i | issue)
		url="$url/issues"
		case $3 in
		new | n)
			url="$url/new"
			;;
		*)
			url="$url/$3"
			;;
		esac
		;;
	pr | pull-requests)
		url="$url/pulls"
		case $3 in
		new | n)
			url="$orig_url/compare"
			;;
		*) ;;
			# Do nothing in this case but let the flow continue
		esac
		;;
	proj | projects)
		url="$url/projects"
		;;
	wiki | w)
		url="$url/wiki"
		;;
	s | settings)
		url="$url/settings"
		;;
	help)
		pr default "'${funcstack[1]} ogh' opens the GitHub (only GitHub) link of a repo in browser (Firefox)"
		pr default "Usage: "
		pr default "${funcstack[1]} ogh option [param]"
		pr default "Where option can be:"
		pr default "  i (issue|issues)  : Opens the issue page for this repo. Can take following param:"
		pr green "      n|new): Opens the 'New Issue' page"
		pr default "  pr (pull-requests): Opens the pull requests page for this repo. Can take following params:"
		pr green "      n|new): Opens the 'New Pull Request' page"
		pr default "  proj (projects)   : Opens the Projects page for this repo. Does not take any param."
		pr default "  w (wiki)          : Opens the Wiki page for this repo. Does not take any param."
		pr default "  s (settings)      : Opens the Settings page for this repo. Does not take any param."
		return 1
		;;
	*) ;;
	esac

	echo "About to open $url with Firefox"
	ostype=$(detectos)
	case $ostype in
	macos)
		open -a /Applications/Firefox.app $url
		;;
	linux)
		firefox $url
		;;
	*)
		echo "Detected OS Type to be ${ostype}. Do not know what to do"
		echo "Quitting"
		;;
	esac
	;;
# Shows help about this tool
help | *)
	source ${0:A:h}/help.zsh "gt"
	;;
esac
