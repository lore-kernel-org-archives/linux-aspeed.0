From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Apr 2021 14:34:44 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/3]_dt-bindings:_serial:_8250:_add_aspeed,
 sirq-?= =?UTF-8?Q?active-high?=
In-Reply-To: <20210401005702.28271-4-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-4-zev@bewilderbeest.net>
Message-ID: <d66753ee-7db2-41e5-9fe5-762b1ab678bc@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 1 Apr 2021, at 11:27, Zev Weiss wrote:
> This provides a simpler, more direct alternative to the deprecated
> aspeed,sirq-polarity-sense property for indicating the polarity of
> the Aspeed VUART's SIRQ line.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml 
> b/Documentation/devicetree/bindings/serial/8250.yaml
> index 491b9297432d..e79bb6ab9d2c 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -12,8 +12,9 @@ maintainers:
>  allOf:
>    - $ref: /schemas/serial.yaml#
>    - if:
> -      required:
> -        - aspeed,sirq-polarity-sense
> +      anyOf:
> +        - required: [ aspeed,sirq-active-high ]

Do you think we could make use of the approach I put forward here?

https://lore.kernel.org/openbmc/20210319062752.145730-18-andrew at aj.id.au/T/#u

Andrew
