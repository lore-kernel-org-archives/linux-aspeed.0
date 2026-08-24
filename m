Return-Path: <linux-aspeed+bounces-4837-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD64C5DF9D
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 20:43:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTNCX1dwCz2y2c;
	Tue, 25 Aug 2026 06:43:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::464"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787604184;
	cv=none; b=lHOTZxG2RALxmAI7OWP3BYshwo/O+EBlce1xMxYrQ0RoabKXjOM9WSDQOVtaLvGIxq2yUZS5JGBifdtUws/04bCdxSNAd+pZZzKq4BKvTpEgKGtajAh8EQcuy31PGaWzzZNjud7bs57zTDx89yUIRPI3TnOci9a6FWmQIFUsDL3WgN0VCgZZC7afR1eApa58P2fhRHlBc1Z8qiDHt0oZ9rHstbTym15g8KKNV5jOIYlT6TWYtO6p8etlTJbb1JcLeymT+4M+gYW8M4Gadu3QO7DEp9E7gaHS7oxU2jAuXl3qRPo9xAaID7yX481OovjCltpe3nxewkbuvpAqjwHKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787604184; c=relaxed/relaxed;
	bh=mcuUPmwyWFcQCNdB2O8b5qx5f5wyg92+G28pjjhsAn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glpKCTbEpKcSCb5SMc5M22YRkypGC8vhNQkiml7CvbRuBi7npdZmF98JqQ7tLJnDifGSG+bmsGc7j7uY/4oOCgdNsCGeFLi+3ErF2MoU1m4FhpNYBI15ejexVICeIxAuq5lt/LQXX76VSTgA/q8KEYgzPE2+Z0B66wLT6tZaxBB0p/bNYYy2lmYnKMV36Uc8pLq6iwKSHTaQoWdLEqcdwqfsjRTWa7bM+WwcsML0LCBIfT9xuoU+iMYRhoahFEEzmU2wIwiVjfOMc/bgthDZUOdmlQCYu4xKazp/VcjEx1R8BGc9thRVZY1fCqNSI/k4HZt8aLvcPCv6dJFvb+09Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hsyT8FbC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::464; helo=mail-pf1-x464.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hsyT8FbC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::464; helo=mail-pf1-x464.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x464.google.com (mail-pf1-x464.google.com [IPv6:2607:f8b0:4864:20::464])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTNCV0qhxz2xr2
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 06:43:00 +1000 (AEST)
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so3128454b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 13:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787604178; x=1788208978;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mcuUPmwyWFcQCNdB2O8b5qx5f5wyg92+G28pjjhsAn8=;
        b=jAdEi5t/qgHaIOf3pda4XwO0xQCKBbDLyjaLsz1eN1BeF4gLD1bAVD+TVgf1o9wSVM
         mjnqn5XXICuDOh2nWdWYPhNaLhveVEHg7/5zGbaLDHnjJ2iDlDb8jYqn2Ju2JH0oKv05
         1coDvCFTeybWlJs2GVQUXiV3AoEkg09s0dze5fmikOEO1wugvprbHzyXopetKePeOUqM
         yTR0fPDZl55TkAF1hM7v0gvPSsbB6aBVh/+hFzvTB3J0A78FaPVpd0TX0p5gS1Vf1/iW
         2t0SRd46RLIx4lBf+AnkuRHVrpQi6ss5FpZfOBswVPaA2x8E6ib2IvcAHHuzDa1Pe5Jj
         LYew==
X-Forwarded-Encrypted: i=1; AHgh+RpMakNabcAkeesLEbLYz27mgaunm4NbjgT5/+o+CiOEw4ucBIYfXBJGcHFSnkW6YXvkeqOhNhbc+zh9LDg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lAg7Dd5se+ClZz9zOHrP3Z8Rtn3pVPGK9ykN29Y+YTrATlkrmu
	EWBz/AuTPqtY0HW/jICqE9SBn56HCSFQ1dwRQqfcFq8hhzUANwQ6j59v4FI+IcPo6TJ7/At4XP8
	CCvXHVRwHaqN74qVpOo+BA+7k6veellKg5XbGb6f/kHFNznsXoXDoR1FhNVBFWx9shYEZcydoHZ
	4PPM1zGBCv64Za/uxlTto7wOS1U/aNmKwSbEvIkfDXdcTFDhui8a5STf9h+cYG9/4Wkf9Qiomes
	zDEUiyzElo5/s/cOS+3NYf3JA==
X-Gm-Gg: AR+sD10q1QJ41LZj+x1+BIwm1Xc/bkoSbXJiZ7RDyBOAyrAyXSa33H9JrhEcyFWHPiG
	l5BhMqihJf6p6hE/vO5Jo+Al+A1v6IUw5V+VWHP9o/79zqbE236hM74Sfo3y1UAD8TaM3AUJFAm
	PTzyjxn3AH/LKyTl5pECQukWlow2thmB9215V04dmUWFnr32SPymRuVV35IvzOwZMAENO/YbKmK
	SdYw1Zw1WUlXVZaZaosDl2Ev+7n6zHDHIAnLneMoXUehVbYQ/4elSEmPJJAihcidjk8cT8BHJJv
	2wMiJNzn2bLJZlMjMrlDsH/ER2lSiscN+Mt9RajKLKo0Dup6s4OoMMaz4xsa4jlIvh2d1rrNgAa
	KfqtQ5JmqFY0KYkqAI6aRM219Lfce1ihC3qs7JXN7qKRXe18xoHxvT82VH4nSZrbVnotC/s8uzz
	T7U66wphGSsKQ+CK2BOUXIk7OPBVVszsY10PRRb74N
X-Received: by 2002:a05:6a00:2e84:b0:848:63c9:ee39 with SMTP id d2e1a72fcca58-851f9f8f207mr46571524b3a.12.1787604177934;
        Mon, 24 Aug 2026 13:42:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-85210950706sm3934768b3a.4.2026.08.24.13.42.57
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2026 13:42:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso5293069a12.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787604176; x=1788208976; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcuUPmwyWFcQCNdB2O8b5qx5f5wyg92+G28pjjhsAn8=;
        b=hsyT8FbC04JerDhRAivv1IjI23XNjcM2ks3A8uA1ajfbBjqIUZKO/YiDgaiSAsvEzX
         agP9ATsOFs72O0fd3wYuq2RNFzwdJd2IP326JETrrzssQNrtJOHmdjHiBW4B7+MJRtar
         uGfaHCWyZqmXqG1jGet3rYGAungXp1Mglxt2o=
X-Forwarded-Encrypted: i=1; AHgh+Rrho3e7Vbygp9/U4i5usRJCU3qAn1Hp/XLzCkf8QToyF3pbfEHMk8ZsgO6GfUAVt6mwORNyGH8+QEulSTU=@lists.ozlabs.org
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3cd2fdb9115mr56303209637.3.1787604175768;
        Mon, 24 Aug 2026 13:42:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:1583:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3cd2fdb9115mr56303100637.3.1787604175256;
        Mon, 24 Aug 2026 13:42:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909a51fsm26738210eec.4.2026.08.24.13.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 13:42:54 -0700 (PDT)
Message-ID: <e3f0202d-8bf6-49c7-a27a-7c6986772d37@broadcom.com>
Date: Mon, 24 Aug 2026 13:42:51 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/45] clk: bcm: iproc: Make sure clk_init_data is fully
 initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>, Linus Walleij <linusw@kernel.org>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>,
 David Lechner <david@lechnology.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Santosh Shilimkar <ssantosh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Prashant Gaikwad
 <pgaikwad@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, arm-scmi@vger.kernel.org, imx@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 soc@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <cover.1787239813.git.geert+renesas@glider.be>
 <28233748ddbdefe6a2eb18127d5cd5f72984ab62.1787239813.git.geert+renesas@glider.be>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <28233748ddbdefe6a2eb18127d5cd5f72984ab62.1787239813.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/21/26 01:53, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

