Return-Path: <linux-aspeed+bounces-4152-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69028CD6E56
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Jun 2026 09:14:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTSvp5yjtz2yb9;
	Mon, 01 Jun 2026 19:14:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780305270;
	cv=none; b=oaiLqbYAFGjf/gUM9x/OlxzLrxhwTAeXrZ5ePk95ApDG4vaqJYSSQ4ts1ubgubopO75rEVOu1PGqmXs3eybmZJz5A01fCfndPF6z1oGkNRsIWK79zn98Hn3pB827uWpiw8eFUSUnDEg3DJutJzlyCT0RejGJQxOxsVWYMDg9d9QQ6hH2JanOATemho1KuVeM1NugqtubHq9SBVm8eCiTpY5ECxOzO4+LnSqQH98Jge+cuxte79e1SviKEuRI7ctLdDeVDQA21kJi8PF4UJNMAXRJVj8h8v1V68YXVdjQD/67A4B3eRfzxgos41z1vBioX8phL9S0VlBYBa0PkTBzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780305270; c=relaxed/relaxed;
	bh=LzQ/I+NCNl4TzDKMxFcAIOhk0fzCZDdLZdA3AnA2C94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fDdE3IfoTlMkmrlO4n8uqmlENvtoqPXGkrTnXREm+Q9ULx9B5YszCHtPBfCQcURKpdethrlt36qNZjsIz2ow9SHXv+VhmzQBM+ZDiotYGxDtk3PJdSV6d4GdP2H7ooHZcLJs57iR7pWFbSTqzTMkQBlXLKmqST+WVaq5VfVPiZ+tAqzorNDBlM0shPz/Pce0W2SoruPBfC62oWqFbSVZor6T7vCwyJ40Bm0Rzq1fT29H7Dg8mY64YhCeBTliLqhhvVlteepma15ExFynC40FhCSCR3wXsgnBpXYQNFtLvBu7rXXm3B0Jg/xKjagDSOOVOTAsEecfBBkfeH47AMqznw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=tommy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=tommy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTSvp0JZBz2xdb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 01 Jun 2026 19:14:30 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 17:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 17:14:10 +0800
From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Mon, 1 Jun 2026 17:14:06 +0800
Subject: [PATCH 1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
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
Message-ID: <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
In-Reply-To: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, Tommy Huang <tommy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780305250; l=941;
 i=tommy_huang@aspeedtech.com; s=20260601; h=from:subject:message-id;
 bh=UUmiTipKkk9DzmFJKj37uR0bOtljZyyou0W0KGxbwxs=;
 b=S2E+CuVxKUPTFq2pQv7dQ/0/iNQ1rOOPtB8ZU9f6U0eVWMrT9w0OOm0wpiwFPzrdUIDU9wizE
 WIbbp+tpOKrCmHViQy3Rb512Xyx5DIrrGybwr9Loek522/E8nMYWYCg
X-Developer-Key: i=tommy_huang@aspeedtech.com; a=ed25519;
 pk=/SRU8iPtlyPCtlX7hXjYJhOTpCUdfEZ9pIVVyCQOjLE=

Document the compatible string for the RTC controller found on
ASPEED AST2700 SoCs.

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 722176c831aa..f4d0eed98a08 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -30,6 +30,8 @@ properties:
       - aspeed,ast2500-rtc
       # ASPEED BMC ast2600 Real-time Clock
       - aspeed,ast2600-rtc
+      # ASPEED BMC ast2700 Real-time Clock
+      - aspeed,ast2700-rtc
       # Conexant Digicolor Real Time Clock Controller
       - cnxt,cx92755-rtc
       # I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output

-- 
2.34.1


