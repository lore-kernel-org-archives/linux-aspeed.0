Return-Path: <linux-aspeed+bounces-2941-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB199CCD19A
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 09:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9f5B3hDwz2yG5;
	Tue, 18 Nov 2025 20:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763457134;
	cv=none; b=dXDjMFNJFP4PFp+gxNI05TkPU90NHEDJz74RX4Q20/kxoVZdsoTs15XYlSY6dyIaQKLYaTQIJH+suk/Ya14UESU5AxcSc9szgNC/JmWYQYNKRXZ8v7gYajbExnM6UjgBGx2ZWBZCTyBrjJ6U4mnD2hFFxb/QTjSd0YaJD4gCcd50SE1kzNj1SYC4D1T3bGuMH8HdVckXnUbgqim6xXX2BXBmd3QOq2RybCilfHzLK26C/cBEa0xMOpPp++17kcK7ru7alTkys+1hmQ026PmWXMEmm9dw3QB4oGrQMDEZ4a65CVC8UCo1sVr3YjxKaJ3cEucV+UqDsEnTi1v/OBDp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763457134; c=relaxed/relaxed;
	bh=TpKQqg9xL9zI1I7i3E9eH3Nolz2yj2p4CmcHxnDb2FY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=FuljLysyFNdZ6Z4sOQ1DbUjErgj8R9qtSvsxmDc8L86IN6X36KKxmOCPAfx1IMpUkf3VmVR8uzunHz7SZhyf+YDEWaetLZEdxxshV2Y3GUwWdaDNQbObG09PuqxQz9ZUub9NxHMS0S5uxv4UWt/1KyU0oeccTpHijOzzuFSJvxbx6hVhLSxXEqmMOulzbKow3zHMMrb2I1w+AlI0FrH1vZoUmJ9BcdsllW1+OYI0lnqURWksFDUt9Jl8STYVhZEn8xAdpcDKU4wy7eF+T+EuEUHu+8s054YprJ5sEi1yhD5jlQlOcgfFZhXNZ0KmYIZ+TjGyPy5vHEo4g4QZtmCJjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9f590LjFz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 20:12:11 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 18 Nov
 2025 17:11:54 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 18 Nov 2025 17:11:54 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 0/2] Add "aspeed,ast2700-pwm-tach" compatible string
Date: Tue, 18 Nov 2025 17:11:52 +0800
Message-ID: <20251118-upstream_pwm_tach-v2-0-4d9bc13d34f9@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAFg4HGkC/02MSw6DIBQAr2LeuhggWrQr79E0BvFZXiJCgP5iv
 HtJV11NZjGzQ8JImOBS7RDxSYn8VkSeKjBWb3dkNBcHyWUrhOjYI6QcUbsxvNyYtbGsVcukleo
 Ndg2ULkRc6P17Xm/Fl+gdy7ZEfyfe8LZA1vKset4pJthE6/oZc9I06BQQ54zG1sY7OI4v6PorT
 qgAAAA=
X-Change-ID: 20251118-upstream_pwm_tach-57fba779ce84
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763457114; l=987;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=eInYEJN6YIiUk3jMYad5Xh4rxav6UXQDFOgidbnXMpI=;
 b=unNyKr7Id/LId888XbVFwSETVvp0CHpyaGf11gFBnuhsLV/Q0QHUqz6GoeUsvEEO9sLUSUCAF
 54Y9pN4dJW1DmLI9d/DlWFji1uprzAypbZPxsUzRChf8DIkD2godHo2
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Adds the "aspeed,ast2700-pwm-tach" compatible string, which provides
fallback support for the previous version of the hardware design, to
the PWM/TACH dt-binding and driver.

---
Changes in v2:
- Reworked the binding to use a two-level compatible list with
  "aspeed,ast2600-pwm-tach" as the fallback.
- Link to v1: https://lore.kernel.org/r/20251104055112.2679087-1-billy_tsai@aspeedtech.com
---

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

---
Billy Tsai (2):
      dt-bindings: hwmon: Add AST2700 compatible
      hwmon: (aspeed-g6-pwm-tach): Add AST2700 compatible string

 .../devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml          | 10 +++++++---
 drivers/hwmon/aspeed-g6-pwm-tach.c                             |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)
---
base-commit: e7c375b181600caf135cfd03eadbc45eb530f2cb
change-id: 20251118-upstream_pwm_tach-57fba779ce84

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


