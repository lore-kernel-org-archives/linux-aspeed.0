From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 05 Jun 2024 10:17:13 +0930
Subject: [PATCH 1/3] dt-bindings: pinctrl: aspeed: Use block syntax for
 function and groups
In-Reply-To: <20240604192755.GA1065421-robh@kernel.org>
References: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
	 <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-1-a6fe2281a1b8@codeconstruct.com.au>
	 <20240604192755.GA1065421-robh@kernel.org>
Message-ID: <0908995dfd2181e687181bd1b075c4cb27624e94.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-06-04 at 14:27 -0500, Rob Herring wrote:
> On Fri, May 31, 2024 at 12:32:47PM +0930, Andrew Jeffery wrote:
> > The expansion makes the documents a lot longer, but it's easier to
> > review changes to functions and groups when we're not having to deal
> > with line wrapping.
> 
> Do you really expect to be updating this frequently? I would leave it 
> as-is, but whatever you decide.

I don't expect to be updating it frequently. However it's happened
occasionally in the past and the diff chaos irks me. So I prefer we
explode it.

> 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks.

Andrew
