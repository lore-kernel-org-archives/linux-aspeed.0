Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE047606A336
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Oct 2026 12:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j89vp058bz2xwL;
	Tue, 20 Oct 2026 23:00:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792497605;
	cv=none; b=j+oqQtdJMX988+fm2DlBe45P0QANmJXEHQKR9+CmqVq5ma2/dVcpEL0ewqqSBUyNPLP79UPPdhTqjCcpbU4LLm8De2rHPAwBE+pNQaHVujoM4/GeazjCdDMYKxAGTC+/c3bZOAz2uIHfA3ZFnvlvjgfeXKUNdO3b9focUodZa6KuIvww6omx6T0yle/WfQatdN2X2KLWki2Vsn8I11YHERlpFDwaS/FWDX7b7hhGUMWhQ372ahmoAII1Q4v67mkvlfbLaWC4Nm+PXmBp5peDX/A4Tf4m92rK8ZwZEf1Lcvnmi6rpGtVCku6BzKpKqNrV0pR3fA9sl8tOzZY1EkccYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792497605; c=relaxed/relaxed;
	bh=46IyvM73UruEFoU5tvYGZme473bX8sHtZFFnADjSTtM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LPi64A9oU0/Fl+3LSPDwrj3IAHtB1tZQrR13r0HEa07wSfskNKkqX69UJSk9PSQD6I+SYczC/VD9vmr0I00uhuWEYCqGmDzx4mV++bCZQh6EhbdyKtBmO1EqWaP/gT0RTqLpWlVLRnVA18ZY9smVr8IzUEpfT5tNmyFNkXerZJJtvEwA8DslDkcwDn9I7QYbxUkpaDilS5epkbLDwDlVUSq72XhJ3Fz75Jm1PO8iipTLJEv+sqGniYDsNE4A+Mka6/hXAPNZO8RuBxw3zZmV3eLkTOW9/QDwxkUyr8Zg1lDa7jcdRZ9eWCOOjWM0PQXy2ai+4UrP2PJ/pQNaEisGWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j89vn0Hbhz2xmk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 Oct 2026 23:00:05 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Oct
 2026 19:59:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Oct 2026 19:59:50 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH v10 0/3] Add ASPEED PCIe PHY support
Date: Tue, 20 Oct 2026 19:59:48 +0800
Message-ID: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRX12oC/43R22rDMAyA4VcpuZ6DZEU+9GrvMUZxFHfJRpuQt
 GGl9N3nFrYUauguJfg/gX0upjh2cSrWq3Mxxrmbun6fBoSXVSFt2H9E1TVpUWjQjAikjsN0GGP
 YbQbp4mYU5aqKLfumdkhFyoYxbrvvm/n2nua2mw79eLqdmPG6vWFgkIAIAEtCJkNWofoM8nXaS
 NsfX8M0xNgcorSl9LviKs16qS0yUEUaSs1M7j81LbUHBGavdYmpZobndfVXI2gLnp3mEh2iwec
 xLzGifXzDmRWougroHVsTZJtVzKJowIxikuLEOQBhU6PJKvZOQZNRbFKqEGvYMkklMau4O4Ugo
 7ikALF30jQOpMkq/lcxgMgZxSelMeJ0SB9lgn1QLpfLD8KAQxjFAgAA
X-Change-ID: 20251103-upstream_pcie_rc-8445759db813
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792497590; l=6380;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=nsaiDKDcqqGMfom04v8aWN0Ba2aHC4xg9Hlr8F8E+a4=;
 b=5UFcNODqu9txzKJ83jT+ocQVK77jeiXxOQwW6FRy6eVJJanU2IHEeSn1chJJb642IbW+uncc3
 9ptecfQeVuOCKpvxaobrKIRy6f5IurkWzCJm1vmqhcJaRb1wWIu1tfS
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds support for the ASPEED PCIe PHY, including the
device tree bindings and the PCIe PHY driver.

Summary of changes:
- Add device tree binding documents for ASPEED PCIe PHY
- Implement ASPEED PCIe PHY driver, including reference clock handling
  and an AST2700 host bridge reset sequence
- Update MAINTAINERS for the new bindings and driver

This series has been tested on AST2600/AST2700 platforms and enables PCIe
device enumeration and operation.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v10:
- dt-bindings: add required 'clocks' property (fixed 100MHz PCIe
  reference clock) to the PHY binding
- Drop Rob Herring's Reviewed-by on the dt-bindings patch since the
  binding gained the new 'clocks' property
- Kconfig: allow building the driver with COMPILE_TEST
- driver: get and enable the PHY reference clock in .init(), release it
  in a new .exit() callback, for both AST2600 and AST2700
- driver: add AST2700 host bridge internal reset sequence around the
  port-type configuration in .set_mode()
- driver: make pcie_phy_ast2600/pcie_phy_ast2700 platform data static
- driver: fix ast2600_phy_set_mode() to read-modify-write PEHR_GLOBAL
  instead of overwriting the whole register
- driver: merge the identical ast2600/ast2700 .exit() callbacks into a
  single aspeed_pcie_phy_exit()
- driver: include <linux/of.h> directly for of_device_get_match_data()
- driver: remove the unused dev field from struct aspeed_pcie_phy
- MAINTAINERS: fix drivers/phy/aspeed/phy-aspeed-pcie.c file path
- Link to v9: https://lore.kernel.org/r/20260115-upstream_pcie_rc-v9-0-d6c82a1556a7@aspeedtech.com

Changes in v9:
- Remove '[v8,2/4] ARM: dts: aspeed-g6: Add PCIe RC and PCIe PHY node'
  and send it separately.
- Use FIELD_MODIFY to configure register.
- Link to v8: https://lore.kernel.org/r/20251230-upstream_pcie_rc-v8-0-03598cdd80cd@aspeedtech.com

Changes in v8:
- Update the title of cover letter
- Remove 'default y' from Kconfig
- Change 'PHY:' to 'phy:' in the title of ASPEED PCIe PHY commit.
- Remove unnecessary headers from phy-aspeed-pcie.c.
- Add ASPEED PCIe PHY MAINTAINERS
- Remove applied patches
  [v7,2/7] dt-bindings: PCI: Add ASPEED PCIe RC support
  [v7,5/7] PCI: Add FMT, TYPE and CPL status definition for TLP header
  [v7,6/7] PCI: aspeed: Add ASPEED PCIe RC driver
  [v7,7/7] MAINTAINERS: Add ASPEED PCIe RC driver
- Link to v7: https://lore.kernel.org/r/20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com

Changes in v7:
- Add PCIe port into aspeed,ast2600-pci.yaml.
- Remove aspeed_pcie_init_ports() and merge aspeed_pcie_port_init() to
  aspeed_pcie_parse_port()
- Refactor aspeed remap pcie addr to aspeed_pcie_map_ranges()
- Link to v6: https://lore.kernel.org/r/20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com

Changes in v6:
- Refer to pci-cpi-bridge.yaml to update aspeed,ast2600-pcie.yaml and
  the pcie node of aspeed-g6.dtsi.
- 'dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST#
  group' have applied, remove it from this version.
- Adjust the defnitions in pci.h.
- Link to v5: https://lore.kernel.org/r/20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com

Changes in v5:
- Remove legacy-interrupt-controller and the INTx points to pcie node itself.
- Correct bar mapping description and implementation to PCIe address
  configuration in pcie-aspeed.c driver.
- Link to v4: https://lore.kernel.org/r/20251027095825.181161-1-jacky_chou@aspeedtech.com/

Changes in v4:
- Remove aspeed,ast2700-pcie-cfg.yaml
- Add more descriptions for AST2600 PCIe RC in aspeed,ast2600-pcie.yaml
- Change interrupt-controller to legacy-interrupt-controller in yaml
  and dtsi
- Remove msi-parent property in yaml and dtsi
- Modify the bus range to starting from 0x00 in aspeed-g6.dtsi
- Fixed the typo on MODULE_DEVICE_TABLE() in phy-aspeed-pcie.c
- Add PCIE_CPL_STS_SUCCESS definition in pci/pci.h
- Add prefix ASPEED_ for register definition in RC driver
- Add a flag to indicate clear msi status twice for AST2700 workaround
- Remove getting domain number
- Remove scanning AST2600 HOST bridge on device number 0
- Remove all codes about CONFIG_PCI_MSI
- Get root but number from resouce list by IORESOURCE_BUS
- Change module_platform_driver to builtin_platform_driver
- Link to v3: https://lore.kernel.org/r/20250901055922.1553550-1-jacky_chou@aspeedtech.com/

Changes in v3:
- Add ASPEED PCIe PHY driver
- Remove the aspeed,pciecfg property from AST2600 RC node, merged into RC node
- Update the binding doc for aspeed,ast2700-pcie-cfg to reflect the changes
- Update the binding doc for aspeed,ast2600-pcie to reflect the changes
- Update the binding doc for aspeed,ast2600-pinctrl to reflect the changes
- Update the device tree source to reflect the changes
- Adjusted the use of mutex in RC drivers to use GRAND
- Updated from reviewer comments
- Link to v2: https://lore.kernel.org/r/20250715034320.2553837-1-jacky_chou@aspeedtech.com/

Changes in v2:
- Moved ASPEED PCIe PHY yaml binding to `soc/aspeed` directory and
  changed it as syscon
- Added `MAINTAINERS` entry for the new PCIe RC driver
- Updated device tree bindings to reflect the new structure
- Refactored configuration read and write functions to main bus and
  child bus ops
- Refactored initialization to implement multiple ports support
- Added PCIe FMT and TYPE definitions for TLP header in
  `include/uapi/linux/pci_regs.h`
- Updated from reviewer comments
- Link to v1: https://lore.kernel.org/r/20250613033001.3153637-1-jacky_chou@aspeedtech.com/

---
Jacky Chou (3):
      dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
      phy: aspeed: Add ASPEED PCIe PHY driver
      MAINTAINERS: Add ASPEED PCIe PHY driver

 .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      |  49 +++++
 MAINTAINERS                                        |   8 +
 drivers/phy/aspeed/Kconfig                         |  12 +-
 drivers/phy/aspeed/Makefile                        |   1 +
 drivers/phy/aspeed/phy-aspeed-pcie.c               | 230 +++++++++++++++++++++
 5 files changed, 299 insertions(+), 1 deletion(-)
---
base-commit: 8f56fdf3d8cb9f1dbdc93bf9ac816698aa6f70b7
change-id: 20251103-upstream_pcie_rc-8445759db813

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


