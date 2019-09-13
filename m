From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 13 Sep 2019 11:35:08 -0500
Subject: [PATCH 0/2] i2c: Aspeed: Add AST2600 compatible string
Message-ID: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update the Aspeed I2C driver with the AST2600 compatible string. The default
driver behavior works fine with the AST2600. A new compatible string is needed
to avoid the AST2400 and AST2500 behavior.

Eddie James (2):
  i2c: Aspeed: Add AST2600 compatible
  dt-bindings: i2c: Aspeed: Add AST2600 compatible

 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 ++-
 drivers/i2c/busses/i2c-aspeed.c                      | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
1.8.3.1

