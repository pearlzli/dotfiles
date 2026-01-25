```
# Start from a blank slate
unmapAll

# Remap escape key
mapkey <c-g> <c-[>

# Page navigation
map <c-x><c-v> LinkHints.activateMode
map <c-x><c-f> LinkHints.activateModeToOpenInNewTab
map <c-x><c-r> reload

# Scrolling
map <c-b> scrollLeft
map <c-f> scrollRight
map <c-a> scrollToLeft
map <c-e> scrollToRight
map <c-n> scrollDown
map <c-p> scrollUp
map <a-n> scrollPageDown
map <a-p> scrollPageUp
map <c-v> scrollFullPageDown
map <a-v> scrollFullPageUp
map <a-<> scrollToTop
map <a->> scrollToBottom

# Find mode
map / enterFindMode
map <c-s> performFind
map <c-r> performBackwardsFind

# Tabs
map <c-o>c createTab
map <c-o>x removeTab
map <c-o>p previousTab
map <c-o>n nextTab
map <c-o><c-p> moveTabLeft
map <c-o><c-n> moveTabRight
map <c-o>m togglePinTab

# Miscellaneous
map <c-h>k showHelp
```
