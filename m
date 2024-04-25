From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 25 Apr 2024 14:06:23 +0800
Subject: [PATCH v1 0/2] Update yosemite4 dts for nct7363 and hardware
Message-ID: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series includes two commits that update the dts for yosemite4.
The first commit revises the mux and hardware configuration in the DTS.
The second commit adds support for the nct7363 device.

Delphine CC Chiu (2):
  Revise mux and hardware in yosemite4 dts
  Add nct7363 in yosemite4 dts

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 222 ++++++++++++++++--
 1 file changed, 202 insertions(+), 20 deletions(-)

-- 
2.25.1

