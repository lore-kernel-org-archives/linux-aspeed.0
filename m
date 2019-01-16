From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Jan 2019 12:54:59 +1100
Subject: [PATCH] ARM: configs: aspeed: Enable commonly used network
 functionality
Message-ID: <20190116015459.8524-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: "William A. Kennington III" <wak@google.com>

This addresses some assumptions made by systemd about having multiple
routing table support in the kernel. systemd-networkd will try and
provision mutliple routing tables + policies and will silently break
neighbor advertisement responses due to policy configurations on a
single table.

It also adds support for SLAAC based router settings and faster
duplicate address detection.

Signed-off-by: William A. Kennington III <wak@google.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/configs/aspeed_g4_defconfig | 8 ++++++++
 arch/arm/configs/aspeed_g5_defconfig | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index c694e31c6329..7dc54ff5e8b5 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -50,14 +50,22 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
 # CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
+CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_VLAN_8021Q=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index af85a9a52fa9..5ea9e68a4385 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -52,14 +52,22 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
 # CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET6_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET6_XFRM_MODE_BEET is not set
+CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_VLAN_8021Q=y
-- 
2.20.1

