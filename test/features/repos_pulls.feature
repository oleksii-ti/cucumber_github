Feature: Repository Pull Requests

Scenario Outline: User can get pull requests for particular repo
  Given github repo for user <username>
  Given endpoint for <path> request for <repo>
  Then I make api call
  Then I should receive responce with 200 status
  And I should receive array of pull requests
  And each commit should be a Hash
  And each commit should have all required fields:
    |url |id |html_url |diff_url |patch_url |issue_url |number |state |locked |title |user |body |created_at |updated_at |closed_at |merged_at |merge_commit_sha |assignee |assignees |requested_reviewers |milestone |commits_url |review_comments_url |review_comment_url |comments_url |statuses_url |head |base |_links
  Examples:
    | repo    | path  | username   |
    | faker   | pulls | stympy     |
    | ffaker  | pulls | ffaker     |



