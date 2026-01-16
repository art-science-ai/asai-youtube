- INBOX
  collapsed:: true
	- #+BEGIN_QUERY
	  {:title "🔨 TODO Inbox"
	   :query [:find (pull ?b [*])
	           :in $ % ; % is used to pull in the rules below.
	           :where
	           [?b :block/marker ?marker]
	           [(contains? #{"TODO"} ?marker)]
	       ;; Exclude pagename
	           [?p :block/name "projects"]
	           (not (check-ref ?p ?b)) ; this calls the rules below.
	           ]
	   :rules [; whenever two rules have the same name an or is applied. I'm not exactly sure how to explain it!
	           [(check-ref ?p ?b) ; definition of the rule, name and parameters.
	            [?b :block/refs ?p] ; rule content to be executed
	            ]
	           [(check-ref ?p ?b)
	            [?b :block/parent ?t]
	            (check-ref ?p ?t) ; calling the rule again within this rule will make it recursive.
	            ]]
	   :breadcrumb-show? true
	   :group-by-page? false
	   :collapsed? false}
	  #+END_QUERY
- Projects
	- All
	  collapsed:: true
		- query-table:: false
		  collapsed:: true
		  #+BEGIN_QUERY
		  {:title "🔨 All projects"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "projects"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? true
		  :breadcrumb-show? false
		  :group-by-page? false
		  }
		  #+END_QUERY
	- Work
	  collapsed:: true
		- query-table:: false
		  #+BEGIN_QUERY
		  {:title "🔨 work-misc"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-work-misc"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  }
		  #+END_QUERY
		- query-table:: false
		  #+BEGIN_QUERY
		  {:title "🔨 projects - work - 1pd"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-1pd"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title "🔨 projects - work - sg"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-sg"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title "🔨 projects - work - capacity"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-org-capacity"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title "🔨 projects - work - mpc"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-mpc"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- #+BEGIN_QUERY
		  {:title "🔨 projects - work - someday"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-work-someday"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
	- EC
		- Side project
		- #+BEGIN_QUERY
		  {:title "🔨 projects - ec - side proj"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-ec-side-projects"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- CD
		- #+BEGIN_QUERY
		  {:title "🔨 projects - ec - career dev"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-ec-career-development"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- Writing - someday
		- #+BEGIN_QUERY
		  {:title "🔨 projects - ec - writing"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-ec-writing"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- Entrepreneurship - someday
		- #+BEGIN_QUERY
		  {:title "🔨 projects - ec - entrepeneur"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-ec-entrepreneurship"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- Someday - someday
		- #+BEGIN_QUERY
		  {:title "🔨 projects - work - someday"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-work-someday"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
	- Personal
		- ALL
			- collapsed:: true
			  #+BEGIN_QUERY
			  {:title "🔨 projects-personal-all"
			    :query [:find (pull ?b [*])
			            :where
			            [?p :block/name "[[projects]]-personal"]
			            [?par :block/refs ?p]
			            (or [?b :block/parent ?par]
			       [?b :block/refs ?p])
			            [?b :block/marker ?marker]
			            [(contains? #{"TODO"} ?marker)]
			    ]
			  :collapsed? true
			  :breadcrumbs? true
			  :group-by-page? false
			  }
			  #+END_QUERY
		- collapsed:: true
		  #+BEGIN_QUERY
		  {:title "🔨 projects-personal-misc"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-misc"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? true
		  :breadcrumbs? true
		  }
		  #+END_QUERY
		- Misc
		- #+BEGIN_QUERY
		  {:title "🔨 projects-personal-misc"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-misc"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- Home
		- #+BEGIN_QUERY
		  {:title "🔨 projects-personal-home"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-home"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- RukmaAndNikhil
		- #+BEGIN_QUERY
		  {:title "🔨 projects-RukmaAndNikhil"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-RukmaAndNikhil"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- Finance
		- #+BEGIN_QUERY
		  {:title "🔨 projects-personal-finance"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-finance"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- IT
		- #+BEGIN_QUERY
		  {:title "🔨 projects-personal-it"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-it"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- Read-later
		- #+BEGIN_QUERY
		  {:title "🔨 projects-read-later"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-read-later"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
			- Shopping
		- #+BEGIN_QUERY
		  {:title "🔨 projects-personal-shopping"
		    :query [:find (pull ?b [*])
		            :where
		            [?p :block/name "[[projects]]-personal-shopping"]
		            [?par :block/refs ?p]
		            (or [?b :block/parent ?par]
		       [?b :block/refs ?p])
		            [?b :block/marker ?marker]
		            [(contains? #{"TODO"} ?marker)]
		    ]
		  :collapsed? false
		  :breadcrumbs? true
		  }
		  #+END_QUERY
- gtd system - tags
	- Todo system - main
		- Main system
			- todo - default
			- doing - ?
		- Alt
			- Later
			- Now
		- Other
			- Waiting
			- Canceled
	- Task priorities
		- A = high priority p0
		- B = ?
		- C = someday
		- NONE = normal
		- Can I also account for large vs. small chunks of work?
	- Dates, scheduled, deadlines
		- Deadline date
			- actual deadline when it needs to be completed (external deadline)
		- Scheduled date
			- when I am planning to work on the task (think of it as weekly - schedule tasks for the monday of the week I want to work on them)
		- Vanilla date
			- ?
- GTD flow
	- Capture todo -> inbox
	- Processing
		- Add project tag - required
	- Review - dashboards
- GTD dashboards
	- Inbox
		- all tasks not yet processed
	- Project level - all
		- Sort by priority and deadline
	-
- Testing
	- WAITING Task
- References
	- GTD thread: https://discord.com/channels/725182569297215569/1055474965782204496/1067803293637672961
	-