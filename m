From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Thu, 21 Oct 2021 06:59:31 +0000
Subject: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
In-Reply-To: <CACPK8Xfc+vuqbnw8xuXGtGwKRLnb7EwYZYE0Z-+g3fUM28yc6w@mail.gmail.com>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
 <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
 <CACPK8Xfj=wJBCX5ogyf02pLJsLrooVWBJ92GJ1E+jxQW5wiFEw@mail.gmail.com>
 <HK0PR06MB3779F430883E60E7E47849BE91BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <CACPK8Xc2wzx1dthFYC_0vm4mj9e1BbL+Kwkqc_PvPFj4sqjOJg@mail.gmail.com>
 <CACPK8Xfc+vuqbnw8xuXGtGwKRLnb7EwYZYE0Z-+g3fUM28yc6w@mail.gmail.com>
Message-ID: <HK0PR06MB3779FDCD93A4BB2D6A56F1F491BF9@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Joel Stanley <joel@jms.id.au>
> Sent: Thursday, October 21, 2021 2:54 PM
> 
> On Thu, 21 Oct 2021 at 06:48, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Thu, 21 Oct 2021 at 06:37, ChiaWei Wang
> <chiawei_wang@aspeedtech.com> wrote:
> > > However, like Rob mentioned, when doing 'make dtbs_check', there is a
> warning:
> > >
> > >
> /builds/robherring/linux-dt-review/arch/arm/boot/dts/aspeed-ast2500-evb.dt.y
> aml:
> > > lpc at 1e789000: 'ibt at 140', 'kcs at 114', 'kcs at 24', 'kcs at 28', 'kcs at 2c',
> 'lhc at a0', 'reg-io-width' do not match any of the regexes:
> > > '^lpc-ctrl@[0-9a-f]+$', '^lpc-snoop@[0-9a-f]+$',
> '^reset-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > > From schema:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings
> > > /mfd/aspeed-lpc.yaml
> > >
> > > As part of this series has been applied, maybe we can fix this later?
> 
> FWIW, this fixes the warnings for me;
> 
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -56,6 +56,9 @@ properties:
> 
>    ranges: true
> 
> +  reg-io-width:
> +    const: 4
> +
>  patternProperties:
>    "^lpc-ctrl@[0-9a-f]+$":
>      type: object
> @@ -144,6 +147,9 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32-array
>          description: The LPC I/O ports to snoop
> 
> +      clocks:
> +        maxItems: 1
> +
>      required:
>        - compatible
>        - interrupts
> 
> make ARCH=arm CROSS_COMPILE="arm-linux-gnueabi-" dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 
> If you are able to test this and send a patch that would be appreciated.

Sure. I will test it and send a standalone patch to fix the warning.
Thanks!

Regards,
Chiawei
