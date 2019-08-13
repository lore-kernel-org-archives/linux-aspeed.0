From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Aug 2019 16:14:22 -0600
Subject: [PATCH v5 1/2] dt-bindings: mmc: Document Aspeed SD controller
In-Reply-To: <20190807003629.2974-2-andrew@aj.id.au>
References: <20190807003629.2974-1-andrew@aj.id.au>
 <20190807003629.2974-2-andrew@aj.id.au>
Message-ID: <CAL_JsqKXda7f43=ZdtTsyrdhdqn+H4L=7zQXtB_EEfHdi=rHLg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 6, 2019 at 6:38 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED SD/SDIO/MMC controller exposes two slots implementing the
> SDIO Host Specification v2.00, with 1 or 4 bit data buses, or an 8 bit
> data bus if only a single slot is enabled.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>
> ---
> v4:
> * Make use of mmc-controller.yaml
> * Document sdhci,auto-cmd12
>
> v2:
> * Fix compatible enums
> * Add AST2600 compatibles
> * Describe #address-cells / #size-cells
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
