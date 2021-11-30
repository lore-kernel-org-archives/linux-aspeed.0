From: Wolfram Sang <wsa@kernel.org>
Date: Tue, 30 Nov 2021 11:02:59 +0100
Subject: [PATCH v5 1/3] i2c: aspeed: Add slave_enable() to toggle slave
 mode
In-Reply-To: <b8ee3be7-c0f6-d1fd-1ba1-13066b329ee3@os.amperecomputing.com>
References: <20210714033833.11640-1-quan@os.amperecomputing.com>
 <20210714033833.11640-2-quan@os.amperecomputing.com>
 <YRTQP9sX0hkTJMTx@shikoro> <YaUoeFZn6zLNoGed@kunai>
 <b8ee3be7-c0f6-d1fd-1ba1-13066b329ee3@os.amperecomputing.com>
Message-ID: <YaX2021qO696FG1D@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

> Thanks Wolfram to help bring this up,

Sure thing! It would be sad to see this work bitrot.

> This driver was tested with Aspeed ast2500 and we have tried many way to
> avoid using slave_enable() to toggle slave mode but there is no progress.

I see. I also can't help you there. I have neither experience with nor
access to this HW.

> Our expectation is still to have this driver upstream'ed and I'm thinking
> about testing this driver on other HW and re-post the driver.

That sounds like a good plan.

> I have to admit that you are all right with the above comments. The fact is
> we still not be able to find any way to solve this differently. We don't own
> this HW and dont know what happen on this particular issue. The SCL clock
> stretching on this HW does not work as expected and the slave_enable() is
> the only solution for now. I hope if someone could help with the issue as
> well.

From this distance, it looks like HW access and a logic analyzer might
be helpful in understanding the behaviour. Pity that you don't own the
HW.

Good luck nonetheless!

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211130/a98bc6a6/attachment.sig>
