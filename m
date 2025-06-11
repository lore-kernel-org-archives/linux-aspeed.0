Return-Path: <linux-aspeed+bounces-1366-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728EEC71134
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 06:15:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHFkc0h2pz30MZ;
	Wed, 11 Jun 2025 16:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749622504;
	cv=none; b=oCz7Um385gKSr0iQuV+BBig8h+CQIBzv9wOOzDrC+a/cD6aVI40w1mb2lBrSGW2VtbwKlwXo6Tk8+NUpWbU3kU3RHJAtYcrOcxXAljgWGSRUWfoe7Q4hBVjIJfZlMvYQKd1limbWCc4ffR6tENjwdE+UdLtayKrkoNWjVyxcDZYXbG0fDaz0jT45KNig4PkHzXbu9KARnTD2n3NEF0mgffXcLC+FmtnLTQ6o2jU5ohkBMz4MHfKP2e+htR76BnXm0h7CC97mGf9zlKq3aoPxb2Jp2rEl7ziPTrZg4JvFNdsAXiP7kQNKhI84A/E87BhomLIcZsfNicTvON5/jeJN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749622504; c=relaxed/relaxed;
	bh=3dpZC43mjqQSL2n4C7kbwZXGNoboHrOdh0nn9Na/CTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOkU8ErYrra4E5Qwbeq0+dWy3pQemVFwYz5xdU9Xz7pR681GjyyDSc2DTbbPuJE76Utn5XMkAJyz8pC/if318SBCga0mzzhSYbuKwf7pwnE2hjuC6JVXKeIYoXL+XZt7PF2fgVyOi8a9BJUrt/3Bx5EvUmyoRorRLQqaBSAzt2Gg44dG8q0I+pvgoxrhhEYbfGptUngYO9bLZwsiRpb2rzFbm/nszdaZDRayFHmbWn3lE7EDp61WQEmrzq0vw0wSXUroHb6q2raovrGw+1m47GTwpA+ZdjN3My8Z/W+vDx+EKN7YMceRBDr22yzNjzsY9m77qU0D/LaZCG8buq6D3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T/qRsNrE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T/qRsNrE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHFkZ5z2mz30Lt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 16:15:02 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3a524caf77eso25263f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749622500; x=1750227300; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dpZC43mjqQSL2n4C7kbwZXGNoboHrOdh0nn9Na/CTw=;
        b=T/qRsNrELg65IoNwsDOZspbJkcquO52a/uR/QUfr/yhwHBtwXz3qdIoyNYi01b35ha
         nPPq8cy8fo2hTONEdxWC3NIgNWGYU7FoEXmaoGSVpt8E40iiKlW4dREDI8nwXN8v+Nr1
         1BHgL8+hgHedzTa/I+JoY+HIutop4uyWuViLsVR18fqut3B0XfiMwu9fmfOdhvrx46rR
         3jJjRK9q2lYvQNqZdoS5lFPhmBOHY5xJ1FzE0SkCz0QsE78vk6ITHGLMAtJZsu4699Ny
         U3eBNoABf5wyzpwjTs4t3G7JY+sYmRyRJpqaII/7EMsky6+hYzWB0HnM0OjJn4bJwCNm
         eFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749622500; x=1750227300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dpZC43mjqQSL2n4C7kbwZXGNoboHrOdh0nn9Na/CTw=;
        b=H/juLsAYTyBIUUe9ZLcm5NpB9LOjCJlzktBn+U6LOMKq5Uhh7aPi0hK64kkoJxssP0
         /Z/g00BkGRArldxVCpCZLXaLPxorMN02vptdwVfe0ExsOeH4oZUfpQjeNkXz9GFa9znu
         XpWpeyY9711XECTpW8X5n1LBcLOjWivu4ToT62KSBNtUSIjWlID31XQ9MUX7+AK+CcFP
         ZONqaKsid2DLIIGpu0TRh3VynFhCHkbkUB7CGsgWNLNLtF9CzIXamvqRIua9Gccjx+n1
         6JClkT3fmRjV0EBR0C4YbCyD1rRsXVUofpa6B/BAJRDTGYCd28EeACQ0Ixy+fcYH4YLw
         sJCg==
X-Forwarded-Encrypted: i=1; AJvYcCVaLfMarHYA29MXTaYV2adaS414ngIRCa18Q4Xs9ZHIlUsHSdpbQQXCRao0N/f+Wqjfs2MMa6HEMrlE7lg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5MpRTa+7vHWtHTd/aWvlPEzuNLxE3wuW/E5gpdzWG65hGwDNM
	pgepUf4DyOXzF774MPlVV/2taSVFcn07YLeezehGkQFxsHFomrdHC5HpCMuaNyldChU=
X-Gm-Gg: ASbGncuDArIjvBXZlh6Cm+xJosIowjsRPxPoI6UUWL0w7DV5qhSqXdtTC27smAfaLHE
	AcPTkzW6Ouz3ANu9KInok7evJj32I1xLy5O6/E/LZT+7NnUx+t3Bk4D6OCDNqKyR/EzRQkCtBAd
	en6fqKy7P2If8fGbwcTJl9h6aQdyRonUn0Qu+Z0UMxHvwdDw7JpDdg7w56n4qNuDErjZ8D7XM0J
	R5C9xywAgSb3QSujGA5nABnLWzVmFkIYrMH0XNt52k6qiFT1p0+r/mNAIewXAsJBlYl/Gfl3NPs
	U/vha8Ee9f47SLPIJPcqjyQ5BrnQ0ETyDeDjFk+FCNWGSOjp6bA9MwQQTArk2GW3OLWL8iK4mtB
	t8d1tLxU=
X-Google-Smtp-Source: AGHT+IF+8CuDuQ4kf6mSJfvCZWVF2nwaA+1YTCjzunNZUTEkAuuOsBPS39QliHzSk5Dki6Jz/oOC5g==
X-Received: by 2002:a05:6000:2303:b0:3a3:61ab:86c2 with SMTP id ffacd0b85a97d-3a5586cba07mr495450f8f.7.1749622499974;
        Tue, 10 Jun 2025 23:14:59 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm14142791f8f.74.2025.06.10.23.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 23:14:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 11 Jun 2025 08:13:46 +0200
Subject: [PATCH v2 14/17] pinctrl: renesas: Move fixed assignments to
 'pinctrl_desc' definition
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
Message-Id: <20250611-pinctrl-const-desc-v2-14-b11c1d650384@linaro.org>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
In-Reply-To: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
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
 Lars Persson <lars.persson@axis.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Vladimir Zapolskiy <vz@mleia.com>, Michal Simek <michal.simek@amd.com>, 
 Emil Renner Berthing <kernel@esmil.dk>, 
 Jianlong Huang <jianlong.huang@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com, 
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+flFdO+wB1jUsuwdikr4oTVuYRRszXJESkvc2OSpc4Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoSR6rDKvTnvN7uWrkaR38SoKZ0JyrYcQvhwNCm
 /Q2Dq83gq6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEkeqwAKCRDBN2bmhouD
 14FeD/4ieFxDBp2aYLDtBNbnYfL2Cs+jpT6Ln8r5h8k7iHk7UFGxh34/qOVxHUd1z1j+6DSnp0k
 Ke/5Mro6a+xzalY4l7ACNl9imdQ2c1Gzag+tWv72+5bvxiGqP8bZqL0Jw0w0zL6sWtytvSfKqWO
 BGkf3r1wHCuVlIPAta/4/+GAbC20Gbc2yR+46ZTzVjBSbDxXW/1q9H0GZebt08ZazmjdzHE/iwQ
 yOIIz88jzvOLYWHjKSWOL9LVDAK3GfiN7ClK0jGoNFuFmO2a1M4sBDhcX1nN4xbAmki3aupM8VD
 Tbp64fJQ896BpCzX2DnW2WqwdYVIVxtQhOvao+W/kMTC/vQc7fZdCPminzsgcFpdUsZcDW2G926
 JLDEoqmjl02ySwXcMvRRMfWxQMIzssWYFwDj6Nh2J6pmtzUPPdgn9YfXzP3DVD+YWq0Pm/AM4yP
 dlmgwSbCV3chOEk9k2nb8UY+TUCRLUDb7xXTAxI+ozgWRWv1brSG/BEZtSHbO2rZA7payHinZB5
 KN6dtKpxFObljSM+pANXsnq2vMRtRUfm/WYw/vNvczM7tfhsCOgw9BUrYElrlhYMcw9LcmSOP7j
 iaQdnaIObg7tji/TYEvlN7XdOkUPn6SjarApXOtiu6bjHdimu695XgL8gl39wSEZZH7kmPQj7NA
 W7xp+qiZCZd9aTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Assign 'struct pinctrl_desc' .pins and .npins members in definition to
make clear that number of pins is fixed and have less code in the probe.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/renesas/pinctrl-rzn1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index d442d4f9981c908389407275522b936dbce294d3..fb874867dbfb9877b012988543ecbfd1bfb11270 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -680,6 +680,8 @@ static struct pinctrl_desc rzn1_pinctrl_desc = {
 	.pmxops = &rzn1_pmx_ops,
 	.confops = &rzn1_pinconf_ops,
 	.owner = THIS_MODULE,
+	.pins = rzn1_pins,
+	.npins = ARRAY_SIZE(rzn1_pins),
 };
 
 static int rzn1_pinctrl_parse_groups(struct device_node *np,
@@ -878,8 +880,6 @@ static int rzn1_pinctrl_probe(struct platform_device *pdev)
 
 	ipctl->dev = &pdev->dev;
 	rzn1_pinctrl_desc.name = dev_name(&pdev->dev);
-	rzn1_pinctrl_desc.pins = rzn1_pins;
-	rzn1_pinctrl_desc.npins = ARRAY_SIZE(rzn1_pins);
 
 	ret = rzn1_pinctrl_probe_dt(pdev, ipctl);
 	if (ret) {

-- 
2.45.2


