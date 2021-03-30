From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Mar 2021 17:05:43 -0500
Subject: [PATCH v1 3/3] bindings: ipmi: Add binding for Aspeed SSIF BMC
 driver
In-Reply-To: <20210329121759.5644-4-quan@os.amperecomputing.com>
References: <20210329121759.5644-1-quan@os.amperecomputing.com>
 <20210329121759.5644-4-quan@os.amperecomputing.com>
Message-ID: <20210330220543.GA795792@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 29, 2021 at 07:17:59PM +0700, Quan Nguyen wrote:
> Add device tree binding document for the Aspeed SSIF BMC driver.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>  .../bindings/ipmi/aspeed-ssif-bmc.txt          | 18 ++++++++++++++++++

Bindings should now be in DT schema format.

>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
> new file mode 100644
> index 000000000000..1616f0188db9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
> @@ -0,0 +1,18 @@
> +# Aspeed SSIF (SMBus system interface) IPMI BMC interface
> +
> +The Aspeed AST2500 are commonly used as BMCs (Baseboard Management Controllers)
> +and the SSIF slave interface can be used to perform in-band IPMI communication
> +with their host.
> +
> +Required properties:
> +
> +- compatible : should be
> +       "aspeed,ast2500-ssif-bmc"
> +- reg: I2C address the registers
> +
> +Example:
> +
> +       ssif-bmc at 10 {
> +               compatible = "aspeed,ast2500-ssif-bmc";
> +               reg = <0x10>;
> +       };
> -- 
> 2.28.0
> 
