From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 10 Apr 2024 15:55:52 -0000
Subject: [PATCH v2 0/4] rtc: convert multiple bindings into dtschema
Message-ID: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series converts the following bindings into dtschema, moving them
to trivial-rtc whenever possible:

- orion-rtc: trival-rtc, referenced in arm arch.
- google,goldfish-rtc: trivial-rtc, referenced in mips arch.
- lpc32xx-rtc: add missing property and convert, referenced in arm arch.
- maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
- rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
- pxa-rtc: add missing properties and convert. Referenced in arm arch.
- st,spear600-rtc: trivial-rtc, referenced in arm arch.
- stmp3xxx-rtc: add compatibles and convert, referenced in arm arch.
- via,vt8500-rtc: trivial-rtc, referenced in arm arch.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- General: squash all moves to trivial-rtc into a single patch.
- MAINTAINERS: remove reference to google,goldfish-rtc.txt
- lpc32xx-rtc: create own binding to add the undocumented 'clocks'
  property.
- fsl,stmp3xxx-rtc.yaml: document missing compatibles.
- Link to v1: https://lore.kernel.org/r/20240408-rtc_dtschema-v1-0-c447542fc362 at gmail.com

---
Javier Carrasco (4):
      dt-bindings: rtc: convert trivial devices into dtschema
      dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
      dt-bindings: rtc: pxa-rtc: convert to dtschema
      dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema

 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 -------
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 -----
 .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 +++++++++++++++++
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 --------
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 ------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 -------
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 16 +++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 -------
 MAINTAINERS                                        |  1 -
 14 files changed, 148 insertions(+), 150 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240406-rtc_dtschema-302824d1ec20

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

