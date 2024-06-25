From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 25 Jun 2024 02:23:16 -0000
Subject: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Message-ID: <20240625022306.2568122-1-make24@iscas.ac.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v4:
- used a consistent email address to send patches, sorry for my negligence.
Changes in v3:
- added the changelog as suggested.
Changes in v2:
- used the correct macro-defined constants as suggested;
- explained the method for finding and testing vulnerabilities.
---
 drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 3916c8e2ba01..d972ef4644bc 100644
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
2.25.1

