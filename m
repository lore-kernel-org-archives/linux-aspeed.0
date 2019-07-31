From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 31 Jul 2019 12:42:48 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/3]_dt-bindings:_serial:_8250:_Add_documentatio?=
 =?UTF-8?Q?n_for_espi-enabled.?=
In-Reply-To: <20190731013404.243755-2-osk@google.com>
References: <20190731013404.243755-1-osk@google.com>
 <20190731013404.243755-2-osk@google.com>
Message-ID: <b4670171-e161-4d7a-91dc-a1e5a95f7dbc@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

On Wed, 31 Jul 2019, at 11:04, Oskar Senft wrote:
> Add documentation for 8250_aspeed_vuart's espi-enabled property that
> enables to auto-configure the VUART's SIRQ polarity.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt 
> b/Documentation/devicetree/bindings/serial/8250.txt
> index 20d351f268ef..4b8b9e502179 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -56,6 +56,11 @@ Optional properties:
>  - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for 
> RTS/CTS/DTR/DSR/RI/DCD
>    line respectively. It will use specified GPIO instead of the 
> peripheral
>    function pin for the UART feature. If unsure, don't specify this 
> property.
> +- espi-enabled: Only applicable to aspeed,ast2500-vuart.

Bit of a bikeshed, but:

Given it's ASPEED-specific I expect you should use a vendor prefix for the
property, e.g. aspeed,espi-enabled.

However, as I understand it you want to determine what polarity the SIRQ
should be regardless of which of eSPI or LPC are enabled, so I don't think
the property name should be an explicit statement about eSPI. Maybe
"aspeed,sirq-polarity-sense"? Anyway, see the point below:

Please use ./scripts/get_maintainer.pl to determine where to send the
series - Copying just the linux-aspeed@ list for upstream patches is not
enough. For instance the series needs to at least go via the linux-serial@
list given that's the affected subsystem, and you're adding to the
devicetree binding so you need to send to the devicetree@ list as well
(you'll need an ack from Rob Herring). The get_maintainer.pl script will
give you all the information you need.

Cheers,

Andrew
