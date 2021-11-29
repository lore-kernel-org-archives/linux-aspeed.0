From: Wolfram Sang <wsa@kernel.org>
Date: Mon, 29 Nov 2021 20:22:32 +0100
Subject: [PATCH v5 1/3] i2c: aspeed: Add slave_enable() to toggle slave
 mode
In-Reply-To: <YRTQP9sX0hkTJMTx@shikoro>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
 <20210714033833.11640-2-quan@os.amperecomputing.com>
 <YRTQP9sX0hkTJMTx@shikoro>
Message-ID: <YaUoeFZn6zLNoGed@kunai>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I still wonder if we can't get the SSIF BMC driver upstream...

> @all: Plus, I neither like the API (because it doesn't look generic to
> me but mostly handling one issue needed here) nor do I fully understand
> the use case. Normally, when a read is requested and the backend needs
> time to deliver the data, the hardware should stretch the SCL clock
> until some data register is finally written to. If it doesn't do it for
> whatever reason, this is a quirky hardware in my book and needs handling
> in the driver only. So, what is special with this HW? Can't we solve it
> differently?

... for that, it would be great if somebody could answer my questions
here :)

Happy hacking,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211129/6638444e/attachment.sig>
