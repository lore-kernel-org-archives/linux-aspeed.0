From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 9 Apr 2024 12:26:58 +0200
Subject: [PATCH 0/9] rtc: convert multiple bindings into dtschema
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
Message-ID: <20240409102658d86fb2bd@mail.local>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/04/2024 17:53:00+0200, Javier Carrasco wrote:
> This series converts the following bindings into dtschema, moving them
> to trivial-rtc whenever possible:
> 
> - orion-rtc: trival-rtc, referenced in arm arch.
> - google,goldfish-rtc: trivial-rtc, referenced in mips arch.
> - lpc32xx-rtc: trival-rtc, referenced in arm arch.
> - maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
> - rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
> - pxa-rtc: add missing properties and convert. Referenced in arm arch.
> - st,spear600-rtc: trivial-rtc, referenced in arm arch.
> - stmp3xxx-rtc: convert, referenced in arm arch.
> - via,vt8500-rtc: trivial-rtc, referenced in arm arch.

Probably all the moves to trivial-rtc can be squashed.

> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (9):
>       dt-bindings: rtc: orion-rtc: move to trivial-rtc
>       dt-bindings: rtc: google,goldfish-rtc: move to trivial-rtc
>       dt-bindings: rtc: lpc32xx-rtc: move to trivial-rtc
>       dt-bindings: rtc: maxim,ds1742: move to trivial-rtc
>       dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
>       dt-bindings: rtc: pxa-rtc: convert to dtschema
>       dt-bindings: rtc: spear-rtc: move to trivial-rtc
>       dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
>       dt-bindings: rtc: via,vt8500-rtc: move to trivial-rtc
> 
>  .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
>  .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
>  .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 --------
>  .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++++
>  .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 ------
>  .../devicetree/bindings/rtc/orion-rtc.txt          | 18 ---------
>  Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 -------
>  .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 -----------
>  .../devicetree/bindings/rtc/spear-rtc.txt          | 15 --------
>  .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
>  .../devicetree/bindings/rtc/trivial-rtc.yaml       | 18 +++++++++
>  .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 --------
>  12 files changed, 103 insertions(+), 149 deletions(-)
> ---
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> change-id: 20240406-rtc_dtschema-302824d1ec20
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
