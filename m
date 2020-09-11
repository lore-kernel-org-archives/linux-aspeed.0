From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 01:16:44 +0000
Subject: [PATCH 3/4] dt-bindings: fsi: Aspeed master: Add bus-frequency
 property
In-Reply-To: <20200910151840.25333-4-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
 <20200910151840.25333-4-eajames@linux.ibm.com>
Message-ID: <CACPK8XdTsDtDAvaNrz7e3hGXdcx_1=A0vPuTiXF7GhnWQrQi3g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 15:18, Eddie James <eajames@linux.ibm.com> wrote:
>
> Document the bus-frequency property.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I think this is good terminology, and it's consistent with similar
protocols such as i2c.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> index a513e65ec0c9..d84bd19526ca 100644
> --- a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> @@ -17,6 +17,7 @@ Optional properties:
>
>   - fsi-routing-gpios: GPIO for setting the FSI mux (internal or cabled)
>   - fsi-mux-gpios: GPIO for detecting the desired FSI mux state
> + - bus-frequency: the frequency of the FSI bus
>
>
>  Examples:
> --
> 2.26.2
>
