from email.mime import application
from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack, AuthMiddleware

from echo import routing as echo_routing

application = ProtocolTypeRouter({
    'websocket': AuthMiddlewareStack(
        URLRouter(
            routes=echo_routing.websocket_urlpatterns
        )
    )
})
 