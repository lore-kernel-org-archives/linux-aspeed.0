Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADC60A260E
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Oct 2026 12:00:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j89vs6Mj3z2y7M;
	Tue, 20 Oct 2026 23:00:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792497609;
	cv=none; b=Lyj/LZ0NQS40yUDHn76D+VjRoOCIZVRe0qPvZf829iDYwcnCpeSiehL/ZthXB+n/+tB53QzbDSI5K5k102JCXbT/mbNnh5BQRMhu0fuHPmf+cMhdLz0g/b9U7t6wISlJ9QP0MokLNXVE7b23FVABGyVdrYE1TBBF/SJ5hvcWjoqXvymDc5k/A574V8HfnEqtmHseOZrt4QMo1/wH3gMsBaQ/usABS0nQAeSmSvZoCrNNbZBvasqYpJkToBgPUqg1aIayHmX2ZeCJNq554pV/16lHYWomzl9ACkKuHwe5Qx41mBlSHYU8GsBSCH3hgj1ne4TcrqPF0zvMCBTw9umnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792497609; c=relaxed/relaxed;
	bh=i4oGaJQV3XJqsm/hWoRJNMCRGKUS59OxQJLz4fnNv00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N0xSmBzVNjgDu5r/Sk1fwHVWJYtCRdn8u7EUKRjNQCKoH5KwecpQASL1RCEtIUyVNhg2Sn2F0XFygJcgTRGFFn0koYTqUuVPE4dlDFmPIY2iSMN3Q5AoCzI853RThgQvBGral4NyCoctFOqJByEq48JxRAiUKqy0BDCt5D/cMI00+fQ/4tLYn6FeeTiHdQiXCa7+KF35Pufdcyhpd4ckvMhY6pXNbY8zdVepvJFtSj2XBbkZLab/6pIqY0PDk3aOrteN3y6/AyIcwpdxWp0s2qUOSiZF76WazJKRIB86aKOl41gIMmgK2AuosrfvIxUPfTrNU/zHfpy17JpYc4D/vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j89vs02s1z2xmk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 Oct 2026 23:00:08 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Oct
 2026 19:59:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Oct 2026 19:59:50 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 20 Oct 2026 19:59:51 +0800
Subject: [PATCH v10 3/3] MAINTAINERS: Add ASPEED PCIe PHY driver
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
Message-ID: <20261020-upstream_pcie_rc-v10-3-fba209af8656@aspeedtech.com>
References: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
In-Reply-To: <20261020-upstream_pcie_rc-v10-0-fba209af8656@aspeedtech.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792497590; l=878;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=YHD/I/0JKp9KeOT+Xzp15SjhKbuwAUqqCo+GFOfkoDI=;
 b=LzzTR9aoi8dc341tveSjtXD/pvQogGJy+/xDpgGPzrm+LJ1UXgPOd0bY3szbF2jH3Bvp6u18k
 HiEUQoOGcekBJ0o8IYprf1oaxzK/jmVjGiEBEb3xnnZlRjjgxS1dFcP
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add maintainer entry for ASPEED PCIe PHY driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0570815ee980..33a0336110a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4044,6 +4044,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/aspeed,*
 F:	drivers/crypto/aspeed/
 
+ASPEED PCIE PHY DRIVER
+M:	Jacky Chou <jacky_chou@aspeedtech.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-phy@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
+F:	drivers/phy/aspeed/phy-aspeed-pcie.c
+
 ASPEED PECI CONTROLLER
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)

-- 
2.34.1


