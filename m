From: Ninad Palsule <ninad@linux.ibm.com>
Date: Wed, 31 Jul 2024 16:47:28 -0500
Subject: [PATCH v1 0/1] ARM: dts: aspeed: system1: IBM System1 BMC update
Message-ID: <20240731214737.986010-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This patch only applies to openbmc/linux. The max31785 pmbus driver
changes are not available in the upstream yet. I will try to send those
changes upstream.

Ninad Palsule (1):
  ARM: dts: aspeed: system1: IBM System1 BMC update

 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

-- 
2.43.0

