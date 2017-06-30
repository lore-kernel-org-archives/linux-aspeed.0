From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Jun 2017 10:54:58 +0930
Subject: [PATCH 0/4] pinctrl: Add USB support for Aspeed SoCs
In-Reply-To: <CACRpkdZpJuaedE=04we_bcLB7qzOdvJAz4QmTfnuZA=5PrMf0g@mail.gmail.com>
References: <20170627021214.23323-1-andrew@aj.id.au>
 <CACRpkdZpJuaedE=04we_bcLB7qzOdvJAz4QmTfnuZA=5PrMf0g@mail.gmail.com>
Message-ID: <1498785898.5203.12.camel@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2017-06-29 at 14:53 +0200, Linus Walleij wrote:
> > On Tue, Jun 27, 2017 at 4:12 AM, Andrew Jeffery <andrew@aj.id.au> wrote:
> 
> > With recent interest in the USB virtual hub in the Aspeed SoCs[1] it is a good
> > time to add pinmux support for the USB ports and controllers. The earlier
> > series of pinmux patches for the Aspeed SoCs focussed on supporting pins which
> > were capable of GPIO. This is not the case for the USB pins, hence they have
> > been unsupported until now.
> > 
> > Rob: I know you've mentioned previously you desired complete bindings to be
> > provided up front, so apologies for continuing to add functionality. This looks
> > to be the last of it.
> 
> Waiting for DT review and addressing of Beji's comment for these.

Okay, Rob's now ack'ed the bindings and Ben's comments should amount to
a commit message change. I've reworked it.

> 
> Please resend after the merge window.

Will do.

Thanks,

Andrew

> 
> Yours,
> Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20170630/d6f767ae/attachment.sig>
