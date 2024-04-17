From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Wed, 17 Apr 2024 21:36:31 +0200
Subject: (subset) [PATCH v3 0/4] rtc: convert multiple bindings into
 dtschema
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
Message-ID: <171338250318.37347.8193747079895691565.b4-ty@bootlin.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 22:22:15 +0200, Javier Carrasco wrote:
> This series converts the following bindings into dtschema, moving them
> to trivial-rtc whenever possible:
> 
> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
> - lpc32xx-rtc: trivial-rtc, referenced in arm arch.
> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
> - orion-rtc: trival-rtc, referenced in arm arch.
> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
> - stmp3xxx-rtc: add compatibles and convert, referenced in arm arch.
> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: rtc: pxa-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/bbd3e43662d7
[4/4] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
      https://git.kernel.org/abelloni/c/c3a0ee85f6e3
[2/4] dt-bindings: rtc: convert trivial devices into dtschema
      https://git.kernel.org/abelloni/c/1c431b92e21b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
