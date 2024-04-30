From: Kelly Hung <ppighouse@gmail.com>
Date: Tue, 30 Apr 2024 04:59:08 -0000
Subject: [PATCH v7 0/2] modify Signed-off-by field
Message-ID: <20240430045853.3894633-1-Kelly_Hung@asus.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For the warning message: 
From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung
<Kelly_Hung@asus.com>'

I replaced Kelly_Hung at asus.com with my private Gmail account.

Due to a security issue with ASUS's mail server, I am unable to use 
ASUS's mail system to send patches out from my build server.
So I executed git send-email using my private gmail accoutt.

Kelly Hung (2):
  dt-bindings: arm: aspeed: add ASUS X4TF board
  ARM: dts: aspeed: x4tf: Add dts for asus x4tf project

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
 3 files changed, 583 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

-- 
2.25.1

