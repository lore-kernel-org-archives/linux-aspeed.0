From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Jul 2022 16:13:21 +0200
Subject: [PATCH 2/6] ARM: defconfig: remove irda remnants
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
Message-ID: <20220721141325.2413920-3-arnd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

A couple of ARM defconfig files (and one for sh) still refer to the
IRDA options that were removed in linux-4.14. Remove the entries
as well now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/assabet_defconfig        |  3 ---
 arch/arm/configs/badge4_defconfig         |  5 -----
 arch/arm/configs/clps711x_defconfig       |  2 --
 arch/arm/configs/colibri_pxa270_defconfig |  7 -------
 arch/arm/configs/corgi_defconfig          |  5 -----
 arch/arm/configs/eseries_pxa_defconfig    |  7 -------
 arch/arm/configs/footbridge_defconfig     |  9 ---------
 arch/arm/configs/h3600_defconfig          |  4 ----
 arch/arm/configs/jornada720_defconfig     |  4 ----
 arch/arm/configs/lart_defconfig           |  7 -------
 arch/arm/configs/magician_defconfig       |  9 ---------
 arch/arm/configs/pxa_defconfig            | 10 ----------
 arch/arm/configs/simpad_defconfig         |  6 ------
 arch/arm/configs/spitz_defconfig          |  5 -----
 arch/arm/configs/trizeps4_defconfig       |  8 --------
 arch/sh/configs/ecovec24_defconfig        |  2 --
 16 files changed, 93 deletions(-)

diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index db80b8193e66..ae7354550a63 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -16,9 +16,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_SA1100_FIR=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index cdf3e3f99942..3a46dce304c4 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -17,11 +17,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRLAN=y
-CONFIG_IRCOMM=y
-CONFIG_IRDA_ULTRA=y
-CONFIG_SA1100_FIR=y
 CONFIG_BT=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIVHCI=m
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index b56d82d4eacd..8d86599e4de3 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -22,8 +22,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRTTY_SIR=y
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 14bc9a1e185b..c3d15b8dfc39 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -35,13 +35,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_VLAN_8021Q=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRTTY_SIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 8bc19fc9ca6c..126ddc2a0d09 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -56,11 +56,6 @@ CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index 5c58aa407897..a8db4f45a68d 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -25,13 +25,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_PXA_FICP=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 10905e53067c..2c4e15261d42 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -29,15 +29,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_ATM=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_WINBOND_FIR=m
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 6066aea1d9c2..1bf143e69de3 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -15,10 +15,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
 # CONFIG_WIRELESS is not set
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 0521f427efce..6c99a48e2812 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -17,10 +17,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_SA1100_FIR=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index f4966d033a65..a414fe01ef52 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -20,13 +20,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_SA1100_FIR=m
 CONFIG_MTD=y
 CONFIG_MTD_DEBUG=y
 CONFIG_MTD_DEBUG_VERBOSE=1
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index aaddc07c16d9..75a15efa6e06 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -35,15 +35,6 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_IRTTY_SIR=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index ed92947244a1..d3fc216de6fa 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -115,16 +115,6 @@ CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_IEEE802154=y
 CONFIG_DNS_RESOLVER=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_IRTTY_SIR=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 042f9626e0ee..0e1871fc8311 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -23,12 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRTTY_SIR=m
-CONFIG_SA1100_FIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 4630aac47a8e..7757d26396c1 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -53,11 +53,6 @@ CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index db0444aada48..01a0901120e8 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -38,14 +38,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_VLAN_8021Q=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRTTY_SIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index d90d29d44469..e699e2e04128 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -29,8 +29,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_SH_SIR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-- 
2.29.2

