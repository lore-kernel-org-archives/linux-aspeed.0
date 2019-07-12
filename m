From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 12 Jul 2019 07:03:57 -0600
Subject: [PATCH v2 1/2] dt-bindings: mmc: Document Aspeed SD controller
In-Reply-To: <20190712033214.24713-2-andrew@aj.id.au>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-2-andrew@aj.id.au>
Message-ID: <CAL_Jsq++J+K2goHiNrHJGnL6vrLjmKhM+vpYO=sTnmv6fm2sog@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 11, 2019 at 9:32 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/eMMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> In v2:
>
> * Rename to aspeed,sdhci.yaml
> * Rename sd-controller compatible
> * Add `maxItems: 1` for reg properties
> * Move sdhci subnode description to patternProperties
> * Drop sdhci compatible requirement
> * #address-cells and #size-cells are required
> * Prevent additional properties
> * Implement explicit ranges in example
> * Remove slot property
>
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
