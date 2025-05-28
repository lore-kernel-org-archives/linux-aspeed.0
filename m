Return-Path: <linux-aspeed+bounces-1257-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EBFC3ABB2
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 10:41:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6mK16WPNz2ydt;
	Wed, 28 May 2025 20:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748428917;
	cv=none; b=ldOM39d2HksuLqCj4/CnaHNaQbSrWPbeV114vuA7PEnHBCXgVJnv9kzlh8ArSpjqgaEjrSn0yNq+/DXfhuoodDsXVc3zyDW/RhIOp3rivt5qHNGzgIPAJDyVwQmQNL22QJTz0K/STpIv9npStNGJY9AK/RJ9k/mcr9r2nFetsOSXAYMQYd12R2ANiahYt/2oAm2S8dkxgo7xDK2K7pG7jvRWjZ8XQUeIlCMbop+TS7iETeM9f+y/yONj8b2IN3AGhcYafXZY3zQeElsXI+voUvd24L/0SlIY8iP5aRwmpa5L49r5ob30zjy8TOvl7FOjCzIt86eKS2tLYZ4aHl7Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748428917; c=relaxed/relaxed;
	bh=4eqWfvPKnGs6dEV8KWDXklpALBHd/Gw82aMk/cyVxWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3XnfPecyujVzQQuVGl3rR/MqJfL/Rer+N9QGc7QTmiE2P3JhgehGH9Kw1hKiODU+TTl+qdpQhNNvYiKTpRE9jYCEv9hdYo3pU8zc/Bl1tYu6GZrV3vWT1NxWCKVXk30gYf5JRNgLdZwJArftlhC1OGqrOlIp1gHoYYeok3mmUlnYT88sWgZ77aI8HpK1aaCMnaMm6ChME5Wy1IwwssRcQCB7GmVPtR1sSgPaAB+FgAKejYIpF4vrQeG9zPbIGo+sBXYS2+fY9ztaPXJZ92wmJgtYCGlfNMXp0AH8krc3KSAvBBSEyDFRxG/q0On+3VUNosL6luX4nAXZzxhFQ7wFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zeL9y/Me; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zeL9y/Me;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6mK06gzlz2yZN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 20:41:56 +1000 (AEST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-442f4d40152so5987295e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748428914; x=1749033714; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eqWfvPKnGs6dEV8KWDXklpALBHd/Gw82aMk/cyVxWg=;
        b=zeL9y/MeJEC0x54NUlAeKoZCpXWVk1mHmJJjT8omkH8smiiDlTS+vJEMeEcnBJHwnf
         g6eGCqXPSG3tv1rqD2kK52yMiY3RNzG8WTbg+Q2T2ZKMNp7I0LqXqJ3Iyl8sDstMe3OU
         EYjhBgros8WUBnvwrCdX0Vd/A0mj2dmVDEE131AXBOZ0USrMeahaHbZ2O7YWt2i5nuFv
         7/I1r1hG3gWtr2W3swDgcAobRliW94CfNsS/1GC2iILVgkiYkLx/k6zSWba5wfswsQnD
         sjui6QXusXl6Z5a6/BBRa0bSwE4VG2NrelIhy/nrAI1Va/4z+dksEtZXGg/BFrKOOV26
         246A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748428914; x=1749033714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eqWfvPKnGs6dEV8KWDXklpALBHd/Gw82aMk/cyVxWg=;
        b=RuRUG/pyt4Ac+BIqA3gucH/Ja/N5H6Vjv6Hx+pSrejT+N9hhwb4ejw6qaSrXJH5Yyf
         YBwk/pkVn3lwxNXwBQybPMYY/opNJbRhmMtlF+rDJ1mb89QpAaakk7xjN+RJarcO6/t5
         ZYKydGo/yXI/KjUlWipobGpQ1to8yMxrCMcalFH/rZnt4gIZb8qnDQicHNQDV66mJffX
         KzQZfixyyXFeS9nCUnU/KvTl589f8SYYv79p2p4f58f8S70QL/4VCI+k/Ja1RUjSJzXL
         qvURIJ8yXrE2duXv7Ln9eoP82j3hF6VO/Qd0Wgd6phA26WC66PKONCMFjSuXxncY9lp+
         Vicw==
X-Forwarded-Encrypted: i=1; AJvYcCWxAJPZPMqFltdtqRHkFE7VLQ9n1x0m7kQmM9B6P7oIlNvxC02fCz/vbEpN6bl3HX0POH1Qd2T0vDjpwNw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxvacd7OYi51j/MDSrtmQe9T8BPrAI+QO9XvmBem+pPHz07J/61
	LGPdNcY6OwgMTmxkYIKCH2ezgMepJlhWD0E9nYRdE6yeqCNAGeUCbwnWRL5oOaqFv1Y=
X-Gm-Gg: ASbGnctfrANySi6eh9PJ7ZezlEP/dMQlvRKifqA+Vc7BdtSgGlH/c5agHzCJs5i9YGV
	5AHGg6Sj1uNK6SVsaugLCRW2dv+JIK2Z/CGxwAol+5LuJydguXCcz+pjVrVHBl/ZIUvxL6Hs8WQ
	gN9dY7HxcXmpw0pczvSVlITzq7mVEtGf+keFlO9sM2d/uQVsnFAky7VFQF0q965GaA49cOCY2M7
	rV0KyVdjTIr6CK5NlLLuCZcb+7WQ1b8QiWMks5CI1XN+qY2tDnG5Tx0sKweE6tgwMzF0J5hEgP9
	1hJRzaWBl2En8QQHBBSXDJntG0KupmG/bTUvDTvumiIDlK9SRWK1X3Y5QHBcrdAS6hbcNBs=
X-Google-Smtp-Source: AGHT+IHqXCD2Zw01Rwu6Y3SAvsPyX9CqAzleS6jGDMZtlcG8vOZNw6N59XBM2abO07C+micSLyXkEw==
X-Received: by 2002:a05:600c:3c96:b0:442:fac9:5e2f with SMTP id 5b1f17b1804b1-44c91cc3bc4mr57701585e9.2.1748428914050;
        Wed, 28 May 2025 03:41:54 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm17331595e9.17.2025.05.28.03.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:41:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 May 2025 12:41:03 +0200
Subject: [PATCH 07/17] pinctrl: bcm: Constify static 'pinctrl_desc'
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
Message-Id: <20250528-pinctrl-const-desc-v1-7-76fe97899945@linaro.org>
References: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
In-Reply-To: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Damien Le Moal <dlemoal@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Michal Simek <michal.simek@amd.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ABHNDkrQtwVI0zXe6lhvrQu7yt9ZZOAkqbbG+yTdfqk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNuhOkNkLKO2b0zaSv6TMTVNLJbk5UgYW6TFwg
 jxSUj1tHraJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDboTgAKCRDBN2bmhouD
 11tIEACA1WGvClNApJH2VgRBIboy0fFx1D+Y+FmGZZOWF2Lr82rwxR+M2b748c5TlSo9L++jcYr
 ZIR9lt4fSg+Yq5PmKkMDS5q4/ycD2Gcrmt5FcuzV3FHj/sG2BsZ4jRCEU2k0iCiKO2X1G5tK6zW
 cPFXEwBw4P08YI7Nu2Ke8Li1A5AQfcSHEssreNopxfynn3hcgemwVvxqcrgTgn7LKeyty9xxRFf
 Kn4F8QcbHnhFHps9umRJISETKamqcHenUST3DXcgLh47hR495Vcu58lodmhE2bAmutSDn5thYfe
 DoO8QFiiJskkUniuoDUTujIX6m6u+A6gWbXWz6beprpg3Xf05DIvGAxvrQw5iCf4HEKY+m10FEY
 43eDfDRbqF3WlANoUSuRFJNxtdKy/sbJjlSx/hgmTrohMHQuWXOua6jZ+L5S0pD+1WTBkGWJ+X1
 xFECehBz9isI0FWdgZrOiu7VDyAyjj+5nFjPqGNf1RCGXB4e9CQ3Wk3tawW1XnuZjfYNJxyX9LL
 wGPxw86wuE4eFNLbtUC/wyhkH0OYnduQDq8aidt0TCaFCrmsSv6hkV0VKDTnjl7D4cOaPPst08d
 I6jHmNloifkKQPK0TtV1VNakHBf8aR1kzbxtqVvWqR2c/B8gIYE1dpqeAFLbE4Pxl+6pc4QiYJN
 MPOQPOjSdZQleng==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local static 'struct pinctrl_desc' is not modified, so can be made
const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm4908.c | 2 +-
 drivers/pinctrl/bcm/pinctrl-ns.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm4908.c b/drivers/pinctrl/bcm/pinctrl-bcm4908.c
index f190e0997f1fa9fe8bf07fc3ae5700bc721e1651..12f7a253ea4d5bd0af5dbabc320fc2df32172e4f 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm4908.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm4908.c
@@ -456,7 +456,7 @@ static const struct pinmux_ops bcm4908_pinctrl_pmxops = {
  * Controller code
  */
 
-static struct pinctrl_desc bcm4908_pinctrl_desc = {
+static const struct pinctrl_desc bcm4908_pinctrl_desc = {
 	.name = "bcm4908-pinctrl",
 	.pctlops = &bcm4908_pinctrl_ops,
 	.pmxops = &bcm4908_pinctrl_pmxops,
diff --git a/drivers/pinctrl/bcm/pinctrl-ns.c b/drivers/pinctrl/bcm/pinctrl-ns.c
index 6bb2b461950bef5c420f1b250d48fcf6e907b98f..03bd01b4a945adf72445576a8a111f3c0637e095 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns.c
@@ -192,7 +192,7 @@ static const struct pinmux_ops ns_pinctrl_pmxops = {
  * Controller code
  */
 
-static struct pinctrl_desc ns_pinctrl_desc = {
+static const struct pinctrl_desc ns_pinctrl_desc = {
 	.name = "pinctrl-ns",
 	.pctlops = &ns_pinctrl_ops,
 	.pmxops = &ns_pinctrl_pmxops,

-- 
2.45.2


