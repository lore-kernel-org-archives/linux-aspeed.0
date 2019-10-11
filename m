From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2019 12:02:03 -0500
Subject: [PATCH v2 2/3] dt-bindings: net: ftgmac100: Describe clock
 properties
In-Reply-To: <20191010020756.4198-3-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
 <20191010020756.4198-3-andrew@aj.id.au>
Message-ID: <20191011170203.GA16724@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 12:37:55 +1030, Andrew Jeffery wrote:
> Critically, the AST2600 requires ungating the RMII RCLK if e.g. NCSI is
> in use.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/net/ftgmac100.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
