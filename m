From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Sep 2018 18:34:01 +0200
Subject: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
In-Reply-To: <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
Message-ID: <20180917163401.GA1082@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> Looks good to me. Thanks! :)
> 
> Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
master/slave combined irq events properly" in i2c/for-next? And apply
this to i2c/for-current?

(and please quote only relevat parts of a message when replying)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180917/7cb37b53/attachment.sig>
