From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 29 Aug 2017 10:45:09 +0200
Subject: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
In-Reply-To: <1503989809.5933.5.camel@aj.id.au>
References: <20170815072102.23067-1-andrew@aj.id.au>
 <20170828160702.x45hagij4kkm5zzc@ninjato>
 <1503989809.5933.5.camel@aj.id.au>
Message-ID: <20170829084508.edybxf6zctgx4xwy@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> I'd argue that Brendan's patch should go in for-current as well,
> because it fixes a divisor rounding error for the ast2500 (bus is
> clocked faster than requested).

Hmmm, pity, the description said "potential" issue so I decided for
for-next. However, I wouldn't like to reshuffle my branches much so
short before the merge window. So, would it be OK with you that you send
both patches to stable after rc1?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170829/2ec49d5c/attachment.sig>
