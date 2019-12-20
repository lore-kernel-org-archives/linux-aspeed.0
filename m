From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Dec 2019 18:01:01 -0600
Subject: [PATCH v2 1/3] dt-bindings: ipmi: aspeed: Introduce a v2 binding
 for KCS
In-Reply-To: <8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew@aj.id.au>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
 <8aec8994bbe1186d257b0a712e13cf914c5ebe35.1576462051.git-series.andrew@aj.id.au>
Message-ID: <20191220000101.GA16104@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2019 12:57:40 +1030, Andrew Jeffery wrote:
> The v2 binding utilises reg and renames some of the v1 properties.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2: Rename slave-reg to aspeed,lpc-io-reg
> 
> Rob: After our discussion about the name of 'slave-reg' on v1 I've thought
> about it some more and have landed on aspeed,lpc-io-reg. In v1 I argued that
> the name should be generic and you suggested that if so it should go in a
> generic binding document - I've thought about this some more and concluded that
> it was hard to pin down exactly where it should be documented if it were
> generic (the generic ASPEED LPC binding is one place, but that would suggest
> that the property is still ASPEED-specific; maybe some discussion with
> Nuvoton might give some insight).
> 
> Regardless, it turns out that the address specification is really
> ASPEED-specific in this case: The KCS host interface in the LPC IO space
> consists of a data and status register, but the slave controller infers the
> address of the second from the address of the first and thus only the address
> of the first can be programmed on the BMC-side. ASPEED supply documentation
> that maps the LPC-side register layout for given LPC IO base addresses. I think
> this is esoteric enough to warrant the aspeed prefix.
> 
>  Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt | 20 +++++---
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
