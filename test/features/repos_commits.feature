Feature: Repository Commits

Scenario Outline: User can get number of commits
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo>
  Then I make api call
  Then I should receive response with 200 status
  And I should receive array of commits
  And each commit should be a Hash
  And each commit should have all required fields:
    |sha |commit |url |html_url |comments_url |author |committer |parents |
  Examples:
    |repo    | path |
    |faker    | commits |
    |ffaker   | commits |
    |empty_repo   | commits |


Scenario Outline: User can get commits with author parameter
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo> with <author> "author"
  Then I make api call
  Then I should receive response with 200 status
  And each commit has <author> as author email
  Examples:
    |repo   | author             | path |
    |ffaker  | hi@ricostacruz.com | commits |
    |faker  | ben@bencurtis.com | commits |


Scenario Outline: User can get commits with few parameters
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo> with <author> "author"
    And with <date> "since"
  Then I make api call
  Then I should receive response with 200 status
  And all commits should be pushed after <date> date
  And each commit has <author> as author email
  Examples:
    | repo   | author            | path    | date |
    | faker  | ben@bencurtis.com | commits | 2014-12-07 |


Scenario Outline: User can get commits until defined date
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo> with <date> "until"
  Then I make api call
  Then I should receive response with 200 status
  And all commits should be pushed before <date> date
  Examples:
    | repo   | path    | date |
    | faker  | commits | 2014-12-07 |


Scenario Outline: User can get commits for defined file
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo> with <file> "path"
  Then I make api call
  Then I should receive response with 200 status
  And all commits should be done for <file> file
  Examples:
    | repo   | path    | file      |
    | faker  | commits | README.md |


Scenario Outline: User can get particular commit by sha
  Given github repo for user oleksii-ti
  Given endpoint for <path> request for <repo> with <sha> "sha"
  Then I make api call
  Then I should receive response with 200 status
  And first commit sha should be eqaul <sha>
  Examples:
    | repo    | path    | sha                                      |
    | ffaker  | commits | 673b86f7d88738f26864409fb032acbe07aff61e |
