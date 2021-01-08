From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 8 Jan 2021 16:12:37 +0800
Subject: [PATCH 0/1] Fix vhub engine stop dma register setting.
Message-ID: <20210108081238.10199-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch fixes vhub engine stop dma should have different register
setting.

Ryan Chen (1):
  usb: gadget: aspeed: fix stop dma register setting.

 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

