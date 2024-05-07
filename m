From: Kelly Hung <KellyHung@asus.com>
Date: Tue, 07 May 2024 09:22:53 -0000
Subject: [PATCH v8 0/2] Change email sender
Message-ID: <20240507092109.6018-1-KellyHung@asus.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Requesting assistance from ASUS IT, I obtained a new smtp account.
So send the patch again using new smtp account.

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

===================================================================================================================================
This email and any attachments to it contain confidential information and are intended solely for the use of the individual to whom it is addressed. If you are not the intended recipient or receive it accidentally, please immediately notify the sender by e-mail and delete the message and any attachments from your computer system, and destroy all hard copies. Please be advised that any unauthorized disclosure, copying, distribution or any action taken or omitted in reliance on this, is illegal and prohibited. Any views or opinions expressed are solely those of the author and do not represent those of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resale price. All customers are free to set their own price as they wish.
===================================================================================================================================
