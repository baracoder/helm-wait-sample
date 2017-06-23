# Test chart to reproduce error with --wait


```
Client: &version.Version{SemVer:"v2.5.0", GitCommit:"012cb0ac1a1b2f888144ef5a67b8dab6c2d45be6", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.5.0", GitCommit:"012cb0ac1a1b2f888144ef5a67b8dab6c2d45be6", GitTreeState:"clean"}
```




```
make
helm upgrade --install \
      --set Commit=6637 \
      --set ImagePullPolicy=Always \
      --wait \
      --timeout 300 \
      wait-test ./helm
Release "wait-test" does not exist. Installing it now.
Error: release wait-test failed: timed out waiting for the condition
make: *** [Makefile:2: upgrade] Error 1
```

## events

```
2017-06-23 11:48:42 +0200 CEST   2017-06-23 11:48:42 +0200 CEST   1         test-wait   Deployment             Normal    ScalingReplicaSet   deployment-controller   Scaled up replica set test-wait-2073994126 to 1
2017-06-23 11:48:43 +0200 CEST   2017-06-23 11:48:43 +0200 CEST   1         test-wait-2073994126   ReplicaSet             Normal    SuccessfulCreate   replicaset-controller   Created pod: test-wait-2073994126-gqqb5
2017-06-23 11:48:45 +0200 CEST   2017-06-23 11:48:45 +0200 CEST   1         test-wait-2073994126-gqqb5   Pod                 Normal    Scheduled   default-scheduler   Successfully assigned test-wait-2073994126-gqqb5 to 192.168.0.244
2017-06-23 11:48:46 +0200 CEST   2017-06-23 11:48:46 +0200 CEST   1         test-wait-2073994126-gqqb5   Pod       spec.containers{test-nginx}   Normal    Pulling   kubelet, 192.168.0.244   pulling image "nginx"
2017-06-23 11:49:00 +0200 CEST   2017-06-23 11:49:00 +0200 CEST   1         test-wait-2073994126-gqqb5   Pod       spec.containers{test-nginx}   Normal    Pulled    kubelet, 192.168.0.244   Successfully pulled image "nginx"
2017-06-23 11:49:00 +0200 CEST   2017-06-23 11:49:00 +0200 CEST   1         test-wait-2073994126-gqqb5   Pod       spec.containers{test-nginx}   Normal    Created   kubelet, 192.168.0.244   Created container with id 7f383e629da72a5ac46812de77047d6442e1d35d045a3d4b8f38c99dea3b062b
2017-06-23 11:49:00 +0200 CEST   2017-06-23 11:49:00 +0200 CEST   1         test-wait-2073994126-gqqb5   Pod       spec.containers{test-nginx}   Normal    Started   kubelet, 192.168.0.244   Started container with id 7f383e629da72a5ac46812de77047d6442e1d35d045a3d4b8f38c99dea3b062b
```


## pod is ready

```
test-wait-2073994126-gqqb5                 1/1       Running   0          4m
```


## tilller log

```
[tiller] 2017/06/23 09:48:39 getting history for release wait-test
[storage] 2017/06/23 09:48:39 getting release history for "wait-test"
[tiller] 2017/06/23 09:48:39 preparing install for wait-test
[storage] 2017/06/23 09:48:39 getting release history for "wait-test"
[tiller] 2017/06/23 09:48:39 rendering wait-test chart using values
[tiller] 2017/06/23 09:48:40 performing install for wait-test
[tiller] 2017/06/23 09:48:40 executing 0 pre-install hooks for wait-test
[tiller] 2017/06/23 09:48:40 hooks complete for pre-install wait-test
[storage] 2017/06/23 09:48:40 getting release history for "wait-test"
[kube] 2017/06/23 09:48:40 building resources from manifest
[kube] 2017/06/23 09:48:40 creating 3 resource(s)
[kube] 2017/06/23 09:48:41 beginning wait for 3 resources with timeout of 5m0s
[storage] 2017/06/23 09:50:24 listing all releases with filter
[tiller] 2017/06/23 09:53:41 warning: Release "wait-test" failed: timed out waiting for the condition
[storage] 2017/06/23 09:53:41 creating release "wait-test.v1"
[tiller] 2017/06/23 09:53:42 failed install perform step: release wait-test failed: timed out waiting for the condition
``` 
