From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 03 Apr 2020 11:21:41 +1030
Subject: [PATCH 2/2] ARM: dts: aspeed: zaius: Add gpio line names
In-Reply-To: <9360D2B2-8242-4BA1-BF06-8916E87EDE67@gmail.com>
References: <20200306170218.79698-1-geissonator@yahoo.com>
 <20200306170218.79698-2-geissonator@yahoo.com>
 <294a52cd-2f60-41e5-a58f-a74151a83b08@www.fastmail.com>
 <9360D2B2-8242-4BA1-BF06-8916E87EDE67@gmail.com>
Message-ID: <48c9bd0e-3b5c-4f76-830f-4b0bd962148b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 31 Mar 2020, at 04:46, Andrew Geissler wrote:
> 
> 
> > On Mar 26, 2020, at 6:20 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > 
> > 
> > 
> > On Sat, 7 Mar 2020, at 03:32, Andrew Geissler wrote:
> >> Name the GPIOs to help userspace work with them. The names describe the
> >> functionality the lines provide, not the net or ball name. This makes it
> >> easier to share userspace code across different systems and makes the
> >> use of the lines more obvious.
> >> 
> >> Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
> > 
> > So we're creating a bit of an ad-hoc ABI here between the DT and userspace.
> > 
> > Where are we documenting it?
> 
> Yeah, so far it?s basically design by precedent. If you want your OpenBMC
> function to work then follow the standards we're setting in other dts?s.
> 
> Is there a good place to document this? I could create a OpenBMC design
> doc but that would not address non-OpenBMC areas.

Don't let perfect be the enemy of good enough :) Lets document it in OpenBMC
and then look at alternatives if we find it's necessary. I don't think we will given
that the contract is between the kernel and OpenBMC userspace.

Andrew
