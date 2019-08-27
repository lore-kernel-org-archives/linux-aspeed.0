From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Aug 2019 07:36:12 -0500
Subject: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
In-Reply-To: <20190826021620.11915-1-andrew@aj.id.au>
References: <20190826021620.11915-1-andrew@aj.id.au>
Message-ID: <CAL_JsqJsLt5FjKayO9ksksrpXDFs3cbAngcQ21xhZYz3JLG=7g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Aug 25, 2019 at 9:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The example node in the binding uses the AST2500 compatible string for
> the SD controller with a 64kiB ranges property, but the SD controller is
> allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
> the example to correctly reflect the hardware in the AST2500, however it
> should be noted that the MMIO region is reduced to 64kiB in the AST2600
> where a second SD controller block has been introduced into the address
> space.
>
> Also add the IBM copyright header that I left out of the initial patch.
>
> Suggested-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Hi Ulf, this is the follow-up fix as discussed here:
>
> http://patchwork.ozlabs.org/patch/1143090/
>
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
