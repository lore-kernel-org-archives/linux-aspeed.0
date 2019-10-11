From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2019 12:01:39 -0500
Subject: [PATCH v2 1/3] dt-bindings: net: ftgmac100: Document AST2600
 compatible
In-Reply-To: <20191010020756.4198-2-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
 <20191010020756.4198-2-andrew@aj.id.au>
Message-ID: <20191011170139.GA16006@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 12:37:54 +1030, Andrew Jeffery wrote:
> The AST2600 contains an FTGMAC100-compatible MAC, although the MDIO
> controller previously embedded in the MAC has been moved out to a
> dedicated MDIO block.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/net/ftgmac100.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
