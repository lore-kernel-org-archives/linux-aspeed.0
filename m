Return-Path: <linux-aspeed+bounces-4572-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7C1C531FC
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 04:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7ly914c0z2y8d;
	Mon, 27 Jul 2026 14:30:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785126625;
	cv=none; b=EjSY6O17qYQM8CWZJWGEskTO0UH8GFRfQotnxamsSK50ICxYiCmmayonpGaH80bX4mzL4Ed4MU1bP35WSLTrW+4jLAbhMF1J2lbo2B4I7zkQFlizGVipfRdNggsE+YX1gCvZ/51HqFbBvIGKiiy8NrUElT2nuazYChXZV7rsNHHP+tTXH6nyCnd6BgJg+WoYZRQ0Eai3yyVoa4PwkFrtTfOftPMTYJhfjjUuLUiaTXsSzY+NlB+qEa7Z02x20hmxDhoyw6+jKYuEueb0h5QJPh+eY5zdh2lKmcVnhYADLJvW11xIA4/7Cze6Dgb0s/dJ9yQQGh2j9T0NmKGtw8su5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785126625; c=relaxed/relaxed;
	bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9mBGPd4Rzp094ARk8iaObdpQBot3tk2WUWqi+LI3F2Efb2l4BC+T9iPetsi8GKziasZ8ZJSXlq0mdbYdifA2h8VTbO4RpFhuPbHeL5vwZWs18GF7i7v9jAGvDNeWs2TxFj4qILVYdP6NjTd+Q4rIhcXr/GeT+akONdfRyBLx1t9Tj5lj/TKVC8qPOmWQQgY1gBZmH4Ag0ONa6jT7hAhLVhkrLe3Bk3nEfSDDJw8eOU0EpE4ZuuueYZqki8I9wi0RnMf6flLC7Hy009yZL1TAnP9GZoyTNxcrgYj736R6W5dU8tBYrK+zTFOQSVvWmLE+oKyW+ZiMgMUHvK1SfrNhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyB2ARaX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UyB2ARaX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7ly83l1qz2xwN
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 14:30:24 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ced3386430so23234255ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785126622; x=1785731422; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
        b=UyB2ARaXwPpV52sziZjNGvcDT3Hc+eXFMYqX8ZgeW5Dkk2IAJLpqbvqiao8bbMjsVe
         cbXD2eIQLz7rDEY6zoEspjUXmUWvj4ruGeYEfjGjWiyrm3OGXMUGcRwx7LuAUbIkpY8Y
         8XQusmd77EFTBTgb9xZpDC2OQi2cZ6UIaCDiNzmYeP7s8QKjJvjdFeTnCBFbnbiQY0rM
         3txol/C1AzXAqlExHifD3okoBxnzdxO7AfZb6AMEUcVN030OJhg38J61jw/9QeVPd5O6
         ApTLZ2oO+/Mwi1VlpMcFg1LrZ1ktc5EhFAa2fm1ZGGYKYS/RIQmxUxFUPDbKOeks8Ned
         VQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126622; x=1785731422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
        b=GGywHq4OGZBp8SwODcqkhyXqKRqplwxbo7PS68Nqtz6mYzFM1caLNNS4p9blUjMx8a
         aYEvN3gyZAjE2yFVKSzO+fdWN8U+plvRUjXMMLyYkSrlDQ4/c1vtD8MFizCgkL3uzmvc
         FmIcC4cHl+EnFgLRGOUmfJhXxhuXtlI3WKCF+fgP3o9uxr5VtUi7nspLBIqvqanbtOBb
         A4XpF1Vc+WnHOfLQ/TPhaLMG9YIDQJsbwRd7mZQnMBbGh4pIKpwH0vBuvpNkHQXXIHOY
         JiIWWhSJqNijLkVT8nqLO7ZgPL+6il8S4KnojHlRF00iD35J8xZnv7pm268faFVfpob+
         HY2g==
X-Forwarded-Encrypted: i=1; AHgh+RphvSW1lI2l2gJls3QrGVpf9rPUpgOkCI+rhfi6mIF2RcQIICxLLPREaH+K0p9ZJPS8JuTiNmQTWOxLfxo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzvu5l+y+T7VlruZOv6Sg9EQXFqf925TjsGMdzjFli+JuAZOgBc
	i36ig6hFsF7ewclWdcRF/TuSOxpq5U1kefmpkvEYAZzQ6Y/MiL8i8fjo
X-Gm-Gg: AR+sD13Ma2KHsTnV61izT/m3PQ102wkLMAcbQRcuI8AF9ezgm8CuzxnbuPLdceNrGiL
	/Z7M2qI58v1ZsDpMgFnsCv8vmpKh7yqLYf5uf2Vyf7d2bwPu9IupaJ3r67RJIH0obNLgI6mv5WA
	YsjsW43dW5p44BxXKAK+UyT8YB2D2LIvCutRH6NZadA1Up9ZDInAKt6MQDG4PfaSwuN8fXs8dg3
	EHg1AUMme8Ro/ZazxBdy+H2PgdexnqVzok6uc/r21IorZ2eJFw8orBhoKBLT98fXuC3bIjnfBn5
	QbtdlOaVj+U3d12a6ofqz39DTFpt5yjyQyDNF2XWZhnsNfGHvz+GWQoLJK8Q/Rf4mlU0C6SiaRX
	bY+s+WGTHMHrSZvW9j3PWYu2X8DAQjoU9bsYqQW+pFcUIk7HVyqc0qBUM2BkD28PnAMxpOk8J9R
	GPhqxdpdPDpDPWDCSo/+y50554Xmf+0N2bcXljmZjdqw==
X-Received: by 2002:a17:903:1acb:b0:2cc:77f3:a934 with SMTP id d9443c01a7336-2cfde89bea6mr59939035ad.46.1785126622357;
        Sun, 26 Jul 2026 21:30:22 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde80f50asm27372145ad.77.2026.07.26.21.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:30:21 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 27 Jul 2026 12:32:09 +0800
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20260727-ventura2_initial_dts-v9-1-504c0ec68039@gmail.com>
References: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
In-Reply-To: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=FazoqI/ILuJD9YIY7tvUgoQ9mGvSj/LgYKIkJKM/QVM=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqZt9OKqVk+UNOOZ7EOnO+1ZHiy6C9OmYUeEsUu
 x1L5wJuTtyJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCambfTgAKCRClg0K3CVbE
 gUL0B/9KNiCnj3/MY7JH+tcOx3Lwu1GKhMmkwHIXZbla+56lXC+pkC1DoF5xSYkfgP3spMwVfvE
 al5XVkXTycvd4M7OdAZeq3DNyx0I8ggxp1+ODZZGWzVUm+IoCa2xa59awM7AHCB6jGELzdwoX/u
 tk8iixZfV9INDS2pa3C+z1gFPocIhdy0pWAJUpxJMr70G7kffChSTMC6dF4tKxEAbBo7Jvtugf7
 YZlzN3LSQGwfg3lIPuQd8mPs06lQ8Ew56kG3lwyJlgg51JM2kk9MklPpVddjXpUTmWVM3HlyqLr
 WeXdmCjAbuS2Vinr/RI+yFdAM7ITJZcWBzsP7ZqmdOkWqCot
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..b7e70868ebd8 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -98,6 +98,7 @@ properties:
               - facebook,rainiera6-bmc
               - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


