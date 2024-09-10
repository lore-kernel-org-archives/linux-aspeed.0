From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 10 Sep 2024 13:47:49 +0800
Subject: [PATCH v1 0/2] Yosemite4: Add devices on I2C buses to server boards
Message-ID: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changelog:
  - v1
    - Revise to use adm1281 on Medusa board.
    - Add gpio pca9506 for CPLD I/O expander.

Ricky CX Wu (2):
  ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
  ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 276 +++++++++++++++++-
 1 file changed, 268 insertions(+), 8 deletions(-)

-- 
2.25.1

