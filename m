Return-Path: <linux-aspeed+bounces-3580-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B63EB3640
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 23:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPw3C3KvGz3bn7;
	Tue, 03 Mar 2026 10:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772414252;
	cv=none; b=gLfRrO5TV/NtxXx9KCty1ikT3Ax/b+TXhmRrFIx9VnCvsbQ916jkRlPNF2Mh+Rp7ztbqbAcbzTcN2gglEe9yCv/wmgoWMzEc4z3+YyMB8Nub81WFWtl6i7mJUYgrM634k/ixbWNoFAJD4/WwxoVntWV11QxW/Z0VXPL1xCSDTB7bxkFJWgAfVIS+Qy+kmEw8+NWpSLPSLR5NROETU4UJcIw0h12VHTVlT+9t49lOwiJsisZh+BI0xhPlwXSFrGk5lHVb1+8KYRDm0IK98GGtGwgadnjy3NN2c2xOvV9BeyaECFNzicNZFZ5Z7fNfIfBP/Xpwca8Q7MNSQAjxh95aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772414252; c=relaxed/relaxed;
	bh=ayeVUG3ZWz5GOZTLqm1j7zNmBbCHjxngWbSmWErbVTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2rrQJGSFvVKHBHzq01g23UqynTJklM7afRjYdrZqRIrMHZd7umA9X7m3yz6vR2Eb3LHDLCWYskS+beXISG7H09GMlYv5gQcAcrYz//idcnvMxJ2zUQ7etZFrpJlW8h5UHDtPduh8x0o5aswzx3+2cQlSlyNtyfVo+xjpUoJxXLzLeF6nmXUW9f8hMWv8ZkbHXpYIxL+PTx2/CpCyK0nKd8bNnF0+Pjn0QZUOsMIMUaLdzuS7Fya74WtU971ZfphU36yYGUh+iDKLzNzbWT7FQYRuNAV1sttSHbgwRE5ODE0FnnLmtVC5NQB39XTwDwxl3p54BGL4duBkBGnGNzmWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=coKBvBI7; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=coKBvBI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPLdN5dqPz2xNC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 12:17:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ay
	eVUG3ZWz5GOZTLqm1j7zNmBbCHjxngWbSmWErbVTQ=; b=coKBvBI7U9XjbHiRqZ
	0Hh2D8X/0dma9ToRokUkxsK6o/BENsxE7P96dR2z6QV/IL6qLrWUGc1gxHNdapX+
	QmJcY1wsu0e4siGvsYQZ5PWf6v2Wz3NbfBg01LPLl+W5LAN1E5RqLgPJXZrakOJF
	wP+4iZI3vt261bgWsmv7Roym4=
Received: from haiyue-pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHyX4F5aRpmz8NOQ--.15911S2;
	Mon, 02 Mar 2026 09:16:54 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] dt-bindings: clock: ast2600: Add reset definition for video
Date: Mon,  2 Mar 2026 09:15:00 +0800
Message-ID: <20260302011651.94682-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHyX4F5aRpmz8NOQ--.15911S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rWr1kur17tr4kZF1DJrb_yoWkZFb_C3
	47Zw4kJr1fZrn5KFsYyF1DJw4rK34UAFyftryYvryakrWrAFn0gFs5Xr9Iy3W8GFs3AF1v
	ya45Ww1fZFs7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRuE_NPUUUUU==
X-Originating-IP: [116.233.47.41]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC8Af9aWmk5Qe7pwAA3Q

Add ASPEED_RESET_VIDEO reset definition to the ast2600-clock binding
header. It is required for proper reset control of the video on the
AST2600 SoC for aspeed-video driver.

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
v3:
  - Drop 'Fixes:' tag in header file patch.
v2: https://lore.kernel.org/all/20260227151602.829-1-haiyuewa@163.com/
  - Fix checkpatch.pl warning, and send dt-bindings as single patch as
    the submitting-patches guide.
v1: https://lore.kernel.org/all/20260227123837.70079-1-haiyuewa@163.com/
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index f60fff261130..7b9b80c38a8b 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -124,6 +124,7 @@
 #define ASPEED_RESET_PCIE_RC_OEN	18
 #define ASPEED_RESET_MAC2		12
 #define ASPEED_RESET_MAC1		11
+#define ASPEED_RESET_VIDEO		6
 #define ASPEED_RESET_PCI_DP		5
 #define ASPEED_RESET_HACE		4
 #define ASPEED_RESET_AHB		1
-- 
2.53.0


