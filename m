From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Date: Tue, 25 Jul 2023 09:16:05 -0500
Subject: [PATCH 0/1] ARM: dts: aspeed: Rainier: Remove TPM device
Message-ID: <20230725141606.1641080-1-lakshmiy@us.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

TPM is not supported in Rainier, remove the TPM device.

Lakshmi Yadlapati (1):
  ARM: dts: aspeed: Rainier: Remove TPM device

 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.37.2

