From: Colin King <colin.king@canonical.com>
Date: Tue, 22 Jan 2019 14:26:54 +0000
Subject: [PATCH] usb: gadget: fix various indentation issues
Message-ID: <20190122142654.28380-1-colin.king@canonical.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Colin Ian King <colin.king@canonical.com>

There are a bunch of various indentation issues, clean these up.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/gadget/function/f_uac1.c     |  8 ++---
 drivers/usb/gadget/legacy/inode.c        | 40 ++++++++++++------------
 drivers/usb/gadget/udc/aspeed-vhub/hub.c |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_cmd.c     |  4 +--
 drivers/usb/gadget/udc/net2280.c         |  2 +-
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 2746a926a8d9..fe42ffccb020 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -459,10 +459,10 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	} else if (intf == uac1->as_in_intf) {
 		uac1->as_in_alt = alt;
 
-			if (alt)
-				ret = u_audio_start_playback(&uac1->g_audio);
-			else
-				u_audio_stop_playback(&uac1->g_audio);
+		if (alt)
+			ret = u_audio_start_playback(&uac1->g_audio);
+		else
+			u_audio_stop_playback(&uac1->g_audio);
 	} else {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return -EINVAL;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 37ca0e669bd8..354fbaf3e720 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1218,27 +1218,27 @@ ep0_poll (struct file *fd, poll_table *wait)
 	if (dev->state <= STATE_DEV_OPENED)
 		return DEFAULT_POLLMASK;
 
-       poll_wait(fd, &dev->wait, wait);
-
-       spin_lock_irq (&dev->lock);
-
-       /* report fd mode change before acting on it */
-       if (dev->setup_abort) {
-               dev->setup_abort = 0;
-               mask = EPOLLHUP;
-               goto out;
-       }
-
-       if (dev->state == STATE_DEV_SETUP) {
-               if (dev->setup_in || dev->setup_can_stall)
-                       mask = EPOLLOUT;
-       } else {
-               if (dev->ev_next != 0)
-                       mask = EPOLLIN;
-       }
+	poll_wait(fd, &dev->wait, wait);
+
+	spin_lock_irq(&dev->lock);
+
+	/* report fd mode change before acting on it */
+	if (dev->setup_abort) {
+		dev->setup_abort = 0;
+		mask = EPOLLHUP;
+		goto out;
+	}
+
+	if (dev->state == STATE_DEV_SETUP) {
+		if (dev->setup_in || dev->setup_can_stall)
+			mask = EPOLLOUT;
+	} else {
+		if (dev->ev_next != 0)
+			mask = EPOLLIN;
+	}
 out:
-       spin_unlock_irq(&dev->lock);
-       return mask;
+	spin_unlock_irq(&dev->lock);
+	return mask;
 }
 
 static long dev_ioctl (struct file *fd, unsigned code, unsigned long value)
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 35ba0e55a2e9..7c040f56100e 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -295,7 +295,7 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
 		dsize = AST_VHUB_HUB_DESC_SIZE;
 		memcpy(ep->buf, &ast_vhub_hub_desc, dsize);
 		BUILD_BUG_ON(dsize > sizeof(ast_vhub_hub_desc));
-	BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
+		BUILD_BUG_ON(AST_VHUB_HUB_DESC_SIZE >= AST_VHUB_EP0_MAX_PACKET);
 		break;
 	default:
 		return std_req_stall;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_cmd.c b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
index 6305bf2c8b59..44c2a5eef785 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_cmd.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_cmd.c
@@ -311,8 +311,8 @@ int bdc_ep_clear_stall(struct bdc *bdc, int epnum)
 		/* if the endpoint it not stallled */
 		if (!(ep->flags & BDC_EP_STALL)) {
 			ret = bdc_ep_set_stall(bdc, epnum);
-				if (ret)
-					return ret;
+			if (ret)
+				return ret;
 		}
 	}
 	/* Preserve the seq number for ep0 only */
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index e7dae5379e04..17b6c8aba73c 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2279,7 +2279,7 @@ static void usb_reinit_338x(struct net2280 *dev)
 	 * - It is safe to set for all connection speeds; all chip revisions.
 	 * - R-M-W to leave other bits undisturbed.
 	 * - Reference PLX TT-7372
-	*/
+	 */
 	val = readl(&dev->ll_chicken_reg->ll_tsn_chicken_bit);
 	val |= BIT(RECOVERY_IDLE_TO_RECOVER_FMW);
 	writel(val, &dev->ll_chicken_reg->ll_tsn_chicken_bit);
-- 
2.19.1

