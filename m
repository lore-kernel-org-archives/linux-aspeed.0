From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 29 Aug 2017 18:16:29 +0930
Subject: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
In-Reply-To: <20170829084508.edybxf6zctgx4xwy@ninjato>
References: <20170815072102.23067-1-andrew@aj.id.au>
 <20170828160702.x45hagij4kkm5zzc@ninjato>
 <1503989809.5933.5.camel@aj.id.au>
 <20170829084508.edybxf6zctgx4xwy@ninjato>
Message-ID: <1503996389.5933.9.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2017-08-29 at 10:45 +0200, Wolfram Sang wrote:
> > I'd argue that Brendan's patch should go in for-current as well,
> > because it fixes a divisor rounding error for the ast2500 (bus is
> > clocked faster than requested).
> 
> Hmmm, pity, the description said "potential" issue so I decided for
> for-next. However, I wouldn't like to reshuffle my branches much so
> short before the merge window. So, would it be OK with you that you send
> both patches to stable after rc1?
> 

Will do.

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170829/2faa8555/attachment.sig>
