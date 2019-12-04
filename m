From: Mark Brown <broonie@kernel.org>
Date: Wed, 4 Dec 2019 13:46:31 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191129172537.31410-4-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
Message-ID: <20191204134631.GT1998@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 29, 2019 at 06:25:34PM +0100, Marco Felsch wrote:

> +  Optional regulator device-specific properties:
> +  - dlg,vsel-sense-gpios : A GPIO reference to a local general purpose input,
> +    the datasheet calls it GPI. The regulator sense the input signal and select
> +    the active or suspend voltage settings. If the signal is active the
> +    active-settings are applied else the suspend-settings are applied.
> +    Attention: Sharing the same GPI for other purposes or across multiple
> +    regulators is possible but the polarity setting must equal.

I'm really confused by this.  As far as I understand it it seems
to be doing pinmuxing on the chip using the GPIO bindings which
is itself a bit odd and I don't see anything here that configures
whatever sets the state of the pins.  Don't we need another GPIO
to set the vsel-sense inputs on the PMIC?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191204/b850f940/attachment-0001.sig>
