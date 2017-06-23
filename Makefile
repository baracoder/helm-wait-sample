upgrade:
	helm upgrade --install \
      --set Commit="'$(shell echo $$RANDOM)'" \
      --set ImagePullPolicy=Always \
      --wait \
      --timeout 300 \
      wait-test ./helm
