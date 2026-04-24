Return-Path: <linux-aspeed+bounces-3956-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B05FF885C
	for <linux-aspeed@archiver.kernel.org>; Sat, 25 Apr 2026 06:21:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2fqG00Hdz2ynT;
	Sat, 25 Apr 2026 16:21:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777058499;
	cv=none; b=ZMscnFYWp633Xb6qLctIzEIAMya1hOwH4NooOIv2ucUgt/QbbAHE2jFqixWN6LI+j4dv8hcGhgcIV8QuKluMnZFbRO+oCBTx5YKHM5ogKgjgcxD55/tBWIADSlrxGWDfVEF+Z3S7FN4eYbvxZCcWjxpAqNam3VEBguCAQbRnl56sDWo8eYbr/e9Pd1zMUkIKV7aFJnVWrt9LRD8Mlyyus5m5NsL9QeKuodBA1rRuch+aFq9CjJDuYV4E9o3I3wrlR1CmeOyZO9MJysCJS6QMF47FaBOIYSPs/tpDbYX4gQWBmMF/GZwpeb4OFhu0dJbze2LzxoCThfBlYrWR3eMEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777058499; c=relaxed/relaxed;
	bh=f9hnG+Q/MrYGKRftwGvdBxXRGFmAraFgEeSCELv07SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdRbmVstfWSIXznE/FoifAp0VWiwBDpUDnHPAGbS160kO+zhUlPz1a2j1cZhhlykDikyrmdujj91LixHnslkb3SHDg+oWjrP6gwZ43zu/j0x3AyL+DSwI7pMQzjXbRNEqucnEiGo679ZodopwyjeMiwCwbueMtThNUiREee8IeYdwA/Z7Flx4yL8CFYSQd55vimQ/Mc+JeYUyA+pdCmm0sFw8T+UihaAdGH0PMxPNugL3omzdJLpn83HIkKTUdQHv1G7tKCFxnUS8lqsYjKKuL/LUVwUjqGVQKGl1BX2Rs7JUGX+o5UY3Xaaw1Ln17/a+lq+JdmaDhFK0yAPDFp49Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TRpR08Gy; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TRpR08Gy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2N9t5ztmz2xTh
	for <linux-aspeed@lists.ozlabs.org>; Sat, 25 Apr 2026 05:21:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777058499; x=1808594499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDfuH2SmmN+K4WcmOTWBN1VqRl4QabbTNxYayYalR8c=;
  b=TRpR08Gyvpo/8JnRS/wb2gvXH88m8jmIIt2gtHF+cR28Z5WGYG8m4F3U
   k5jLORot8rlibuPiZglP6H4QjqTLfgAfHWruTF2jnTqOlqHrjsLp2fzbS
   IxsVP2T5vfrwDW44RACUWS2/HJ48JOapHqpW5SBXDV4GD9ApLSg9URW22
   b/oxLGnsiWEPDGK+sX5UVuuzaPTXPTW/Pw01IT2cqM/ZFI7knFtp53EaW
   RkqpdBoWfjNRDeTxofLzDAjkFWbT8COQKDZXKishrZcfdAoFN8sBmBoLv
   gluFow7Dw8KpMuh7utE9zCQr8XL7QKpE3WUJQaLe4z8R89Te9Qd8kPHHr
   A==;
X-CSE-ConnectionGUID: IXnsb1T2Tf6AT7RgKzLH7A==
X-CSE-MsgGUID: 9qiGTO+/TxWtf/omTRH+dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77208287"
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="77208287"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:38 -0700
X-CSE-ConnectionGUID: maz5UlhaQjSklYtwVIvBww==
X-CSE-MsgGUID: 8ypUnF/8QDiCDFus7CbLLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,197,1770624000"; 
   d="scan'208";a="232040496"
Received: from gklab-103a-129.igk.intel.com ([10.91.103.129])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 12:21:35 -0700
From: Dawid Glazik <dawid.glazik@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawid.glazik@linux.intel.com,
	maciej.lawniczak@intel.com
Subject: [PATCH v4 2/3] dt-bindings: mfd: syscon: add aspeed,ast2600-i3c-global compatible
Date: Fri, 24 Apr 2026 22:21:00 +0200
Message-ID: <41d66492e1a1d42f6888459288311094c8b7bc51.1777058942.git.dawid.glazik@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777058942.git.dawid.glazik@linux.intel.com>
References: <cover.1777058942.git.dawid.glazik@linux.intel.com>
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
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Add aspeed,ast2600-i3c-global to the syscon binding compatible
lists to document the AST2600 I3C global register syscon node.

Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index e57add2bacd3..50c07038122f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -49,6 +49,7 @@ select:
           - apm,xgene-mcb
           - apm,xgene-rb
           - apm,xgene-scu
+          - aspeed,ast2600-i3c-global
           - atmel,sama5d2-sfrbu
           - atmel,sama5d3-nfc-io
           - atmel,sama5d3-sfrbu
@@ -161,6 +162,7 @@ properties:
               - apm,xgene-mcb
               - apm,xgene-rb
               - apm,xgene-scu
+              - aspeed,ast2600-i3c-global
               - atmel,sama5d2-sfrbu
               - atmel,sama5d3-nfc-io
               - atmel,sama5d3-sfrbu
-- 
2.43.0


