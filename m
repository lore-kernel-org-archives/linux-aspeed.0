From: Joel Stanley <joel@jms.id.au>
Date: Mon, 20 Jul 2020 05:17:02 +0000
Subject: [PATCH for v5.9] dt-bindings: aspeed-lpc: Replace HTTP links with
 HTTPS ones
In-Reply-To: <20200719173447.60603-1-grandmaster@al2klimov.de>
References: <20200719173447.60603-1-grandmaster@al2klimov.de>
Message-ID: <CACPK8Xc_iwvRtUVjY8G8rS8UbZf6-Q6FTGaNweJXk06A=Y459Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2020 at 17:34, Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:

> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 86446074e206..4f3cf91b3b7f 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -35,9 +35,9 @@ Additionally the state of the LPC controller influences the pinmux
>  configuration, therefore the host portion of the controller is exposed as a
>  syscon as a means to arbitrate access.
>
> -[0] http://www.intel.com/design/chipsets/industry/25128901.pdf
> +[0] https://www.intel.com/design/chipsets/industry/25128901.pdf

This URL redirects to a landing page. We should update it to this:

https://www.intel.com/content/dam/www/program/design/us/en/documents/low-pin-count-interface-specification.pdf'

or this:

https://www.intel.com/content/www/us/en/design/technologies-and-topics/low-pin-count-interface-specification.html


>  [1] https://www.renesas.com/en-sg/doc/products/mpumcu/001/rej09b0078_h8s2168.pdf?key=7c88837454702128622bee53acbda8f4
> -[2] http://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf
> +[2] https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmi-second-gen-interface-spec-v2-rev1-1.pdf

For this change:

Acked-by: Joel Stanley <joel@jms.id.au>

>  [3] https://en.wikipedia.org/wiki/Super_I/O
>
>  Required properties
> --
> 2.27.0
>
