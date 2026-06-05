Return-Path: <linux-aspeed+bounces-4190-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D29ACD8C88
	for <linux-aspeed@archiver.kernel.org>; Sat,  6 Jun 2026 02:42:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXMyv6NYlz2xll;
	Sat, 06 Jun 2026 12:42:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780639228;
	cv=none; b=YiH4C4MQswFPW7VDUGXoSVzh7RaKU5PtdFXVPeCT1FiSQfxFqX+ePqx1RWDat7RWSR1tLzaBa1+A+xqc1Ml5yXQ2lKh0XtY4vXzJe3o394HXE77uMsnVLBdhxjLWfvZx7cUQO4/oDx6ZovCQySLjnJIan0dCtxcc3WbAYaRLr/Sy3hpjHHd9KA/ApmAmoiIqAnBQzQcD0Pf4glmsWNTDOXlRS5C3lMkH171YaAy4UkSVQnNXssz0i35zhGMjFtu+rQ411WXjboHgE5Dw2q1QV7IGpHzp3ba+LFgzpKpvdCtjS3ezMsTE0akhfpe7CGIz4F8jhRea3Qk1bj+GFfRw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780639228; c=relaxed/relaxed;
	bh=PDUZXrIzs23JoehD5N023YX+ro7W1xlvqrfxPyG/NLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXzKaR3Y5FJUgt+k/5WRpgrH5548EL1HPn6atCXN1/kX7Xpteeylf5EEuBGmI8Nd7Y7eCPWMebiGJBvYjz3cIpTZcuTc5CUQuUzrPpVfCgX8PG3ItMab1GcKzosMEaP523SrGI1QZ16hk6HH4r5/AlSLA/A29ECd09WYm+kB+6eVbtVmcy5HWaURfyGdouVR64a5smxVKDs0D9+BsViLUrST49Ow+54xzvH9hgw/TSY9duqCpg/RQ8ItvJ7xymFY8/QiMewtl1BNetH6PpbNTRt6koMJfIRNFAevsA96WVjYa5820CoKav7ESgCqdq59yBA6B16wg8h83HQEsrQTHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZUhbrby; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZUhbrby;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 151 seconds by postgrey-1.37 at boromir; Fri, 05 Jun 2026 16:00:26 AEST
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWrQ250Qrz2xHK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Jun 2026 16:00:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PD
	UZXrIzs23JoehD5N023YX+ro7W1xlvqrfxPyG/NLs=; b=SZUhbrbysNNhLEi6un
	XRberLyoxv1V9Ma77zm/tBGWjQQ24d99P/P1blqLHzlbvdi2iqHQni10x8AFwnYV
	0LoeK26gim/ww1xC8dXBAvPqTPokYF4SvmdK9qlv3MI9IgNXKFk1XDRvSZOhCZKa
	kh37LS3J5KcLQahYxF5QqwyI4=
Received: from haiyue-pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXkGE7ZSJqxsLwAQ--.65168S3;
	Fri, 05 Jun 2026 13:57:17 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Cc: Haiyue Wang <haiyuewa@163.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/2] dt-bindings: clock: ast2600: Add reset definition for video
Date: Fri,  5 Jun 2026 13:52:42 +0800
Message-ID: <20260605055712.118501-2-haiyuewa@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605055712.118501-1-haiyuewa@163.com>
References: <20260605055712.118501-1-haiyuewa@163.com>
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
X-CM-TRANSID:PCgvCgAXkGE7ZSJqxsLwAQ--.65168S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4rWr1kur17tr4kZF1DJrb_yoWDCFg_Ca
	s7Zw4DXr1fZr93KFsxAF4DJ3yFk348JFySqr90vw1akFZYyrn8AFZ8XrsFq3WrGanayF97
	AF95Ww1fZrs7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREJ3vUUUUUU==
X-Originating-IP: [116.233.237.18]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC8B2L9moiZT2zuwAA3I

Add ASPEED_RESET_VIDEO reset definition to the ast2600-clock binding
header. It is required for proper reset control of the video on the
AST2600 SoC for aspeed-video driver.

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Acked-by: Stephen Boyd <sboyd@kernel.org>
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
2.54.0


