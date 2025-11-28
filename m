Return-Path: <linux-aspeed+bounces-3014-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAAAD111A8
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Nov 2025 00:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHYzY52HCz2yvC;
	Fri, 28 Nov 2025 11:27:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764289673;
	cv=none; b=lzZBdwFzZ1c5mwOYgZl4LLGiDIWIwNHKQLS4QOWT7FJ4MRAwCQhxE5Z4oSX8jlXTPmAUXO6i/yXdl3cHfSEwLUX9ZO/TxNfv5ykiCAZkJ8VwKiStNSbFbDGmCktIAFvFrzHuQJd9Y4cAAd0KkHqkBUWB+Ka8gJv6YtrSZCAyCIn7sv8A981SDAqjTllxpKNB/cE501huHnK6NEmXZ539shNuceDRhwrDX2uBMz+dgn8JVlzHnSz6DSVtFHziqgBj8KgFEyJAjeUmNZqD/JDZac5rSPEgZxj/9mQTbI7RuiDpQZXfIRBCewkjCW47rXXNu7413BRESZEtusPF/F2RnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764289673; c=relaxed/relaxed;
	bh=zxVVOgVSj9TQ/Mlnput3vdsEy1oKs7sCGU+ne47+YG4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YPq3CUn4IDh5ZOHR4dMVhmb6vrOUfOPFMdIHMM+jmyjXon3DWZy+hdH0OIzwF/f8jJz+t08luwT//Ewi+uWqjwYEWwpWO0YlYTaJGLmhXUjJFf3DsEB+uMQ3qaGsXeBAb4ilN6Y8uQlTWNAPrvqmKBWr79vFlFAApT+QshuZ1RfuuiaqXrsEVpAB52uc1AfhGq5DCT+e9o/v6EiMaTrvPEpthAjjPp7x/IAQbE1aFcIJ7VEnu7GBP3wV3aRpiAkkZZUlqwWtl2TtY+eO5lgBKx6CZ7NDVZ6UxLYeyIl5uDB6ShazoyTX8Yo7z5G3fKBa8rDZBY6ME/xJG+VqLFptMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHYzX2ylJz2yFT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Nov 2025 11:27:51 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 28 Nov
 2025 08:27:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 28 Nov 2025 08:27:34 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/2] Add AST2700 support for Aspeed vhub
Date: Fri, 28 Nov 2025 08:27:29 +0800
Message-ID: <20251128-upstream_vhub-v2-0-1fa66a5833c2@aspeedtech.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHsKGkC/13MywrCMBSE4VcpZ20kl8barnwPKRLT0WTRC0kbl
 NJ3NxbcuPwH5lspInhEaoqVApKPfhxyyENB1pnhCea73CS51EJIzZYpzgGmvyW33JmC5OVZmVJ
 rUP5MAQ//2r1rm9v5OI/hvfNJfNefdPqTkmCc1YJXvK5VBfCLiRPQzbDuaMee2m3bPmllE7ivA
 AAA
X-Change-ID: 20251125-upstream_vhub-3e20483a455e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764289654; l=1048;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=UrnAKGkKlxEe5ApYlVlupJbZmp/owkUSOCyzAFd03ac=;
 b=LGYVQGQ8i7g94NwVJWfNatY7KQZfrIp01emaDZlFrkoo8xIBtzqqpnkJqSdwTnEeuJh1jA+92
 9gQFRTNpRNdBXDIiyX6INWMuNOUOjzWveU5LwipX8snqn31NnmtAYc1
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add Aspeed vhub support for AST2700.
The AST2700 vhub requires a reset and uses 64-bit DMA.
This series updates the binding and driver to support these two
requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- add an else to block resets properties false on other platforms.
- add AST2700 in capability in description.
- Link to v1: https://lore.kernel.org/r/20251126-upstream_vhub-v1-0-910709937ee0@aspeedtech.com

---
Ryan Chen (2):
      dt-bindings: usb: aspeed,usb-vhub: Add ast2700 support
      usb: gadget: aspeed-vhub: Add ast2700 support

 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   | 22 ++++++++++++++--
 drivers/usb/gadget/udc/aspeed-vhub/core.c          | 30 ++++++++++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)
---
base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
change-id: 20251125-upstream_vhub-3e20483a455e

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


