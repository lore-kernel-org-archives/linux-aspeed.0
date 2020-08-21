From: Wolfram Sang <wsa@kernel.org>
Date: Fri, 21 Aug 2020 07:54:29 +0200
Subject: [PATCH 3/5] i2c: aspeed: Mask IRQ status to relevant bits
In-Reply-To: <20200820161152.22751-4-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-4-eajames@linux.ibm.com>
Message-ID: <20200821055429.GA995@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> +	irq_received &= 0xf000ffff;

Can we have a define for this? Like ASPEED_I2CD_INTR_MASTER_IRQS or
something?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200821/fdf3bddb/attachment.sig>
