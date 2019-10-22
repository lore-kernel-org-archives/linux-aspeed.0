From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 22 Oct 2019 06:56:56 +0200
Subject: [PATCH i2c-next 1/2] dt-bindings: i2c: aspeed: add hardware
 timeout support
In-Reply-To: <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
References: <20191021202414.17484-1-jae.hyun.yoo@linux.intel.com>
 <20191021202414.17484-2-jae.hyun.yoo@linux.intel.com>
 <0a629f7b-b829-c332-27d8-dc825205ff72@axentia.se>
 <7abf933b-cb18-10af-9c1b-163ec65ffae5@linux.intel.com>
Message-ID: <20191022045655.GA975@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> Changes I submitted in this patch set is for a different purpose which
> is very Aspeed H/W specific, and actually it's a more serious timeout
> setting indeed. If this H/W is used in multi-master environment, it
> could meet a H/W hang that freezes itself in slave mode and it can't
> escape from the state. To resolve the specific case, this H/W provides
> self-recovery feature which monitors abnormal state of SDA, SCL and its
> H/W state machine using the timeout setting to determine the escape
> condition.

Thanks for the summary. I just wonder on what the timeout value depends.
Do we really need to put in DT or can we derive it e.g. from the
compatible value in the driver?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191022/ea051ffb/attachment.sig>
