From: Sasha Levin <sashal@kernel.org>
Date: Sun, 28 Jul 2024 12:04:57 -0400
Subject: [PATCH AUTOSEL 6.10 16/23] usb: gadget: aspeed_udc: validate endpoint index for ast udc
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Message-ID: <20240728160538.2051879-16-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit ee0d382feb44ec0f445e2ad63786cd7f3f6a8199 ]

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Link: https://lore.kernel.org/r/20240625022306.2568122-1-make24 at iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 821a6ab5da56f..f4781e611aaa2 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum >= AST_UDC_NUM_ENDPOINTS)
+			goto stall;
 		status = udc->ep[epnum].stopped;
 		break;
 	default:
-- 
2.43.0

