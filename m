From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 17 Jun 2024 16:51:00 +0930
Subject: [PATCH 1/3] dt-bindings: pinctrl: aspeed: Use block syntax for
 function and groups
In-Reply-To: <0908995dfd2181e687181bd1b075c4cb27624e94.camel@codeconstruct.com.au>
References: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
	 <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-1-a6fe2281a1b8@codeconstruct.com.au>
	 <20240604192755.GA1065421-robh@kernel.org>
	 <0908995dfd2181e687181bd1b075c4cb27624e94.camel@codeconstruct.com.au>
Message-ID: <5bf8e1dddd2b958a102e7b1b9f9c080a34f9deff.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

On Wed, 2024-06-05 at 10:17 +0930, Andrew Jeffery wrote:
> On Tue, 2024-06-04 at 14:27 -0500, Rob Herring wrote:
> > On Fri, May 31, 2024 at 12:32:47PM +0930, Andrew Jeffery wrote:
> > > The expansion makes the documents a lot longer, but it's easier to
> > > review changes to functions and groups when we're not having to deal
> > > with line wrapping.
> > 
> > Do you really expect to be updating this frequently? I would leave it 
> > as-is, but whatever you decide.
> 
> I don't expect to be updating it frequently. However it's happened
> occasionally in the past and the diff chaos irks me. So I prefer we
> explode it.
> 
> > 
> > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > ---
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Thanks.
> 

Are you okay to apply these (I see they're not yet in linux-pinctrl.git
for-next)? Turns out there's another concern lurking in the AST2600
RMII pin groups[1], and it would be nice if we could rework the patch
for that on top of this series.

[1]: https://lore.kernel.org/linux-gpio/20240613080725.2531580-1-potin.lai.pt at gmail.com/

Andrew
