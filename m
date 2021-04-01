From: Joel Stanley <joel@jms.id.au>
Date: Thu, 1 Apr 2021 03:53:21 +0000
Subject: [PATCH v2 1/3] dt-bindings: serial: 8250: deprecate aspeed,
 sirq-polarity-sense
In-Reply-To: <20210401005702.28271-2-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
 <20210401005702.28271-2-zev@bewilderbeest.net>
Message-ID: <CACPK8Xeqrvtb4Qku545QcbLeqgbHOZHkpgMp3G332c0aMdMCvA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 1 Apr 2021 at 00:57, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This property ties SIRQ polarity to SCU register bits that don't
> necessarily have any direct relationship to it; the only use of it
> was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  Documentation/devicetree/bindings/serial/8250.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index f54cae9ff7b2..491b9297432d 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -188,6 +188,7 @@ properties:
>        offset and bit number to identify how the SIRQ polarity should be
>        configured. One possible data source is the LPC/eSPI mode bit. Only
>        applicable to aspeed,ast2500-vuart.
> +    deprecated: true
>
>  required:
>    - reg
> --
> 2.31.1
>
