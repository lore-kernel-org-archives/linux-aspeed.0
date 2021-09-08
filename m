From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 8 Sep 2021 05:06:35 +0000
Subject: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Add UART routing
 compatible string
In-Reply-To: <YTezn1TDatYs2FMd@robh.at.kernel.org>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210902021817.17506-2-chiawei_wang@aspeedtech.com>
 <YTezn1TDatYs2FMd@robh.at.kernel.org>
Message-ID: <HK0PR06MB3779D0B44F9F927A48F017EA91D49@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, September 8, 2021 2:47 AM
> 
> On Thu, Sep 02, 2021 at 10:18:14AM +0800, Chia-Wei Wang wrote:
> > Add the compatible string and the device tree description for the
> > Aspeed AST25xx/AST26xx UART routing control.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> 
> Either convert aspeed-lpc.txt to DT schema or make this a separate schema
> doc.

I will send a v3 patch with a separate schema included. Thanks.

Chiawei

> 
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > index 936aa108eab4..45d44f812e5e 100644
> > --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> > @@ -155,3 +155,25 @@ lpc_reset: reset-controller at 98 {
> >          reg = <0x98 0x4>;
> >          #reset-cells = <1>;
> >  };
> > +
> > +UART routing control
> > +--------------------
> > +
> > +The UART routing control manages the RX muxes among the UART
> > +controllers and the I/O pins. This is typicall used for the
> > +Serial-Over-Lan (SOL) service.
> > +
> > +Required properties:
> > +
> > + - compatible:		One of:
> > +			"aspeed,ast2500-uart-routing";
> > +			"aspeed,ast2600-uart-routing";
> > +
> > + - reg:			offset and length of the IP in the LPC memory region
> > +
> > +Example:
> > +
> > +uart_routing: uart-routing at 98 {
> > +	compatible = "aspeed,ast2600-uart-routing";
> > +	reg = <0x98 0x8>;
> > +};
> > --
> > 2.17.1
> >
> >
