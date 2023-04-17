if [ $( docker ps -a | grep oauth2proxy | wc -l ) -gt 0 ]; then
  docker stop oauth2proxy | xargs docker rm ; 
fi 
docker run -d --name oauth2proxy \
   -p 4180:4180 --restart=always --mount type=bind,source=/home/ec2-user/oauth2-proxy/oauth2-proxy.cfg,destination=/etc/oauth2-proxy.cfg \
   bitnami/oauth2-proxy:7.2.1 \
   --config=/etc/oauth2-proxy.cfg \
   --provider=azure \
   --client-id="your client id" \
   --client-secret="your secret" \
   --azure-tenant="your tenant id" \
   --skip-provider-button=true \
   --pass-access-token=true \
   --pass-authorization-header=true \
   --scope="user:email" \
   --session-store-type=cookie \
   --cookie-samesite=lax \
   --cookie-secure=true \
   --set-xauthrequest=true \
   --set-authorization-header=false \
   --skip-auth-preflight=true \
   --pass-user-headers=true \
   --pass-basic-auth=true \
   --set-xauthrequest=true \
   --oidc-issuer-url=https://sts.windows.net/"your tenant id"/

